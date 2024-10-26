class Api {
  // Base URL
  static const String baseUrl = "http://192.168.100.40:8000/";

  // Auth Api Routes
  static const String csrfToken = 'api/csrf-token';
  static const String login = 'api/auth/login';

  // ISBN Books Api Routes
  static const String isbnBook = 'api/isbndb/books/isbn/';
}
