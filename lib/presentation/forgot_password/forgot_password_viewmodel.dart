import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:new_project/domain/use_case/forgotPassword_use_case.dart';
import 'package:new_project/presentation/base/base_view_model.dart';
import 'package:new_project/presentation/common/state_renderer/state_remderer.dart';
import 'package:new_project/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput{

  final StreamController _emailStreamController = StreamController<String>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  String emailAddress = '';

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  @override
  void dispose() {
    _emailStreamController.close();
    super.dispose();
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));
    (await _forgotPasswordUseCase.execute(emailAddress))
        .fold(
            (failure) => {
          inputState.add(ErrorState(
              StateRendererType.popUpErrorState, failure.message))
        },
            (data)  {
              inputState.add(SuccessState(data));
        });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Stream<bool> get outIsEmailValid => _emailStreamController.stream.map((email) => EmailValidator.validate(email));

  @override
  setEmail(String email) {
    inputEmail.add(email);
    emailAddress = email;
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

}


abstract class ForgotPasswordViewModelInput{
  setEmail(String email);

  forgotPassword();

  Sink get inputEmail;
}

abstract class ForgotPasswordViewModelOutput{
  Stream<bool> get outIsEmailValid;
}