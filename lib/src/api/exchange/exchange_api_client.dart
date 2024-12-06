import 'package:bookshare/src/api/api.dart';
import 'package:bookshare/src/models/exchange/exchange.dart';
import 'package:bookshare/src/models/response/exchange_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'exchange_api_client.g.dart';

/// A client for handling exchange-related API interactions.
///
/// This client provides methods to:
/// - Create a new exchange.
/// - Update the status of an existing exchange.
/// - Retrieve details of a specific exchange.
/// - List all exchanges related to a user.
///
/// The client interacts with the backend using HTTP requests, which return
/// `ExchangeResponse` or `ExchangeListResponse` instances with the results.
@RestApi(baseUrl: Api.baseUrl)
abstract class ExchangeApiClient {
  /// Creates an instance of [ExchangeApiClient] using a [Dio] client.
  ///
  /// - [dio]: The Dio client used for sending HTTP requests.
  /// - [baseUrl]: An optional parameter to override the base URL for API requests.
  ///
  /// Returns a new [ExchangeApiClient] instance.
  factory ExchangeApiClient(Dio dio, {String baseUrl}) = _ExchangeApiClient;

  /// Initiates a new book exchange with the specified [exchange] details.
  ///
  /// - [exchange]: An instance of [Exchange] containing the details of the exchange to be created.
  ///
  /// Sends a POST request to the API to create a new exchange. The response is
  /// wrapped in an [ExchangeResponse] instance, which contains the result of the creation.
  ///
  /// Returns a [Future] of [ExchangeResponse], representing the result of the creation request.
  @POST(Api.createExchange)
  Future<ExchangeResponse> createExchange(@Body() Exchange exchange);

  /// Updates the status of an existing exchange by its [exchangeId].
  ///
  /// - [exchangeId]: The unique identifier of the exchange whose status is to be updated.
  /// - [exchange]: The [Exchange] instance containing the updated status information.
  ///
  /// Sends a PUT request to the API to update the exchange's status. The response is
  /// wrapped in an [ExchangeResponse] instance, containing the result of the update.
  ///
  /// Returns a [Future] of [ExchangeResponse], representing the result of the update request.
  @PUT(Api.updateExchange)
  Future<ExchangeResponse> updateExchange(
    @Path('exchangeId') String exchangeId,
    @Body() Exchange exchange,
  );

  /// Retrieves the details of a specific exchange by its [exchangeId].
  ///
  /// - [exchangeId]: The unique identifier of the exchange to retrieve.
  ///
  /// Sends a GET request to the API to fetch the exchange details. The response is
  /// wrapped in an [ExchangeResponse] instance, containing the requested exchange details.
  ///
  /// Returns a [Future] of [ExchangeResponse], representing the result of the request.
  @GET(Api.showExchange)
  Future<ExchangeResponse> showExchange(
    @Path('exchangeId') String exchangeId,
  );

  /// Retrieves a list of exchanges related to a specific user by [userId].
  ///
  /// - [userId]: The unique identifier of the user whose exchanges are to be listed.
  ///
  /// Sends a GET request to the API to fetch the list of exchanges. The response is
  /// wrapped in an [ExchangeListResponse] instance, containing the list of exchanges.
  ///
  /// Returns a [Future] of [ExchangeListResponse], representing the result of the request.
  @GET(Api.listExchanges)
  Future<ExchangeListResponse> listExchanges(
    @Path('userId') String userId,
  );
}
