import 'package:bookshare/src/models/response/book_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/book/book.dart';
import '../api.dart';

part 'book_api_client.g.dart';

/// A client for interacting with the book-related endpoints of the API.
///
/// This client provides methods to:
/// - Fetch details about a specific book.
/// - Retrieve a list of books, excluding those owned by a particular user.
/// - Retrieve all books associated with a specific user.
/// - Create a new book.
/// - Deactivate or activate books.
///
/// The client communicates with the backend by sending HTTP requests and receiving
/// responses wrapped in [BookResponse] or [BookListResponse] instances.
@RestApi(baseUrl: Api.baseUrl)
abstract class BookApiClient {
  /// Creates an instance of [BookApiClient] using a [Dio] client.
  ///
  /// - [dio]: The Dio client used for sending HTTP requests.
  /// - [baseUrl]: An optional parameter to override the base URL for API requests.
  ///
  /// Returns a new [BookApiClient] instance.
  factory BookApiClient(Dio dio, {String baseUrl}) = _BookApiClient;

  /// Fetches the details of a specific book by its unique [id].
  ///
  /// Sends a GET request to retrieve the detailed information of a book.
  ///
  /// - [id]: The unique identifier of the book to retrieve.
  ///
  /// Returns a [BookResponse] containing the book's detailed information, including
  /// its attributes like title, authors, value, and condition.
  @GET(Api.showBook)
  Future<BookResponse> showBook(
    @Path('id') String id,
  );

  /// Retrieves a list of all books excluding those from a specified user.
  ///
  /// Sends a GET request to fetch a list of books, omitting books owned by a specific user.
  ///
  /// - [userId]: The unique identifier of the user whose books should be excluded from the list.
  ///
  /// Returns a [BookListResponse] containing the list of books, excluding the specified user's books.
  @GET(Api.retrieveBooks)
  Future<BookListResponse> retrieveBooks(
    @Path('userId') String userId,
  );

  /// Retrieves all books associated with a specific user.
  ///
  /// Sends a GET request to fetch all books owned by a user based on their unique [id].
  ///
  /// - [id]: The unique identifier of the user whose books are to be retrieved.
  ///
  /// Returns a [BookListResponse] containing the list of books belonging to the specified user.
  @GET(Api.retrieveUserBooks)
  Future<BookListResponse> retrieveUserBooks(
    @Path('id') String id,
  );

  /// Creates a new book entry in the system.
  ///
  /// Sends a POST request to create a new book based on the provided [book] details.
  ///
  /// - [book]: An instance of [Book] containing the book's attributes like title, authors, value, etc.
  ///
  /// Returns a [BookResponse] indicating the result of the creation operation, including the newly created book's details.
  @POST(Api.createBook)
  Future<BookResponse> createBook(
    @Body() Book book,
  );

  /// Deactivates an existing book by its unique [id].
  ///
  /// Sends a PATCH request to deactivate a book, effectively marking it as unavailable or removed.
  ///
  /// - [id]: The unique identifier of the book to be deactivated.
  ///
  /// Returns a [BookResponse] indicating the result of the deactivation operation.
  @PATCH(Api.deactivateBook)
  Future<BookResponse> deactivateBook(
    @Path('id') String id,
  );

  /// Activates a deactivated book by its unique [id].
  ///
  /// Sends a PATCH request to reactivate a book, making it available again.
  ///
  /// - [id]: The unique identifier of the book to be activated.
  ///
  /// Returns a [BookResponse] indicating the result of the activation operation.
  @PATCH(Api.activateBook)
  Future<BookResponse> activateBook(
    @Path('id') String id,
  );

  /// Deactivates multiple books by their unique [booksIds].
  ///
  /// Sends a PATCH request to deactivate a list of books, marking them as unavailable.
  ///
  /// - [booksIds]: A list of unique identifiers of the books to be deactivated.
  ///
  /// Returns a [BookResponse] indicating the result of the deactivation operation for the list of books.
  @PATCH(Api.deactivateBooks)
  Future<BookResponse> deactivateBooks(
    @Body() List<String> booksIds,
  );

  /// Activates multiple books by their unique [booksIds].
  ///
  /// Sends a PATCH request to reactivate a list of books, making them available again.
  ///
  /// - [booksIds]: A list of unique identifiers of the books to be activated.
  ///
  /// Returns a [BookResponse] indicating the result of the activation operation for the list of books.
  @PATCH(Api.activateBooks)
  Future<BookResponse> activateBooks(
    @Body() List<Book> books,
  );

  @GET(Api.areBooksActive)
  Future<BookResponse> areBooksActive(
    @Body() List<Book> booksIds,
  );
}
