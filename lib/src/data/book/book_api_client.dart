import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/book/book.dart';
import '../api.dart';

part 'book_api_client.g.dart';

/// A client for interacting with the book-related endpoints of the API.
///
/// This client provides methods to retrieve book details, list books,
/// create new books, and deactivate existing ones by communicating
/// with the backend through HTTP requests.
@RestApi(baseUrl: Api.baseUrl)
abstract class BookApiClient {
  /// Creates an instance of [BookApiClient] using a [Dio] client.
  factory BookApiClient(Dio dio, {String baseUrl}) = _BookApiClient;

  /// Fetches the details of a specific book by its unique [id].
  ///
  /// Returns a [BookResponse] containing the book's information.
  @GET(Api.showBook)
  Future<BookResponse> showBook(@Path('id') String id);

  /// Retrieves a list of all books, excluding those from a specified user.
  ///
  /// - [userId]: The unique identifier of the user whose books should be excluded.
  /// Returns a [BookResponse] with the list of books.
  @GET(Api.retrieveBooks)
  Future<BookResponse> retrieveBooks(@Path('userId') String userId);

  /// Retrieves all books associated with a specific user by [id].
  ///
  /// Returns a [BookResponse] containing the user's books.
  @GET(Api.retrieveUserBooks)
  Future<BookResponse> retrieveUserBooks(@Path('id') String id);

  /// Creates a new book entry in the system.
  ///
  /// - [book]: An instance of [Book] containing the book's details.
  /// Returns a [BookResponse] indicating the result of the creation operation.
  @POST(Api.createBook)
  Future<BookResponse> createBook(@Body() Book book);

  /// Deactivates an existing book by its unique [id].
  ///
  /// Returns a [BookResponse] indicating the result of the deactivation operation.
  @PATCH(Api.deactivateBook)
  Future<BookResponse> deactivateBook(@Path('id') String id);
}
