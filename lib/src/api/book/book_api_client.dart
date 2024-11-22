import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/book/book.dart';
import '../api.dart';

part 'book_api_client.g.dart';

/// A client for interacting with the book-related endpoints of the API.
///
/// This client provides methods to fetch details about books, retrieve a list of books,
/// create new books, and deactivate existing books by sending HTTP requests to the backend.
@RestApi(baseUrl: Api.baseUrl)
abstract class BookApiClient {
  /// Creates an instance of [BookApiClient] using a [Dio] client.
  ///
  /// This factory constructor allows instantiating the client with a Dio instance for making
  /// HTTP requests and optionally a custom [baseUrl].
  factory BookApiClient(Dio dio, {String baseUrl}) = _BookApiClient;

  /// Fetches the details of a specific book by its unique [id].
  ///
  /// Sends a GET request to retrieve the detailed information of a book.
  ///
  /// - [id]: The unique identifier of the book.
  ///
  /// Returns a [BookResponse] containing the book's detailed information, including
  /// its attributes like title, authors, value, and condition.
  @GET(Api.showBook)
  Future<BookResponse> showBook(@Path('id') String id);

  /// Retrieves a list of all books excluding those from a specified user.
  ///
  /// Sends a GET request to fetch a list of books, omitting books owned by a specific user.
  ///
  /// - [userId]: The unique identifier of the user whose books should be excluded from the list.
  ///
  /// Returns a [BookListResponse] containing the list of books, excluding the specified user's books.
  @GET(Api.retrieveBooks)
  Future<BookListResponse> retrieveBooks(@Path('userId') String userId);

  /// Retrieves all books associated with a specific user.
  ///
  /// Sends a GET request to fetch all books owned by a user based on their unique [id].
  ///
  /// - [id]: The unique identifier of the user whose books are to be retrieved.
  ///
  /// Returns a [BookListResponse] containing the list of books belonging to the specified user.
  @GET(Api.retrieveUserBooks)
  Future<BookListResponse> retrieveUserBooks(@Path('id') String id);

  /// Creates a new book entry in the system.
  ///
  /// Sends a POST request to create a new book based on the provided [book] details.
  ///
  /// - [book]: An instance of [Book] containing the book's attributes like title, authors, value, etc.
  ///
  /// Returns a [BookResponse] indicating the result of the creation operation, including the newly created book's details.
  @POST(Api.createBook)
  Future<BookResponse> createBook(@Body() Book book);

  /// Deactivates an existing book by its unique [id].
  ///
  /// Sends a PATCH request to deactivate a book, effectively marking it as unavailable or removed.
  ///
  /// - [id]: The unique identifier of the book to be deactivated.
  ///
  /// Returns a [BookResponse] indicating the result of the deactivation operation.
  @PATCH(Api.deactivateBook)
  Future<BookResponse> deactivateBook(@Path('id') String id);
}
