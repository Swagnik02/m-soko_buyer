import 'package:flutter/material.dart';
import 'package:m_soko/widgets/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/help_support_banner.png'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _linkTo('Visit', 'https://help.sokoni.com', () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return TestWebViewPage();
                          },
                        ));
                      }),
                      _linkTo('Email Us', 'customercare@sokoni.com', () {
                        launchEmail('customercare@sokoni.com');
                      }),
                      _linkTo('Call Us', '+91 6257899906', () {
                        launchCall('+91 6257899906');
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _linkTo(String linkTo, String link, VoidCallback onTapAction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$linkTo:',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          InkWell(
            child: Text(
              link,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            onTap: onTapAction,
          ),
        ],
      ),
    );
  }

  void launchEmail(String email) async {
    print('testing');
    // final Uri _emailLaunchUri = Uri(
    //   scheme: 'mailto',
    //   path: email,
    // );
    // final String _emailLaunchUriString = _emailLaunchUri.toString();

    // if (await canLaunch(_emailLaunchUriString)) {
    //   await launch(_emailLaunchUriString);
    // } else {
    //   throw 'Could not launch $_emailLaunchUriString';
    // }
  }

  void launchCall(String phoneNumber) async {
    // final Uri _callLaunchUri = Uri(
    //   scheme: 'tel',
    //   path: phoneNumber,
    // );
    // final String _callLaunchUriString = _callLaunchUri.toString();

    // if (await canLaunch(_callLaunchUriString)) {
    //   await launch(_callLaunchUriString);
    // } else {
    //   throw 'Could not launch $_callLaunchUriString';
    // }
  }
}
