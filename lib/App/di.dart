import 'package:advanced_flutter/App/shared_pref.dart';
import 'package:advanced_flutter/data/Data_source/local_data_source.dart';
import 'package:advanced_flutter/data/Data_source/remote.dart';
import 'package:advanced_flutter/data/Network/app_api.dart';
import 'package:advanced_flutter/data/Network/dio_factory.dart';
import 'package:advanced_flutter/data/Network/newwork_info.dart';
import 'package:advanced_flutter/data/Repository/Repository_impl.dart';
import 'package:advanced_flutter/data/Repository/repositry.dart';
import 'package:advanced_flutter/data/Response/responses.dart';
import 'package:advanced_flutter/domain/usecase/Home_usecase.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:advanced_flutter/domain/usecase/storeDetailsUseecase.dart';
import 'package:advanced_flutter/presention/REgister/view_model/ds.dart';
import 'package:advanced_flutter/presention/REgister/view_model/view_model.dart';
import 'package:advanced_flutter/presention/login/view_model/login_view_model.dart';
import 'package:advanced_flutter/presention/main/pages/home/home_view_model.dart';
import 'package:advanced_flutter/presention/store_details/store_details_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  // app module , its a module where we put all generic di
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance(),instance()));

  
}

Future<void> initLoginModule() async {
  if(!GetIt.I.isRegistered<LoginUseCase>()){
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }

}
Future<void> initRegisterModule() async {
  if(!GetIt.I.isRegistered<RegisterUseCase>()){
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());

  }

}
Future<void> initHomeModule() async {
  if(!GetIt.I.isRegistered<HomeUseCase>()){
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));

  }

}
initStoreDetailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
            () => StoreDetailsUseCase(instance()));
    instance.registerFactory<StoreDetailsViewModel>(
            () => StoreDetailsViewModel(instance()));
  }
}

