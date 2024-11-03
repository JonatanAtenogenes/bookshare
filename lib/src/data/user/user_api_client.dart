import 'dart:io';

import 'package:bookshare/src/data/api.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api_client.g.dart';

@RestApi(baseUrl: Api.baseUrl)
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String baseUrl}) = _UserApiClient;

  @PUT(Api.updatePersonalInformation)
  Future<void> updatePersonalInformation(@Path('id') String id);

  @POST(Api.uploadProfileImage)
  @MultiPart()
  Future<void> uploadProfileImage(
    @Part(name: 'file') File file,
    @Part(name: 'userId') String userId,
  );
}
