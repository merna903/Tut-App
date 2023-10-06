import 'package:dartz/dartz.dart';
import 'package:new_project/data/network/failure.dart';
import 'package:new_project/domain/models.dart';
import 'package:new_project/domain/repository.dart';
import 'package:new_project/domain/use_case/base_use_case.dart';


class StoreDetailsUseCase implements BaseUseCase<void, StoreDetails>{

   Repository repository;
  StoreDetailsUseCase(this.repository);
  @override
  Future<Either<Failure, StoreDetails>> execute(void input) async{
    return await repository.getDetails();
  }
}