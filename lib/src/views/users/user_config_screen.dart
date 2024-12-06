import 'package:bookshare/src/data/auth_data.dart';
import 'package:bookshare/src/data/exchange_data.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/exchange/exchange_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/user_data.dart';

class UserConfigScreen extends ConsumerStatefulWidget {
  const UserConfigScreen({super.key});

  @override
  ConsumerState<UserConfigScreen> createState() => _UserConfigScreenState();
}

class _UserConfigScreenState extends ConsumerState<UserConfigScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
    super.initState();
  }

  Future<void> _loadUserData() async {
    await ref.read(userDataProvider).getAuthUserInformation();
    await ref
        .read(exchangeDataProvider)
        .listExchanges(ref.read(currentUserProvider).id);
  }

  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SubtitleText(subtitle: AppStrings.generalInformation),
            const SizedBox(
              height: height,
            ),
            ConfigCard(
              title: AppStrings.personalData,
              onTap: () {
                context.pushNamed(RouteNames.personalInformationScreenRoute);
              },
            ),
            ConfigCard(
              title: AppStrings.addressInformation,
              onTap: () {
                context.pushNamed(RouteNames.addressInformationScreenRoute);
              },
            ),
            const SizedBox(
              height: height,
            ),
            const SubtitleText(
              subtitle: AppStrings.exchanges,
            ),
            const SizedBox(
              height: height,
            ),
            ConfigCard(
              title: AppStrings.pendingExchanges,
              onTap: () {
                context.pushNamed(RouteNames.pendingExchangesInfoScreenRoute);
              },
            ),
            ConfigCard(
              title: AppStrings.allExchanges,
              onTap: () {
                context.pushNamed(RouteNames.allExchangesInfoScreenRoute);
              },
            ),
            const SizedBox(
              height: height,
            ),
            const SubtitleText(
              subtitle: AppStrings.supportAndSettings,
            ),
            const SizedBox(
              height: height,
            ),
            // ConfigCard(
            //   title: AppStrings.submitProblem,
            //   onTap: () {
            //     context.pushNamed(RouteNames.submitProblemScreenRoute);
            //   },
            // ),
            ConfigCard(
              title: AppStrings.about,
              onTap: () {
                context.pushNamed(RouteNames.aboutScreenRoute);
              },
            ),
            const SizedBox(
              height: height,
            ),
            CustomButton(
              onPressed: () async {
                await ref.read(authDataProvider).logoutUser();

                WidgetsBinding.instance.addPostFrameCallback((callback) {
                  if (mounted) {
                    ref.read(sessionExchangesProvider.notifier).reset();
                    context.goNamed(RouteNames.logoutScreenRoute);
                  }
                });
              },
              text: AppStrings.logout,
            )
          ],
        ),
      ),
    );
  }
}

class ConfigCard extends StatelessWidget {
  const ConfigCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.lato(
                        fontSize: 20,
                      ),
                    ),
                    const Icon(
                      FontAwesomeIcons.angleRight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
