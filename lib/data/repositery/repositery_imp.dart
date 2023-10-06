import 'package:dartz/dartz.dart';
import 'package:new_project/app/constants.dart';
import 'package:new_project/data/data_source/local_data_source.dart';
import 'package:new_project/data/data_source/remote_data_source.dart';
import 'package:new_project/data/mapper/mapper.dart';
import 'package:new_project/data/network/error_handler.dart';

import 'package:new_project/data/network/failure.dart';

import 'package:new_project/data/network/requests.dart';

import 'package:new_project/domain/models.dart';

import '../../domain/repository.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == Constants.zero) {
          return Right(response.toDomain());
        } else {
          return left(Failure(1, response.message ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == Constants.zero) {
          return Right(response.toDomain());
        } else {
          return left(Failure(1, response.message ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == Constants.zero) {
          return Right(response.toDomain());
        } else {
          return left(Failure(1, response.message ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Home>> getHomeData() async {
    try {
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getHomeData();

          if (response.status == Constants.zero) {
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            return left(
                Failure(1, response.message ?? ResponseMessage.unknown));
          }
        } catch (error) {
          return left(ErrorHandler.handle(error).failure);
        }
      } else {
        return left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getDetails() async {
    try {
      final response = await _localDataSource.getDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getDetails();

          if (response.status == Constants.zero) {
            _localDataSource.saveDetailToCache(response);
            return Right(response.toDomain());
          } else {
            return left(
                Failure(1, response.message ?? ResponseMessage.unknown));
          }
        } catch (error) {

          return left(ErrorHandler.handle(error).failure);
        }
      } else {
        return left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

}


