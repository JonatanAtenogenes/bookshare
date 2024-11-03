class Api {
  // Base URL
  static const String baseUrl = "http://192.168.50.39:8000/";

  // Auth Api Routes
  static const String csrfToken = 'api/csrf-token';
  static const String login = 'api/auth/login';
  static const String register = 'api/auth/register';
  static const String logout = 'api/auth/logout';

  // User Api Routes
  static const String updatePersonalInformation =
      'api/users/{id}/personal-info';
  static const String uploadProfileImage = 'api/users/upload';

  // ISBN Books Api Routes
  static const String isbnBook = 'api/isbndb/books/isbn/';
}
