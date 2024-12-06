import 'package:bookshare/src/api/api.dart';
import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'isbn_book_api_client.g.dart'; // Required for Retrofit code generation

/// API client for accessing book information via ISBN or author.
///
/// This client is used to retrieve book api from the server using the provided [Api] routes.
/// It is built on Retrofit to simplify API integration with Dio.
@RestApi(baseUrl: Api.baseUrl)
abstract class IsbnBookApiClient {
  /// Creates an instance of [IsbnBookApiClient] using the given [Dio] instance.
  ///
  /// - Parameters:
  ///   - [dio]: The Dio client for making HTTP requests.
  ///   - [baseUrl]: An optional parameter to override the default base URL.
  factory IsbnBookApiClient(Dio dio, {String baseUrl}) = _IsbnBookApiClient;

  /// Fetches a book's details by its ISBN.
  ///
  /// Calls the endpoint specified in [Api.isbnBook], with the given [isbn] as the path parameter.
  ///
  /// - Parameters:
  ///   - [isbn]: The ISBN of the book to retrieve.
  /// - Returns: A [Future] that resolves to a [BookResponse] containing the book's api.
  @GET(Api.isbnBook)
  Future<BookResponse> getIsbnBook(
    @Path('isbn') String isbn,
  );

  /// Fetches books written by a specific author.
  ///
  /// Calls the endpoint specified in [Api.authorBooks], with the given [author] as the path parameter.
  ///
  /// - Parameters:
  ///   - [author]: The author name to search for books.
  /// - Returns: A [Future] that resolves to a [BookResponse] containing a list of books by the author.
  @GET(Api.authorBooks)
  Future<BookResponse> getAuthorBooks(
    @Path('author') String author,
  );
}
