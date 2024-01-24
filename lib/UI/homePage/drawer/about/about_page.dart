import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'You can get all the source code in the GitHub',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                wordSpacing: 20,
                letterSpacing: 5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    Uri link = Uri.parse(
                        'https://github.com/muhdasifp/shoping_app.git');
                    if (!await launchUrl(link,
                        mode: LaunchMode.externalApplication)) {
                      throw Exception('Could not load $link');
                    }
                  },
                  icon: const Icon(
                    CupertinoIcons.link,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    String email = Uri.encodeComponent("asifatees@gmail.com");
                    String subject =
                        Uri.encodeComponent("Query about Shopping app");
                    String body = Uri.encodeComponent("🔥");
                    Uri mail =
                        Uri.parse("mailto:$email?subject=$subject&body=$body");
                    if (await launchUrl(mail)) {
                      //email app opened
                    } else {
                      //email app is not opened
                    }
                  },
                  icon: const Icon(
                    Icons.alternate_email,
                    size: 40,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
