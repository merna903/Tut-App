import 'package:dio/dio.dart';
import 'package:new_project/app/constants.dart';
import 'package:retrofit/http.dart';

import '../responses/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.BaseURL)
abstract class AppServiceClient{
  // ignore: non_constant_identifier_names
  factory AppServiceClient(Dio dio,{String? baseUrl}) = _AppServiceClient;
  @POST("/customer/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password
      );

  @POST("/customer/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(
      @Field("email") String email
      );

  @POST("/customer/register")
  Future<AuthenticationResponse> register(
      @Field("user_name") String name,
      @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_number") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profile_picture") String profilePicture,
      );

  @GET("/home")
  Future<HomeResponse> dataHome();

  @GET("/storeDetails/1")
  Future<StoreDetailsResponse> getDetails();
}