import 'package:dartz/dartz.dart';
import 'package:new_project/data/network/failure.dart';
import 'package:new_project/domain/models.dart';
import 'package:new_project/domain/repository.dart';
import 'package:new_project/domain/use_case/base_use_case.dart';


class HomeUseCase implements BaseUseCase<void, Home>{

  final Repository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, Home>> execute(_) async{
    return await _repository.getHomeData();
  }
}