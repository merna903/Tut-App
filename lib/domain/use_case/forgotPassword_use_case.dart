import 'package:dartz/dartz.dart';
import 'package:new_project/data/network/failure.dart';
import 'package:new_project/domain/repository.dart';
import 'package:new_project/domain/use_case/base_use_case.dart';


class ForgotPasswordUseCase implements BaseUseCase<String,String>{

  final Repository _repository;
  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async{
    return await _repository.forgotPassword(input);
  }
}