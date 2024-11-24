import 'dart:developer';

import 'package:bookshare/src/view_models/auth/api_logout_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/enum/enums.dart';
import '../models/models.dart';
import '../view_models/auth/api_login_provider.dart';
import '../view_models/auth/api_register_provider.dart';
import '../view_models/user/user_provider.dart';

/// **authDataProvider**
///
/// Provides an instance of [AuthData] to manage authentication-related operations.
///
/// This provider is used to access the [AuthData] class, which facilitates
/// authentication tasks like logging in and registering a user.
///
/// Example usage:
/// ```dart
/// final authData = ref.read(authDataProvider);
/// authData.loginUser(email, password);
/// ```
final authDataProvider = StateProvider<AuthData>((ref) {
  return AuthData(ref);
});

/// **AuthData**
///
/// A class responsible for managing user authentication operations.
///
/// The [AuthData] class uses Riverpod's state management to interact with
/// authentication-related providers, such as login and registration. It
/// updates the app's state based on the success or failure of these operations.
///
/// ### Constructor
/// - [ref]: A Riverpod `Ref` object to access other providers.
///
/// Example:
/// ```dart
/// final authData = AuthData(ref);
/// authData.loginUser("test@example.com", "password");
/// ```
class AuthData {
  /// Reference to Riverpod's `Ref`, used to interact with providers.
  final Ref ref;

  /// Creates an instance of [AuthData].
  AuthData(this.ref);

  /// **loginUser**
  ///
  /// Authenticates a user with their email and password.
  ///
  /// #### Steps:
  /// 1. Initializes the login process by marking the state as successful.
  /// 2. Constructs a [User] object with the provided credentials.
  /// 3. Calls the `apiLoginNotifierProvider` to perform the login operation.
  /// 4. Updates the `currentUserProvider` with the authenticated user's data.
  /// 5. Handles any errors that occur during the login attempt by updating
  ///    the login error state.
  /// 6. Ensures the loading state is reset after the process completes.
  ///
  /// #### Parameters:
  /// - [email]: The user's email address.
  /// - [password]: The user's password.
  ///
  /// #### Throws:
  /// - [DioException]: If an error occurs during the login API request.
  ///
  /// #### Example:
  /// ```dart
  /// await authData.loginUser("john.doe@example.com", "securePassword");
  /// ```
  Future<void> loginUser(String email, String password) async {
    ref.read(loadingApiLoginProvider.notifier).update((state) => true);
    try {
      final user = User(
        id: "",
        email: email,
        password: password,
        role: Roles.user.name,
      );

      // Perform login
      await ref.read(apiLoginNotifierProvider.notifier).loginUser(user);

      // Update current user state
      ref.read(currentUserProvider.notifier).update(
            (state) => ref.read(currentUserProvider).copyWith(
                  id: ref.read(apiLoginNotifierProvider).data!.id,
                  email: ref.read(apiLoginNotifierProvider).data!.email,
                  password: ref.read(apiLoginNotifierProvider).data!.password,
                  name: ref.read(apiLoginNotifierProvider).data!.name,
                  paternalSurname:
                      ref.read(apiLoginNotifierProvider).data!.paternalSurname,
                  maternalSurname:
                      ref.read(apiLoginNotifierProvider).data!.maternalSurname,
                  birthdate: ref.read(apiLoginNotifierProvider).data!.birthdate,
                  address: ref.read(apiLoginNotifierProvider).data!.address,
                  image: ref.read(apiLoginNotifierProvider).data!.image,
                  role: ref.read(apiLoginNotifierProvider).data!.role,
                  status: ref.read(apiLoginNotifierProvider).data!.status,
                ),
          );
    } on DioException catch (e) {
      // Handle login error
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref.read(apiLoginNotifierProvider.notifier).updateErrorLogin(message);
    } finally {
      // Reset loading state
      ref.read(loadingApiLoginProvider.notifier).update((state) => false);
    }
  }

  /// **registerUser**
  ///
  /// Registers a new user with the provided email and password.
  ///
  /// #### Steps:
  /// 1. Constructs a [User] object with the given credentials.
  /// 2. Calls the `apiRegisterNotifierProvider` to perform the registration.
  /// 3. Updates the `currentUserProvider` with the registered user's data.
  /// 4. Handles any errors that occur during the registration process by
  ///    updating the registration error state.
  /// 5. Ensures the loading state is reset after the process completes.
  ///
  /// #### Parameters:
  /// - [email]: The user's email address.
  /// - [password]: The user's password.
  ///
  /// #### Throws:
  /// - [DioException]: If an error occurs during the registration API request.
  ///
  /// #### Example:
  /// ```dart
  /// await authData.registerUser("jane.doe@example.com", "password123");
  /// ```
  Future<void> registerUser(String email, String password) async {
    ref.read(loadingApiRegisterProvider.notifier).update(
          (state) => state = true,
        );
    try {
      final user = User(
        id: "",
        email: email,
        password: password,
        role: Roles.user.name,
      );

      // Perform registration
      await ref.read(apiRegisterNotifierProvider.notifier).registerUser(user);

      // Update current user state only on success
      if (ref.read(apiRegisterNotifierProvider).success) {
        ref.read(currentUserProvider.notifier).update(
              (state) => ref.read(currentUserProvider).copyWith(
                    id: ref.read(apiRegisterNotifierProvider).data!.id,
                    email: ref.read(apiRegisterNotifierProvider).data!.email,
                    password:
                        ref.read(apiRegisterNotifierProvider).data!.password,
                    name: ref.read(apiRegisterNotifierProvider).data!.name,
                    paternalSurname: ref
                        .read(apiRegisterNotifierProvider)
                        .data!
                        .paternalSurname,
                    maternalSurname: ref
                        .read(apiRegisterNotifierProvider)
                        .data!
                        .maternalSurname,
                    birthdate:
                        ref.read(apiRegisterNotifierProvider).data!.birthdate,
                    address:
                        ref.read(apiRegisterNotifierProvider).data!.address,
                    image: ref.read(apiRegisterNotifierProvider).data!.image,
                    role: ref.read(apiRegisterNotifierProvider).data!.role,
                    status: ref.read(apiRegisterNotifierProvider).data!.status,
                  ),
            );
      }
    } on DioException catch (e) {
      String message =
          e.response?.data['message'] ?? "An unexpected error has occurred";
      ref.read(apiRegisterNotifierProvider.notifier).updateErrorRegister(
            message,
          );
    } finally {
      // Reset loading state
      ref.read(loadingApiRegisterProvider.notifier).update((state) => false);
    }
  }

  Future<void> logoutUser() async {
    ref.read(loadingApiLogoutProvider.notifier).update((state) => false);
    try {
      //
      final user = ref.read(currentUserProvider);
      await ref.read(apiLogoutNotifierProvider.notifier).logoutUser(user);
      log("no errors on logout user");
    } on DioException catch (e) {
      //
    } finally {
      //
      ref.read(loadingApiLogoutProvider.notifier).update((state) => false);
    }
  }
}
