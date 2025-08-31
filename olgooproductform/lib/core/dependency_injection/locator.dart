import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:olgooproductform/core/utils/api.interceptor.dart';
import 'package:olgooproductform/core/utils/preferences_oprator.dart';
import 'package:olgooproductform/feature/date/auth/impl/auth_impl_repository.dart';
import 'package:olgooproductform/feature/date/auth/src/remote/auth.api.dart';
import 'package:olgooproductform/feature/date/product/impl/product_impl_repository.dart';
import 'package:olgooproductform/feature/date/product/src/remote/product.api.dart';
import 'package:olgooproductform/feature/domain/auth/usecase/auth.usecase.dart';
import 'package:olgooproductform/feature/domain/product/usecase/product_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

locatorSetup() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<PreferencesOperator>(
      () => PreferencesOperator(sharedPreferences));

  locator.registerLazySingleton<DioClient>(() => DioClient(Dio(), locator()));
  //!local storage--------------------------------------------------------------
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<AuthApiProvider>(AuthApiProvider());
  locator.registerSingleton<ProductApiProvider>(ProductApiProvider());

  //! repositoreis--------------------------------------------------------------
  locator.registerSingleton<AuthRepositoryIMPL>(
      AuthRepositoryIMPL(apiProvider: locator()));
   locator.registerSingleton<ProductRepositoryIMPL>(ProductRepositoryIMPL());

  //!usecase--------------------------------------------------------------------
  locator.registerSingleton<AuthUseCases>(AuthUseCases(locator()));
   locator.registerSingleton<ProductUseCase>(ProductUseCase());

}







