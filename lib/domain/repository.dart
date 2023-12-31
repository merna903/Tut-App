import 'package:new_project/data/network/requests.dart';
import 'package:dartz/dartz.dart';
import 'package:new_project/domain/models.dart';

import '../data/network/failure.dart';

abstract class Repository{

  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, Home>> getHomeData();
  Future<Either<Failure, StoreDetails>> getDetails();
}