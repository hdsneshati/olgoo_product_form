import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:olgooproductform/core/utils/api.interceptor.dart';
import 'package:olgooproductform/core/utils/preferences_oprator.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

locatorSetup() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<PreferencesOperator>(
      () => PreferencesOperator(sharedPreferences));

  locator.registerLazySingleton<DioClient>(() => DioClient(Dio(), locator()));
  //!local storage--------------------------------------------------------------
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
 // locator.registerSingleton<AuthApiProvider>(AuthApiProvider());

  //! repositoreis--------------------------------------------------------------
//  locator.registerSingleton<AuthRepositoryIMPL>(
   //   AuthRepositoryIMPL(apiProvider: locator()));
 
  //!usecase--------------------------------------------------------------------
  //locator.registerSingleton<AuthUseCases>(AuthUseCases(locator()));
 
}





