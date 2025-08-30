import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:olgooproductform/config/routing/routes.dart';
import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/core/resource/data_state.dart';
import 'package:olgooproductform/core/utils/error.handler.dart';
import 'package:olgooproductform/core/utils/preferences_oprator.dart';
import 'package:olgooproductform/feature/domain/auth/entity/user.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../src/remote/auth.api.dart';

class AuthRepositoryIMPL {
  AuthApiProvider apiProvider;
  PreferencesOperator preferencesOperator =
      PreferencesOperator(locator<SharedPreferences>());

  AuthRepositoryIMPL({required this.apiProvider});

  void logout() {
    preferencesOperator.logout();
    // navigatorKey.currentContext?.goNamed("/splash");
    navigatorKey.currentContext?.goNamed("/login");
  }

//!-------------------------------------------------------

  Future<DataState<dynamic>> login(String phone) async {
    try {
      Response response = await apiProvider.callLogin(phone);
      if (response.statusCode == 201) {
        return SuccessData(response.data);
      } else {
        return const FailedData("خطایی پیش اومده");
      }
    } on DioException catch (e) {
      String errorMassage = DioErrorHandler.handleError(e);
      return FailedData(errorMassage);
    }
  }

  Future<DataState<UserEntity>> registerUser(
      String username, String companyName) async {
    try {
      Response response = await apiProvider.registerUser(username, companyName);
      if (response.statusCode == 200) {
        UserEntity user = UserEntity.fromJsonWithOutTokens(response.data);
        //update
        preferencesOperator.updateUserData(user);
        return SuccessData(user);
      } else {
        return const FailedData("خطایی پیش اومده");
      }
    } on DioException catch (e) {
      String errorMassage = DioErrorHandler.handleError(e);
      return FailedData(errorMassage);
    }
  }

  Future<DataState<UserEntity>> verifyOTP(
      String phoneNumber, String code) async {
    try {
      Response response = await apiProvider.verifyOTP(phoneNumber, code);
      if (response.statusCode == 201) {
        UserEntity user = UserEntity.fromJson(response.data);
        preferencesOperator.saveUserData(user);
        return SuccessData(user);
      } else {
        return const FailedData("خطایی پیش اومده");
      }
    } on DioException catch (e) {
      String errorMassage = DioErrorHandler.handleError(e);
      return FailedData(errorMassage);
    }
  }

  void reciveGiftSubscription() {
    preferencesOperator.recivedGift();
  }

  Future<DataState<dynamic>> sendResignOtp()async {
    try {
      Response response = await apiProvider.sendResignOTP();
      if (response.statusCode == 201) {
       DataState<dynamic> data = const SuccessData("کد تایید برای شما ارسال شد");
        // navigatorKey.currentContext?.goResignOtp();
        //navigatorKey.currentContext?.toOtpScreen(response.data['phoneNumber']);
        navigatorKey.currentContext?.goNamed("/signup");
        return data;
      } else {
        return const FailedData("خطایی پیش اومده");
      }
    } on DioException catch (e) {
      String errorMassage = DioErrorHandler.handleError(e);
      return FailedData(errorMassage);
    }
  }

  verfiyResignOtp(String phoneNumber, String code) async {
  try {
      Response response = await apiProvider.verfiyResignOtp(phoneNumber, code);
      if (response.statusCode == 201) {
        return const SuccessData('حساب شما با موفقیت حذف شد');
      } else {
        return const FailedData("خطایی پیش اومده");
      }
    } on DioException catch (e) {
      String errorMassage = DioErrorHandler.handleError(e);
      return FailedData(errorMassage);
    }
  }
}
