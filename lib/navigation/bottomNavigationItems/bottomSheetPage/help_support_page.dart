import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';

import 'package:m_soko/widgets/web_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  HelpSupportPageState createState() => HelpSupportPageState();
}

class HelpSupportPageState extends State<HelpSupportPage> {
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

                      // Chat with us Button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Fluttertoast.showToast(msg: 'Chat With US');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorConstants.skyBlue,
                                ),
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: ImageIcon(
                                        AssetImage(
                                            'assets/icons/chat_bubble_icon.png'),
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Chat with us!',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),

                      // Get help and support anytime
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Get help and support anytime',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        GlobalUtil.lorem,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                        ),
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: onTapAction,
            child: Text(
              link,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ColorConstants.skyBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
