import 'package:bookshare/src/data/api.dart';
import 'package:bookshare/src/models/exchange/exchange.dart';
import 'package:bookshare/src/models/response/exchange_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'exchange_api_client.g.dart';

/// A client for handling exchange-related API interactions.
///
/// This client provides methods to create a new exchange and update the status
/// of an existing exchange by interacting with the backend through HTTP requests.
@RestApi(baseUrl: Api.baseUrl)
abstract class ExchangeApiClient {
  /// Creates an instance of [ExchangeApiClient] using a [Dio] client.
  factory ExchangeApiClient(Dio dio, {String baseUrl}) = _ExchangeApiClient;

  /// Initiates a new book exchange with the specified [exchange] details.
  ///
  /// - [exchange]: An instance of [Exchange] containing the exchange details.
  /// Returns an [ExchangeResponse] indicating the result of the creation request.
  @POST(Api.createExchange)
  Future<ExchangeResponse> createExchange(@Body() Exchange exchange);

  /// Updates the status of an existing exchange.
  ///
  /// - [exchangeId]: The unique identifier of the exchange to be updated.
  /// - [exchange]: An instance of [Exchange] containing the new status.
  /// Returns an [ExchangeResponse] indicating the result of the status update.
  @PATCH(Api.updateExchangeStatus)
  Future<ExchangeResponse> updateExchangeStatus(
    @Path('exchangeId') String exchangeId,
    @Body() Exchange exchange,
  );
}
