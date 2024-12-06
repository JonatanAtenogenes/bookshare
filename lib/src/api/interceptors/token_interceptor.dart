import 'package:bookshare/src/models/auth/authorization_token.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Interceptor to handle token management in API requests.
///
/// This class, `TokenInterceptor`, intercepts the response after a successful
/// authentication request to retrieve the `access_token` and store it locally
/// in `SharedPreferences`.
///
/// This interceptor is designed to be used with Dio for managing authentication tokens.
class TokenInterceptor extends InterceptorsWrapper {
  /// Intercepts the response to store the authentication token.
  ///
  /// If the response status code is 200 (success), the access token is extracted
  /// from the response api and saved in `SharedPreferences` for future requests.
  ///
  /// [response] is the HTTP response intercepted after a successful request.
  /// [handler] is the `ResponseInterceptorHandler` that completes the response handling.
  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode != 200) {
      return;
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final authToken = AuthorizationToken(
      accessToken: response.data['data']['access_token'],
    );

    sharedPreferences.setString('access_token', authToken.toString());

    super.onResponse(response, handler);
  }
}

/// Interceptor to inject the token into outgoing requests.
///
/// The `TokenInterceptorInjector` class retrieves the stored `access_token`
/// from `SharedPreferences` and attaches it to the `Authorization` header of each
/// outgoing request. It ensures that all requests carry the token for authentication.
class TokenInterceptorInjector extends InterceptorsWrapper {
  /// Intercepts outgoing requests to add the authentication token.
  ///
  /// Retrieves the token from `SharedPreferences` and sets it as the
  /// `Authorization` header. Additionally, the `Accept` header is set to
  /// `application/json` to specify JSON content.
  ///
  /// [options] contains the request options that can be modified.
  /// [handler] is the `RequestInterceptorHandler` that completes the request handling.
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString('access_token');
    options.headers['Authorization'] = accessToken;
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }
}
