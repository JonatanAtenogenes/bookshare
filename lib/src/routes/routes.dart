import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/views/books/adding_book_screen.dart';
import 'package:bookshare/src/views/login/login_screen.dart';
import 'package:bookshare/src/views/sign_up/address_register_screen.dart';
import 'package:bookshare/src/views/sign_up/personal_data_register_screen.dart';
import 'package:bookshare/src/views/sign_up/sign_up_screen.dart';
import 'package:bookshare/src/views/users/main_screen_container.dart';
import 'package:bookshare/src/views/welcome/welcome_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  routerNeglect: true,
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.welcomeScreenRoute,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: RouteNames.loginScreenRoute,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/sign_up',
      name: RouteNames.signupScreenRoute,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/personal_data_register',
      name: RouteNames.personalDataRegisterScreenRoute,
      builder: (context, state) => const PersonalDataRegisterScreen(),
    ),
    GoRoute(
      path: '/address_register',
      name: RouteNames.addressRegisterScreenRoute,
      builder: (context, state) => const AddressRegisterScreen(),
    ),
    GoRoute(
      path: '/main_screen',
      name: RouteNames.mainScreenRoute,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/adding_book_screen',
      name: RouteNames.addingBookScreenRoute,
      builder: (context, state) => const AddingBookScreen(),
    )
  ],
);
