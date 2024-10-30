class Api {
  // Base URL
  static const String baseUrl = "http://192.168.100.94:8000/";

  // Auth Api Routes
  static const String csrfToken = 'api/csrf-token';
  static const String login = 'api/auth/login';
  static const String register = 'api/auth/register';

  // ISBN Books Api Routes
  static const String isbnBook = 'api/isbndb/books/isbn/';
}
