import 'package:bookshare/src/models/enum/library_attributes.dart';
import 'package:bookshare/src/models/library.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
