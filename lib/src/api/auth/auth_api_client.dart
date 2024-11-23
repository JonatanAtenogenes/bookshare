import 'package:bookshare/src/api/api.dart';
import 'package:bookshare/src/models/models.dart';
import 'package:bookshare/src/models/response/auth_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart'; // Required for Retrofit code generation

/// **AuthApiClient**
///
/// An abstract class for managing user authentication-related API calls.
///
/// This class uses Retrofit for HTTP requests and defines methods for user
/// registration, login, and logout. It interacts with the API specified by
/// the `Api` class constants.
///
/// - **Base URL**: `Api.baseUrl`
/// - **Generated Code**: The `_AuthApiClient` implementation is generated by Retrofit.
///
/// ### Constructor:
/// The `AuthApiClient` factory constructor creates an instance using a
/// `Dio` object configured for HTTP communication.
///
/// Example usage:
/// ```dart
/// final dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
/// final authApiClient = AuthApiClient(dio);
/// ```
@RestApi(baseUrl: Api.baseUrl)
abstract class AuthApiClient {
  /// Factory constructor to create an instance of `AuthApiClient`.
  ///
  /// - [dio]: A `Dio` instance for HTTP communication.
  /// - [baseUrl]: Optional base URL; defaults to `Api.baseUrl`.
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  /// **registerUser**
  ///
  /// Registers a new user in the system.
  ///
  /// - **Endpoint**: `POST Api.register`
  /// - **Request Body**: A `User` object containing the user's registration details.
  /// - **Returns**: A `Future<AuthResponse>` containing the result of the registration.
  ///
  /// Example usage:
  /// ```dart
  /// final user = User(name: "John Doe", email: "john@example.com", ...);
  /// final response = await authApiClient.registerUser(user);
  /// ```
  @POST(Api.register)
  Future<AuthResponse> registerUser(@Body() User user);

  /// **loginUser**
  ///
  /// Logs in a user with their credentials.
  ///
  /// - **Endpoint**: `POST Api.login`
  /// - **Request Body**: A `User` object containing the user's login credentials.
  /// - **Returns**: A `Future<AuthResponse>` containing the authentication result.
  ///
  /// Example usage:
  /// ```dart
  /// final user = User(email: "john@example.com", password: "password123");
  /// final response = await authApiClient.loginUser(user);
  /// ```
  @POST(Api.login)
  Future<AuthResponse> loginUser(@Body() User user);

  /// **logoutUser**
  ///
  /// Logs out the currently authenticated user.
  ///
  /// - **Endpoint**: `POST Api.logout`
  /// - **Request Body**: None.
  /// - **Returns**: A `Future<void>` indicating the success or failure of the logout.
  ///
  /// Example usage:
  /// ```dart
  /// await authApiClient.logoutUser();
  /// ```
  @POST(Api.logout)
  Future<void> logoutUser();
}
