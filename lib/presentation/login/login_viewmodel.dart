import 'dart:async';

import 'package:new_project/domain/use_case/login_use_case.dart';
import 'package:new_project/presentation/base/base_view_model.dart';
import 'package:new_project/presentation/common/freezed_data.dart';
import 'package:new_project/presentation/common/state_renderer/state_remderer.dart';
import 'package:new_project/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInput, LoginViewModelOutput{

  final StreamController _userNameStreamController = StreamController<String>.broadcast();
  final StreamController _passwordStreamController = StreamController<String>.broadcast();
  final StreamController _loginStreamController = StreamController<void>.broadcast();
  final StreamController isUserLoginSuccessfullyStreamController = StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    isUserLoginSuccessfullyStreamController.close();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _loginStreamController.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  inputState.add(ErrorState(
                      StateRendererType.popUpErrorState, failure.message))
                },
            (data)  {
              inputState.add(ContentState());
              isUserLoginSuccessfullyStreamController.add(true);
            });
  }

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream.map((password) =>_isPasswordValid(password)) ;

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map((userName) => _isUserNameValid(userName));

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllValid.add(null);
  }

  bool _isPasswordValid(String password){
    return password.isNotEmpty;
  }
  bool _isUserNameValid(String userName){
    return userName.isNotEmpty;
  }

  @override
  Sink get inputAreAllValid => _loginStreamController.sink;

  @override
  Stream<bool> get outputAreAllValid =>
      _loginStreamController.stream
          .map((_) => _areAllInputsValid());

  bool _areAllInputsValid(){
    return _isUserNameValid(loginObject.userName) && _isPasswordValid(loginObject.password);
  }
}



abstract class LoginViewModelInput{
  setUserName(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllValid;
}

abstract class LoginViewModelOutput{
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outputAreAllValid;
}