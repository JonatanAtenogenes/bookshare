import 'package:bookshare/src/data/auth_data.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/view_models/user/api_show_user_provider.dart';
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
    _loadUserData();
    super.initState();
  }

  Future<void> _loadUserData() async {
    await ref.read(userDataProvider).getAuthUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    final loadingUserInfo = ref.watch(loadingShowUserProvider);
    if (loadingUserInfo) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SubtitleText(subtitle: AppStrings.generalInformation),
            const SizedBox(
              height: 20,
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
            ConfigCard(
              title: AppStrings.exchanges,
              onTap: () {
                context.pushNamed(RouteNames.exchangesInfoScreenRoute);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const SubtitleText(
              subtitle: AppStrings.supportAndSettings,
            ),
            const SizedBox(
              height: 20,
            ),
            ConfigCard(
              title: AppStrings.submitProblem,
              onTap: () {
                context.pushNamed(RouteNames.submitProblemScreenRoute);
              },
            ),
            ConfigCard(
              title: AppStrings.about,
              onTap: () {
                context.pushNamed(RouteNames.aboutScreenRoute);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onPressed: () async {
                  await ref.read(authDataProvider).logoutUser();

                  WidgetsBinding.instance.addPostFrameCallback((callback) {
                    if (mounted) {
                      context.goNamed(RouteNames.logoutScreenRoute);
                    }
                  });
                },
                text: AppStrings.logout)
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
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
    );
  }
}
