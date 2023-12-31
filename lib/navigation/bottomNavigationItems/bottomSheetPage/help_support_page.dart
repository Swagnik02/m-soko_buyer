import 'package:flutter/material.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/widgets/launch_link_from_browser.dart';
import 'package:m_soko/widgets/web_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
                      _linkTo(
                        'Visit',
                        GlobalUtil.visitUrl,
                        () async {
                          //  launch from browser
                          // launchURLfromExternalbrowser(GlobalUtil.visitUrl);

                          // launch from WebView
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return TestWebViewPage(GlobalUtil.visitUrl);
                            },
                          ));
                        },
                      ),
                      _linkTo(
                        'Email Us',
                        'customercare@sokoni.com',
                        () {
                          // launchEmail('customercare@sokoni.com');

                          _launchEmailApp();
                        },
                      ),
                      _linkTo(
                        'Call Us',
                        '+91 6257899906',
                        () {
                          // launchCall('+91 6257899906');
                        },
                      ),
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

  _launchEmailApp() async {
    final url = 'mailto:customercare@sokoni.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
