import 'package:bookshare/src/data/address/locality_api_client.dart';
import 'package:bookshare/src/data/interceptors/token_interceptor.dart';
import 'package:bookshare/src/models/address/locality.dart';
import 'package:bookshare/src/models/api/locality_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A state notifier class that manages the state of a list of [Locality] objects.
///
/// This class is responsible for retrieving localities based on a given postal code
/// and updating its state accordingly. It uses the [LocalityApiClient] to perform
/// API calls for locality data.
///
/// The state is represented as a list of [Locality] objects, initialized with
/// an empty locality entry.
class ApiLocalitiesNotifier extends StateNotifier<LocalityResponse> {
  /// Creates an instance of [ApiLocalitiesNotifier].
  ///
  /// Takes a [LocalityApiClient] as a parameter to perform API requests.
  ApiLocalitiesNotifier(this._localityApiClient)
      : super(LocalityResponse.empty());

  final LocalityApiClient _localityApiClient;

  /// Retrieves a list of localities for the given [postalCode].
  ///
  /// This method performs an API call using the [LocalityApiClient] to
  /// fetch the localities associated with the specified postal code.
  /// On successful retrieval, the state is updated with the fetched
  /// list of localities. If an error occurs, it is rethrown for handling
  /// at the caller level.
  ///
  /// Parameters:
  /// - [postalCode]: An integer representing the postal code for which
  ///   localities are to be retrieved.
  ///
  /// Throws:
  /// - [Exception]: If the retrieval process encounters an error.
  Future<void> retrieveLocalities(int postalCode) async {
    try {
      final localitiesResponse =
          await _localityApiClient.retrieveLocalities(postalCode);
      state = localitiesResponse;
    } catch (e) {
      rethrow;
    }
  }
}

/// A provider for the [ApiLocalitiesNotifier].
///
/// This provider initializes the notifier with a [LocalityApiClient]
/// that is configured with [Dio] and its interceptors. The provider
/// exposes the state of the notifier, which is a list of [Locality]
/// objects.
final apiLocalitiesNotifierProvider =
    StateNotifierProvider<ApiLocalitiesNotifier, LocalityResponse>(
  (ref) {
    final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    // dio.interceptors.add(TokenInterceptorInjector());
    dio.interceptors.addAll(List.of([
      TokenInterceptorInjector(),
      LogInterceptor(
        responseBody: true,
        error: true,
      ),
    ]));
    return ApiLocalitiesNotifier(LocalityApiClient(dio));
  },
);
