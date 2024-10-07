import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/views/login/login_screen.dart';
import 'package:bookshare/src/views/sign_up/sign_up_screen.dart';
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
  ],
);
