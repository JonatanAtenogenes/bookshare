/// A class that holds the base URLs and API routes for the application.
///
/// This class provides static constants for the base URL of the API, as well
/// as specific routes for various endpoints, including authentication, user management,
/// ISBN book queries, books, exchanges, and localities.
class Api {
  // Base URLs for the API and images

  /// The base URL for the main API.
  static const String baseUrl =
      "https://25e0-2806-2f0-9021-ada2-9e54-a6f5-9a6b-9f79.ngrok-free.app/";

  /// The base URL for image resources.
  static const String baseImageUrl = "http://192.168.100.94:3000/";

  // Auth API Routes

  /// The endpoint for logging in users.
  static const String login = 'api/auth/login';

  /// The endpoint for registering a new user.
  static const String register = 'api/auth/register';

  /// The endpoint for logging out a user.
  static const String logout = 'api/auth/logout';

  // User API Routes

  /// The endpoint to show a user's profile information.
  /// - `{id}`: The unique identifier of the user.
  static const String showUser = 'api/users/{id}';

  /// The endpoint to upload a user's profile image.
  static const String uploadProfileImage = 'api/users/upload';

  /// The endpoint to update a user’s personal information.
  /// - `{id}`: The unique identifier of the user.
  static const String updatePersonalInformation =
      'api/users/{id}/personal-info';

  /// The endpoint to update a user’s address information.
  /// - `{id}`: The unique identifier of the user.
  static const String updateAddressInformation = 'api/users/{id}/address';

  // ISBN Books API Routes

  /// The endpoint to retrieve book details by ISBN.
  /// - `{isbn}`: The ISBN of the book.
  static const String isbnBook = 'api/isbndb/books/isbn/{isbn}';

  /// The endpoint to retrieve a list of books by author.
  /// - `{author}`: The author's name.
  static const String authorBooks = 'api/isbndb/books/author/{author}';

  // Books API Routes

  /// The endpoint to show details of a specific book.
  /// - `{id}`: The unique identifier of the book.
  static const String showBook = 'api/books/{id}';

  /// The endpoint to retrieve a list of books excluding those from a specified user.
  /// - `{userId}`: The unique identifier of the user.
  static const String retrieveBooks = 'api/books/all/exclude/{userId}';

  /// The endpoint to create a new book entry.
  static const String createBook = 'api/books';

  /// The endpoint to deactivate a book.
  /// - `{id}`: The unique identifier of the book.
  static const String deactivateBook = 'api/books/{id}/deactivate';

  /// The endpoint to activate a book.
  /// - `{id}`: The unique identifier of the book.
  static const String activateBook = 'api/books/{id}/activate';

  /// The endpoint to deactivate multiple books.
  static const String deactivateBooks = 'api/books/deactivate';

  /// The endpoint to activate multiple books.
  static const String activateBooks = 'api/books/activate';

  /// The endpoint to check the status of active books.
  static const String areBooksActive = 'api/books/status/active';

  /// The endpoint to check the status of inactive books.
  static const String areBooksInactive = 'api/books/status/inactive';

  /// The endpoint to retrieve books owned by a specific user.
  /// - `{id}`: The unique identifier of the user.
  static const String retrieveUserBooks = 'api/users/{id}/books';

  // Exchanges API Routes

  /// The endpoint to initiate a new exchange request.
  static const String createExchange = 'api/exchanges';

  /// The endpoint to update an existing exchange.
  /// - `{exchangeId}`: The unique identifier of the exchange.
  static const String updateExchange = 'api/exchanges/{exchangeId}';

  /// The endpoint to show details of a specific exchange.
  /// - `{exchangeId}`: The unique identifier of the exchange.
  static const String showExchange = 'api/exchanges/{exchangeId}';

  /// The endpoint to list exchanges for a specific user.
  /// - `{userId}`: The unique identifier of the user.
  static const String listExchanges = 'api/exchanges/user/{userId}';

  // Localities API Routes

  /// The endpoint to retrieve localities based on a postal code.
  /// - `{postalCode}`: The postal code to search localities for.
  static const String localities = 'api/localities/{postalCode}';
}
