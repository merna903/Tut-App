import 'package:dartz/dartz.dart';
import 'package:new_project/data/network/failure.dart';
import 'package:new_project/domain/models.dart';
import 'package:new_project/domain/repository.dart';
import 'package:new_project/domain/use_case/base_use_case.dart';

import '../../data/network/requests.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication>{

  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
    return await _repository.login(LoginRequest(input.email,input.password));
  }
}

class LoginUseCaseInput{
  String email;
  String password;

  LoginUseCaseInput(this.email,this.password);
}