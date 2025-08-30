import 'package:dio/dio.dart';
import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/core/utils/api.interceptor.dart';
import 'package:olgooproductform/core/utils/api_constants.dart';
import 'package:olgooproductform/core/utils/preferences_oprator.dart';

class AuthApiProvider {
  final PreferencesOperator preferencesOperator = PreferencesOperator(locator());
  final DioClient _dio = locator<DioClient>();

  //
  Future<dynamic> callLogin(String phoneNumber) async {
    var url = "${ApiConstants.domainName}${ApiConstants.login}$phoneNumber";

    var response = await _dio.client.post(url);
    return response;
  }

  Future<dynamic> verifyOTP(String phoneNumber, String code) async {
    var url = "${ApiConstants.domainName}${ApiConstants.verfiyOtp}";
    var response = await _dio.client
        .post(url, data: {"phoneNumber": phoneNumber, "otp": code});
    return response;
  }

  Future<dynamic> registerUser(String username, String companyName) async {
    var url = "${ApiConstants.domainName}${ApiConstants.signup}";
    var response = await _dio.client.patch(
      url,
      data: {"name": username, "companyTitle": companyName},
    );

    return response;
  }

  static refreshToken() async {
    PreferencesOperator pr = PreferencesOperator(locator());
    var token = pr.getRefToken();
    Dio dio = Dio();
    String url = "${ApiConstants.domainName}${ApiConstants.refreshToken}";
    var respons = await dio.post(url,
        options: Options(headers: {'Authorization': "Bearer $token"}));
    return respons;
  }

  Future<dynamic> sendResignOTP() async{
     var url = "${ApiConstants.domainName}${ApiConstants.sendResignOtp}";
    var response = await _dio.client.post(url);
    return response;
  }

  Future<dynamic> verfiyResignOtp(String phoneNumber, String code)async {
    var url = "${ApiConstants.domainName}${ApiConstants.verfiyResignOtp}";
    var response = await _dio.client
        .post(url, data: {"phoneNumber": phoneNumber, "otp": code});
    return response;

  }
}
