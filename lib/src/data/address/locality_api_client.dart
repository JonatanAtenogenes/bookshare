import 'package:bookshare/src/models/response/locality_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../api.dart';

part 'locality_api_client.g.dart';

/// A client for handling locality-related API interactions.
///
/// This client allows retrieval of locality information based on a provided postal code.
@RestApi(baseUrl: Api.baseUrl)
abstract class LocalityApiClient {
  /// Creates an instance of [LocalityApiClient] using a [Dio] client.
  ///
  /// - [dio]: The Dio client to be used for making requests.
  /// - [baseUrl]: The base URL for the API, defaulting to [Api.baseUrl].
  factory LocalityApiClient(Dio dio, {String baseUrl}) = _LocalityApiClient;

  /// Retrieves locality information for a specified postal code.
  ///
  /// - [postalCode]: The postal code used to search for localities.
  /// Returns a [LocalityResponse] containing the list of localities associated with the given postal code.
  @GET(Api.localities)
  Future<LocalityResponse> retrieveLocalities(
    @Path('postalCode') int postalCode,
  );
}
