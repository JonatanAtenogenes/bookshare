import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/books/book_screen.dart';
import 'package:bookshare/src/views/common/screens/page_not_found_screen.dart';
import 'package:bookshare/src/views/donations/donation_screen.dart';
import 'package:bookshare/src/views/exchanges/exchange_screen.dart';
import 'package:bookshare/src/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          actions: [
            IconButton(
              onPressed: () => {},
              icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            ),
            IconButton(
              onPressed: () => {},
              icon: const FaIcon(FontAwesomeIcons.user),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          switch (currentPageIndex) {
            case 0:
              return const HomeScreen();
            case 1:
              return const BookScreen();
            case 2:
              return const ExchangeScreen();
            case 3:
              return const DonationScreen();
            default:
              return const PageNotFoundScreen();
          }
        }),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add a new book',
          onPressed: () => {
            log('Navigating to Adding Book Screen'),
            context.pushNamed(RouteNames.addingBookScreenRoute)
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) => {
            setState(() {
              currentPageIndex = index;
            })
          },
          indicatorColor: Theme.of(context).colorScheme.primary,
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.house),
              label: 'Principal',
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.book),
              label: 'Libros',
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.leftRight),
              label: 'Intercambios',
            ),
            NavigationDestination(
              icon: FaIcon(FontAwesomeIcons.bookBookmark),
              label: 'Donaciones',
            ),
          ],
        ),
      ),
    );
  }
}
