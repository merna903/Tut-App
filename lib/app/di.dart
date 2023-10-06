import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_project/app/app_refrances.dart';
import 'package:new_project/data/data_source/local_data_source.dart';
import 'package:new_project/data/data_source/remote_data_source.dart';
import 'package:new_project/data/network/app_api.dart';
import 'package:new_project/data/network/dio_factory.dart';
import 'package:new_project/data/network/network_info.dart';
import 'package:new_project/data/repositery/repositery_imp.dart';
import 'package:new_project/domain/repository.dart';
import 'package:new_project/domain/use_case/forgotPassword_use_case.dart';
import 'package:new_project/domain/use_case/home_use_case.dart';
import 'package:new_project/domain/use_case/login_use_case.dart';
import 'package:new_project/domain/use_case/register_use_case.dart';
import 'package:new_project/domain/use_case/store_details_use_case.dart';
import 'package:new_project/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:new_project/presentation/login/login_viewmodel.dart';
import 'package:new_project/presentation/main/pages/home/home_viewmodel.dart';
import 'package:new_project/presentation/register/register_viewmodel.dart';
import 'package:new_project/presentation/store_details/store_details_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImpl());

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(),instance()));
}

Future<void> initLoginModule() async {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

Future<void> initForgotPasswordModule() async {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

Future<void> initRegisterModule() async {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
  }
}

Future<void> initHomeModule() async {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(() => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(() => StoreDetailsViewModel(instance()));
  }
}
