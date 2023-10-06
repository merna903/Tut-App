import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:new_project/data/network/failure.dart';
import 'package:new_project/presentation/resources/string_manager.dart';

class ErrorHandler implements Exception{
  late Failure failure;
  ErrorHandler.handle(dynamic error){
    if(error is DioException)
      {
        failure = _handleError(error);
      }
    else
      {
        failure = DataSource.unknown.getFailure();
      }
  }
  Failure _handleError(DioException error)
  {
    switch(error.type){
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioExceptionType.badCertificate:
        return DataSource.badRequest.getFailure();
      case DioExceptionType.badResponse:
        return DataSource.badRequest.getFailure();
      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.noInternetConnection.getFailure();
      case DioExceptionType.unknown:
        return DataSource.unknown.getFailure();
      default:
        return Failure(error.response?.statusCode ?? ResponseCode.unknown, error.response?.statusMessage ?? ResponseMessage.unknown );
    }
  }
}


enum DataSource{
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  unknown
}

extension DataSourceExtension on DataSource{
  Failure getFailure(){
    switch(this){
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent,ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest,ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden,ResponseMessage.forbidden);
      case DataSource.unauthorised:
        return Failure(ResponseCode.unauthorised,ResponseMessage.unauthorised);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound,ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(ResponseCode.connectTimeout,ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.receiveTimeout,ResponseMessage.receiveTimeout);
      case DataSource.receiveTimeout:
        return Failure(ResponseCode.cancel,ResponseMessage.cancel);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout,ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError,ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,ResponseMessage.noInternetConnection);
      default:
        return Failure(ResponseCode.unknown,ResponseMessage.unknown);
    }
  }
}

class ResponseCode{
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorised = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;


  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int unknown = -7;
}

class ResponseMessage{
  static  String success = AppStrings.success1.tr();
  static String noContent = AppStrings.noContent.tr();
  static String badRequest = AppStrings.badRequestError.tr();
  static String forbidden = AppStrings.forbiddenError.tr();
  static String unauthorised = AppStrings.unauthorizedError.tr();
  static String notFound = AppStrings.notFoundError.tr();
  static String internalServerError = AppStrings.internalServerError.tr();


  static String connectTimeout = AppStrings.timeoutError.tr();
  static String cancel = AppStrings.cancel.tr();
  static String receiveTimeout = AppStrings.timeoutError.tr();
  static String sendTimeout = AppStrings.timeoutError.tr();
  static String cacheError = AppStrings.cacheError.tr();
  static String noInternetConnection = AppStrings.noInternetError.tr();
  static String unknown = AppStrings.defaultError.tr();
}