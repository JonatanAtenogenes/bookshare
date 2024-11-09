import 'dart:developer';

import 'package:bookshare/src/models/delegate/search_delegate.dart';
import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/views/books/book_screen.dart';
import 'package:bookshare/src/views/common/screens/page_not_found_screen.dart';
import 'package:bookshare/src/views/exchanges/exchange_screen.dart';
import 'package:bookshare/src/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final currentPageIndex = ref.watch(indexContentProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appTitle),
          actions: [
            IconButton(
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            ),
            IconButton(
              onPressed: () => {
                log('Navigating to User Profile Screen'),
                context.pushNamed(
                  RouteNames.userProfileScreenRoute,
                )
              },
              icon: const FaIcon(FontAwesomeIcons.gear),
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
            // case 3:
            //   return const DonationScreen();
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
            ref
                .read(indexContentProvider.notifier)
                .update((state) => state = index),
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
            // NavigationDestination(
            //   icon: FaIcon(FontAwesomeIcons.bookBookmark),
            //   label: 'Donaciones',
            // ),
          ],
        ),
      ),
    );
  }
}
