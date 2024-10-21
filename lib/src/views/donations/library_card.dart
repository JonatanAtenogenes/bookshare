import 'package:bookshare/src/models/temp/temp_classes.dart';
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
                  library.getLibrary['name'],
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 22,
                    ),
                  ),
                ),
                Text(
                  library.getLibrary['address'],
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 28,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  library.getLibrary['city'],
                  textAlign: TextAlign.right,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 32,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  library.getLibrary['state'],
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
