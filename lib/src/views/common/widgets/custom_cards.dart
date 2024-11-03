import 'package:bookshare/src/models/enum/enums.dart';
import 'package:bookshare/src/models/models.dart';
import 'package:bookshare/src/providers/providers.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/viewmodels/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_strings.dart';
import 'widgets.dart';

// User Information Card
class UserInformationCard extends ConsumerWidget {
  const UserInformationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: SubtitleText(subtitle: AppStrings.userProfile)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width / 6,
                child: Image.network(
                  user.image ?? AssetsAccess.defaultUserImage,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset(AssetsAccess.defaultUserImage),
                ),
              ),
            ),
          ),
          VisualizeData(
              title: AppStrings.name,
              data: user.name ?? UserAttributes.name.attributeName),
          VisualizeData(
              title: AppStrings.paternalSurname,
              data: user.paternalSurname ??
                  UserAttributes.paternalSurname.attributeName),
          VisualizeData(
              title: AppStrings.maternalSurname,
              data: user.maternalSurname ??
                  UserAttributes.paternalSurname.attributeName),
          VisualizeData(title: AppStrings.email, data: user.email),
          VisualizeData(
              title: AppStrings.birthdate,
              data: DateFormat('dd-MM-yyyy')
                  .format(user.birthdate ?? DateTime.now())),
        ],
      ),
    );
  }
}

// Address Information Card
class AddressInformationCard extends ConsumerWidget {
  const AddressInformationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(simpleUserProvider);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: SubtitleText(subtitle: AppStrings.addressData),
          ),
          VisualizeData(title: AppStrings.street, data: user.address!.street),
          VisualizeData(
              title: AppStrings.exteriorNumber,
              data: user.address!.exteriorNumber),
          VisualizeData(
              title: AppStrings.postalCode, data: user.address!.postalCode),
          VisualizeData(
              title: AppStrings.locality, data: user.address!.locality),
          VisualizeData(title: AppStrings.city, data: user.address!.city),
          VisualizeData(title: AppStrings.state, data: user.address!.state),
        ],
      ),
    );
  }
}

// Book Card
class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
  });

  final Book book;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            book.book[BookAttributes.image.name],
                            height: MediaQuery.of(context).size.height / 7,
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          book.book[BookAttributes.title.name],
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          book.book[BookAttributes.authors.name].join(", "),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Valor'),
                        Text(book.book[BookAttributes.value.name].toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Library Card
class LibraryCard extends StatelessWidget {
  const LibraryCard({
    super.key,
    required this.library,
  });

  final Library library;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width / 1.8,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  library.library[LibraryAttributes.name.name],
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 22,
                    ),
                  ),
                ),
                Text(
                  library.library[LibraryAttributes.street.name],
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 28,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  library.library[LibraryAttributes.city.name],
                  textAlign: TextAlign.right,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 32,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  library.library[LibraryAttributes.state.name],
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 35,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Setings Card
class SettingsCard extends ConsumerWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    return Column(
      children: [
        const SubtitleText(subtitle: 'Ajustes'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Modo Oscuro'),
            Switch(
              value: isDarkMode,
              onChanged: (value) =>
                  ref.read(darkModeProvider.notifier).update((state) => !state),
            ),
          ],
        ),
      ],
    );
  }
}
