import 'package:new_project/data/network/app_api.dart';
import 'package:new_project/data/network/requests.dart';

import '../responses/responses.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getDetails();
}

class RemoteDataSourceImpl implements RemoteDataSource{

  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServiceClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async{
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.userName,
        registerRequest.countryMobileCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password,
        "");
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClient.dataHome();
  }

  @override
  Future<StoreDetailsResponse> getDetails() async {
    return await _appServiceClient.getDetails();
  }

}