import 'package:bookshare/src/models/address/locality.dart';
import 'package:bookshare/src/models/api/locality_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../api.dart';

part 'locality_api_client.g.dart';

@RestApi(baseUrl: Api.baseUrl)
abstract class LocalityApiClient {
  factory LocalityApiClient(Dio dio, {String baseUrl}) = _LocalityApiClient;

  @GET(Api.localities)
  Future<LocalityResponse> retrieveLocalities(
    @Path('postalCode') int postalCode,
  );
}
