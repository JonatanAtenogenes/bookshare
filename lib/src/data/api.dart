/// A class that holds the base URLs and API routes for the application.
///
/// This class provides static constants for the base URL of the API, as well
/// as specific routes for authentication, user-related actions, and ISBN book queries.
class Api {
  // Base URL for the API
  static const String baseUrl = "http://10.228.8.91:8000/";

  // Base URL for image resources
  static const String baseImageUrl = "http://192.168.100.94:3000/";

  // Auth API Routes
  /// The endpoint to retrieve the CSRF token.
  static const String csrfToken = 'api/csrf-token';

  /// The endpoint for user login.
  static const String login = 'api/auth/login';

  /// The endpoint for user registration.
  static const String register = 'api/auth/register';

  /// The endpoint for user logout.
  static const String logout = 'api/auth/logout';

  // User API Routes
  /// The endpoint to update personal information for a user.
  /// - `{id}`: The unique identifier of the user.
  static const String updatePersonalInformation =
      'api/users/{id}/personal-info';

  /// The endpoint to upload a user's profile image.
  static const String uploadProfileImage = 'api/users/upload';
  static const String updateAddressInformation = 'api/users/{id}/address';

  // ISBN Books API Routes
  /// The endpoint to get information about a book by its ISBN.
  /// - The ISBN number should be appended to the end of this route.
  static const String isbnBook = 'api/isbndb/books/isbn/';

  // Localities API Routes
  static const String localities = 'api/localities/{postalCode}';
}
