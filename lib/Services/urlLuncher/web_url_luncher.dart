// ignore_for_file: unused_element, deprecated_member_use

import 'package:url_launcher/url_launcher.dart';

class UrlLuncher {
  static launchUrls(url) async {
    final Uri _url = Uri.parse(url);
    await launchUrl(_url);
  }
}
