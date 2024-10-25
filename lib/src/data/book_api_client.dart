import 'package:bookshare/src/data/api.dart';
import 'package:bookshare/src/models/models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'book_api_client.g.dart'; // Required for Retrofit code generation

@RestApi(baseUrl: Api.baseUrl)
abstract class IsbnBookApiClient {
  factory IsbnBookApiClient(Dio dio, {String baseUrl}) = _IsbnBookApiClient;

  @GET('${Api.isbnBook}{isbn}')
  Future<Book> getIsbnBook(
    @Path('isbn') String isbn,
  );
}
