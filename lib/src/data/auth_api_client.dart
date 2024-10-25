import 'package:bookshare/src/data/api.dart';
import 'package:bookshare/src/models/models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_api_client.g.dart'; // Required for Retrofit code generation

@RestApi(baseUrl: Api.baseUrl)
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @GET(Api.csrfToken)
  Future<CsrfToken> getCsrfToken();
}
