import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_project/app/app_refrances.dart';
import 'package:new_project/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String appJson ="application/json";
const String contentType ="content-type";
const String accept ="accept";
const String authorization ="authorization";
const String defaultLanguage ="language";
class DioFactory{
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);


  Future<Dio> getDio() async{
    Dio dio = Dio();

    String language = await _appPreferences.getAppLanguage();
    int timeout = 60*1000;
    Map<String, String> headers={
      contentType: appJson,
      accept: appJson,
      authorization: "send token here",
      defaultLanguage: language,
    };

    dio.options = BaseOptions(
      baseUrl: Constants.BaseURL,
      headers: headers,
      receiveTimeout: Duration(seconds: timeout),
      sendTimeout: Duration(seconds: timeout) ,
    );

    kReleaseMode? debugPrint("no logs in release mode") : dio.interceptors.add(PrettyDioLogger(
        requestHeader:true ,
        requestBody:true ,
        responseHeader:true
    ));
    return dio;
  }
}