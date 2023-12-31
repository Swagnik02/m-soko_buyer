import 'package:flutter/material.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/widgets/web_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
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
                        GlobalUtil.contactEmail,
                        () {
                          final Uri emailLaunchUri = Uri(
                              scheme: 'mailto', path: GlobalUtil.contactEmail);

                          launchUrl(emailLaunchUri);
                        },
                      ),
                      _linkTo(
                        'Call Us',
                        GlobalUtil.contactMobile,
                        () {
                          final Uri emailLaunchUri = Uri(
                              scheme: 'tel', path: GlobalUtil.contactMobile);

                          launchUrl(emailLaunchUri);
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
            onTap: onTapAction,
            child: Text(
              link,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.blue[500],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
