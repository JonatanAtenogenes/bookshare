import 'package:bookshare/src/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About BookShare',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'BookShare is an innovative platform that allows users to share and exchange books within a trusted community. '
              'Discover new reads, connect with fellow book lovers, and promote a culture of knowledge sharing.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Version',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              '1.0.0', // Update this version as needed
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('support@bookshare.com'),
              onTap: () {
                // Opens the user's email client
                //_launchEmail('support@bookshare.com');
              },
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Visit Website'),
              onTap: () {
                // Opens the website
                //_launchWebsite('https://bookshare.com');
              },
            ),
          ],
        ),
      ),
    );
  }

// void _launchEmail(String email) async {
//   final Uri emailUri = Uri(
//     scheme: 'mailto',
//     path: email,
//   );
//
//   if (await canLaunchUrl(emailUri)) {
//     await launchUrl(emailUri);
//   } else {
//     debugPrint('Could not launch email client.');
//   }
// }
//
// void _launchWebsite(String url) async {
//   final Uri websiteUri = Uri.parse(url);
//
//   if (await canLaunchUrl(websiteUri)) {
//     await launchUrl(websiteUri);
//   } else {
//     debugPrint('Could not launch website.');
//   }
// }
}
