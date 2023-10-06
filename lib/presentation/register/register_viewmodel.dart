import 'dart:async';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:new_project/domain/use_case/register_use_case.dart';
import 'package:new_project/presentation/base/base_view_model.dart';
import 'package:new_project/presentation/common/freezed_data.dart';
import 'package:new_project/presentation/common/state_renderer/state_remderer.dart';
import 'package:new_project/presentation/common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _profilePictureStreamController =
      StreamController<File>.broadcast();
  final StreamController _registerStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserRegisterSuccessfullyStreamController =
      StreamController<bool>();

  var registerObject = RegisterObject("", "", "", "", "", "");

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  @override
  void dispose() {
    isUserRegisterSuccessfullyStreamController.close();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _emailStreamController.close();
    _mobileNumberStreamController.close();
    _registerStreamController.close();
    _profilePictureStreamController.close();
    super.dispose();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerObject.userName,
            registerObject.countryMobileCode,
            registerObject.mobileNumber,
            registerObject.email,
            registerObject.password,
            registerObject.profilePicture)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.popUpErrorState, failure.message))
                }, (data) {
      inputState.add(ContentState());
      isUserRegisterSuccessfullyStreamController.add(true);
    });
  }

  bool _isPasswordValid(String password) {
    return password.length >= 3;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isEmailValid(String email) {
    return EmailValidator.validate(email);
  }

  bool _isMobileNumberValid(String mobile) {
    return mobile.length >= 9;
  }

  bool _isProfilePictureValid(String picture) {
    return !picture.isNotEmpty;
  }

  bool _isCountryCodeValid(String code) {
    return code.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUserNameValid(registerObject.userName) &&
        _isPasswordValid(registerObject.password) &&
        _isCountryCodeValid(registerObject.countryMobileCode) &&
        _isEmailValid(registerObject.email) &&
        _isMobileNumberValid(registerObject.mobileNumber);
  }

  @override
  Sink get inputAreAllValid => _registerStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((number) => _isMobileNumberValid(number));

  @override
  Stream<File> get outProfilePicture =>
      _profilePictureStreamController.stream.map((picture) => picture);

  @override
  Stream<bool> get outputAreAllValid =>
      _registerStreamController.stream.map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    inputAreAllValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    inputAreAllValid.add(null);
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    inputAreAllValid.add(null);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (_isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    inputAreAllValid.add(null);
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    inputAreAllValid.add(null);
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (_isProfilePictureValid(profilePicture.path)) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    inputAreAllValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  setUserName(String userName);

  setCountryCode(String countryCode);

  setMobileNumber(String mobileNumber);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File profilePicture);

  register();

  Sink get inputUserName;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfilePicture;

  Sink get inputAreAllValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsMobileNumberValid;

  Stream<bool> get outIsEmailValid;

  Stream<bool> get outIsPasswordValid;

  Stream<File> get outProfilePicture;

  Stream<bool> get outputAreAllValid;
}
