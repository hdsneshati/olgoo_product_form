import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:olgooproductform/config/routing/routes.dart';
import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/core/utils/preferences_oprator.dart';

class DioErrorHandler {
  static String handleError(DioException error) {
    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          return "درخواست نامعتبر است. لطفاً اطلاعات ورودی را بررسی کنید.";
        case 401:
          {
            PreferencesOperator p = PreferencesOperator(locator());
            p.logout();
            // navigatorKey.currentContext?.goNamed("/splash");
            navigatorKey.currentContext?.goNamed('/login');
            return "احراز هویت ناموفق بود. لطفاً دوباره وارد شوید.";
          }
        case 403:
          {
            if (error.response!.data["errorCode"] == -4) {
              return "پیامکی ارسال نشد. لطفا اشتراک خود را تمدید کنید";
            } else {
              return "شما مجاز به انجام این عملیات نیستید.";
            }
          }
        case 404:
          return "مورد درخواستی یافت نشد.";
        case 500:
          return "خطای داخلی سرور. لطفاً بعداً دوباره امتحان کنید.";
        case 503:
          return "سرور در دسترس نیست. لطفاً بعداً تلاش کنید.";
        default:
          return "یک خطای ناشناخته رخ داده است. لطفاً دوباره تلاش کنید.";
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return "اتصال به سرور برقرار نشد. لطفاً اینترنت خود را بررسی کنید.";
    } else if (error.type == DioExceptionType.cancel) {
      return "درخواست لغو شد.";
    } else {
      return "یک خطای نامشخص رخ داده است.";
    }
  }
}
