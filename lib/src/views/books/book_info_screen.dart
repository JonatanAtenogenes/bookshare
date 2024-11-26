import 'package:bookshare/src/models/delegate/search_delegate.dart';
import 'package:bookshare/src/models/enum/book_attributes.dart';
import 'package:bookshare/src/models/enum/book_conditions.dart';
import 'package:bookshare/src/routes/route_names.dart';
import 'package:bookshare/src/utils/app_strings.dart';
import 'package:bookshare/src/utils/assets_access.dart';
import 'package:bookshare/src/view_models/book/book_provider.dart';
import 'package:bookshare/src/view_models/user/user_provider.dart';
import 'package:bookshare/src/views/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BookInformation extends ConsumerWidget {
  const BookInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookProvider = ref.watch(bookInfoProvider);
    final userProvider = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookInformation),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SubtitleText(
                    subtitle: bookProvider.book[BookAttributes.title.name],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    bookProvider.image,
                    errorBuilder: (context, error, stackTrace) => const Image(
                      image: AssetImage(AssetsAccess.defaultBookImage),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: SubtitleText(
                  subtitle:
                      bookProvider.book[BookAttributes.authors.name].join(", "),
                ),
              ),
              Visibility(
                visible: bookProvider.synopsis.length > 180,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    bookProvider.synopsis,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(),
                  ),
                ),
              ),
              Text(
                'Valor: ${bookProvider.value}',
                style: GoogleFonts.lato(
                  fontSize: 22,
                ),
              ),
              Text(
                'Condicion: ${BookCondition.getNameByValue(bookProvider.condition)}',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Visibility(
                visible: userProvider.id != bookProvider.user.id,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Usuario: ",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                          ),
                        ),
                        TextLink(
                          text: bookProvider.user.id.substring(12),
                          onTap: () {
                            context.pushNamed(
                              RouteNames.userProfileScreenRoute,
                            );
                          },
                        ),
                      ],
                    ),
                    CustomButton(
                      onPressed: () {},
                      text: "Proponer Intercambio",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
