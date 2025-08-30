import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  UrlLauncher._();

  static void launch(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }
}
