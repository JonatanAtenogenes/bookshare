import 'dart:developer';

import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/viewmodels/viewmodels.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  Future<void> _fetchCsrfToken() async {
    ref.read(isLoadingTokenProvider.notifier).update((state) => true);
    ref.read(errorFetchingTokenProvider.notifier).update((state) => false);
    try {
      await ref.read(csrfTokenProvider.notifier).getCsrfToken();
    } catch (e) {
      ref.read(errorFetchingTokenProvider.notifier).update((state) => true);
    } finally {
      ref.read(isLoadingTokenProvider.notifier).update((state) => false);
    }
  }

  @override
  void initState() {
    _fetchCsrfToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final errorTokenProvider = ref.watch(errorFetchingTokenProvider);
    final isLoadinTokenProvider = ref.watch(isLoadingTokenProvider);

    if (isLoadinTokenProvider) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (errorTokenProvider) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SubtitleText(
                subtitle: 'Error retrieving csrf token',
              ),
              IconButton(
                onPressed: _fetchCsrfToken,
                icon: FaIcon(
                  FontAwesomeIcons.rotateRight,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: WelcomeScreenVisible(),
        ),
      ),
    );
  }
}

class WelcomeScreenVisible extends StatelessWidget {
  const WelcomeScreenVisible({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Center(
          child: TitleText(title: AppStrings.appTitle),
        ),
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
          child: const SubtitleText(subtitle: AppStrings.appBrand),
        ),
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width / 30),
          child: Image.asset(
            AssetsAccess.bookshareIcon,
            height: MediaQuery.of(context).size.width / 2,
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        CustomButton(
            onPressed: () => {
                  log("Welcome Screen: Navigating to Login Screen"),
                  context.pushNamed(RouteNames.loginScreenRoute),
                },
            text: AppStrings.login),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(AppStrings.noAccount),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
              child: TextLink(
                text: AppStrings.createAccount,
                onTap: () => {
                  log("Welcome Screen: Navigating to Sign Up Screen"),
                  context.pushNamed(RouteNames.signupScreenRoute),
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
