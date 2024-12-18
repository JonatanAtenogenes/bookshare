import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/views/auth/login/login_screen.dart';
import 'package:bookshare/src/views/auth/logout_screen.dart';
import 'package:bookshare/src/views/auth/sign_up/address_register_screen.dart';
import 'package:bookshare/src/views/auth/sign_up/personal_data_register_screen.dart';
import 'package:bookshare/src/views/books/adding_book_screen.dart';
import 'package:bookshare/src/views/books/book_info_screen.dart';
import 'package:bookshare/src/views/common/screens/about_screen.dart';
import 'package:bookshare/src/views/common/screens/loading_content_screen.dart';
import 'package:bookshare/src/views/common/screens/location_selection_screen.dart';
import 'package:bookshare/src/views/common/screens/location_visualizer_screen.dart';
import 'package:bookshare/src/views/common/screens/submit_problem_screen.dart';
import 'package:bookshare/src/views/exchanges/all_exchanges_info_screen.dart';
import 'package:bookshare/src/views/exchanges/exchange_information_screen.dart';
import 'package:bookshare/src/views/exchanges/exchange_register_screen.dart';
import 'package:bookshare/src/views/exchanges/pending_exchanges_info_screen.dart';
import 'package:bookshare/src/views/users/address_information_screen.dart';
import 'package:bookshare/src/views/users/main_screen_container.dart';
import 'package:bookshare/src/views/users/personal_information_screen.dart';
import 'package:bookshare/src/views/users/user_config_screen.dart';
import 'package:bookshare/src/views/users/user_profile_screen.dart';
import 'package:bookshare/src/views/welcome/welcome_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../views/auth/sign_up/sign_up_screen.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
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
        path: '/logout',
        name: RouteNames.logoutScreenRoute,
        builder: (context, state) => const LogoutScreen(),
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
      ),
      GoRoute(
        path: '/user_config_screen',
        name: RouteNames.userConfigScreenRoute,
        builder: (context, state) => const UserConfigScreen(),
      ),
      GoRoute(
        path: '/user_profile_screen',
        name: RouteNames.userProfileScreenRoute,
        builder: (context, state) => const UserProfileScreen(),
      ),
      GoRoute(
        path: '/book_information',
        name: RouteNames.bookInformationScreenRoute,
        builder: (context, state) => const BookInformation(),
      ),
      GoRoute(
        path: '/exchange_register',
        name: RouteNames.exchangeRegisterScreenRoute,
        builder: (context, state) => const ExchangeRegisterScreen(),
      ),
      GoRoute(
        path: '/loading_content',
        name: RouteNames.loadingContentScreenRoute,
        builder: (context, state) => const LoadingContentScreen(),
      ),
      GoRoute(
        path: '/pending_exchanges_info',
        name: RouteNames.pendingExchangesInfoScreenRoute,
        builder: (context, state) => const PendingExchangesInfoScreen(),
      ),
      GoRoute(
        path: '/rejected_exchanges_info',
        name: RouteNames.allExchangesInfoScreenRoute,
        builder: (context, state) => const AllExchangesInfoScreen(),
      ),
      GoRoute(
        path: '/exchanges_information',
        name: RouteNames.exchangeInformationScreenRoute,
        builder: (context, state) => const ExchangeInformationScreen(),
      ),
      GoRoute(
        path: '/location_selection',
        name: RouteNames.locationSelectionScreen,
        builder: (context, state) => const LocationSelectionScreen(),
      ),
      GoRoute(
        path: '/location_visualizer',
        name: RouteNames.locationVisualizerScreen,
        builder: (context, state) => const LocationvisualizerScreen(),
      ),
      GoRoute(
        path: '/personal_information',
        name: RouteNames.personalInformationScreenRoute,
        builder: (context, state) => const PersonalInformationScreen(),
      ),
      GoRoute(
        path: '/address_information',
        name: RouteNames.addressInformationScreenRoute,
        builder: (context, state) => const AddressInformationScreen(),
      ),
      GoRoute(
        path: '/submit_problem',
        name: RouteNames.submitProblemScreenRoute,
        builder: (context, state) => const SubmitProblemScreen(),
      ),
      GoRoute(
        path: '/about',
        name: RouteNames.aboutScreenRoute,
        builder: (context, state) => const AboutScreen(),
      )
    ],
  ),
);
