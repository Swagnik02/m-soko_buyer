import 'package:url_launcher/url_launcher.dart';

launchURLfromExternalbrowser(String _url) async {
  final Uri url = Uri.parse(_url);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $_url');
  }
}
