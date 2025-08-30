import 'dart:async';
import 'package:dio/dio.dart';
import 'package:olgooproductform/core/utils/api_constants.dart';
import 'error.handler.dart';
import 'preferences_oprator.dart';

class DioClient {
  final Dio _dio;
  final PreferencesOperator _preferences;
  bool _isRefreshing = false;
  final List<Function()> _retryQueue = [];

  DioClient(this._dio, this._preferences) {
    _dio.options.baseUrl = ApiConstants.domainName;
    _dio.options.headers['Content-Type'] = "application/json";
    _dio.options.headers['Accept'] = 'application/json';
    _dio.interceptors.add(_createInterceptor());
  }

  Dio get client => _dio;

  //handle 401 error
  Future<void> _handle401Error(
      DioException error, ErrorInterceptorHandler handler) async {
    final requestOptions = error.requestOptions;

    if (_isRefreshing) {
      await _waitForTokenRefresh();
    } else {
      _isRefreshing = true;
      try {
        bool isTokenRefreshed = await _refreshAccessToken();

        if (isTokenRefreshed) {
          print("Token refreshed successfully");
          final newToken = _preferences.getAccToken();

          print("NEW ACC TOKEN IN PREF : ${newToken.toString()}");
          requestOptions.headers['Authorization'] = "Bearer $newToken";
          final response = await _dio.fetch(requestOptions);
          handler.resolve(response);
        } else {
          handler.reject(error);
        }
      } catch (e) {
        print(e.toString());
        print("Status code : ${error.response?.statusCode}");
        print("response data : ${error.response?.data}");

        handler.reject(error);
      } finally {
        _isRefreshing = false;
        _runQueuedRequests();
      }
    }
  }

  Future<void> _waitForTokenRefresh() async {
    final completer = Completer<void>();
    _retryQueue.add(completer.complete);
    return completer.future;
  }

  void _runQueuedRequests() {
    for (var retry in _retryQueue) {
      retry();
    }
    _retryQueue.clear();
  }

  //refresh token method
  Future<bool> _refreshAccessToken() async {
    print("Refreshing access token");
    String? refreshToken = await _preferences.getRefToken();
    print("old REF TOKEN : ${refreshToken.toString()}");
    if (refreshToken == null) {
      return false;
    }
    String url = "${ApiConstants.domainName}${ApiConstants.refreshToken}";
    try {
      Dio d = Dio();
      final response = await d.post(
        url,
        options: Options(headers: {'Authorization': "Bearer $refreshToken"}),
      );
      if (response.statusCode == 201 && response.data != null) {
        final newAccessToken = response.data['access_token'] ?? "";
        final newRefreshToken = response.data['refresh_token'] ?? "";
        if (newAccessToken.isNotEmpty && newRefreshToken.isNotEmpty) {
          print("\n new ACC TOKEN : ${newAccessToken.toString()}");
          print("\n new REF TOKEN : ${newRefreshToken.toString()}");
          await _preferences.refreshAccessToken(
              newAccessToken, newRefreshToken);

          return true;
        }
      }
    } on DioException {
      return false;
    }
    return false;
  }

  InterceptorsWrapper _createInterceptor() {
    return InterceptorsWrapper(
      //? ON REQUEST
      onRequest: (options, handler) async {
        print("Request URL: ${options.uri}");
        String? token = _preferences.getAccToken();
        if (token != null) {
          options.headers['Authorization'] = "Bearer $token";
        }
        options.headers['Connection'] = 'keep-alive';
        return handler.next(options);
      },
      //* ON RESPONSE
      onResponse: (response, handler) {
        return handler.next(response);
      },
      //! ON ERROR
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          print("access token expired");
          // handle 401 errors
          return _handle401Error(error, handler);
        }

        print(error);
        // handle other errors
        String errorMessage = DioErrorHandler.handleError(error);

        return handler.reject(DioException(
          requestOptions: error.requestOptions,
          response: error.response,
          error: errorMessage,
          type: error.type,
        ));
      },
    );
  }
}
