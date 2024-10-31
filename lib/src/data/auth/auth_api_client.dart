import 'package:bookshare/src/data/api.dart';
import 'package:bookshare/src/models/models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart'; // Required for Retrofit code generation

@RestApi(baseUrl: Api.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @GET(Api.csrfToken)
  Future<CsrfToken> getCsrfToken();

  @POST(Api.register)
  Future<User> registerUser(@Body() User user);

  @POST(Api.login)
  Future<User> loginUser(@Body() User user);

  @POST(Api.logout)
  Future<void> logoutUser();
}
