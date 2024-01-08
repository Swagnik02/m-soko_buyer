import 'package:flutter/material.dart';
import 'package:m_soko/common/utils.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/about_us_banner.png'),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          'About Sokoni',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${GlobalUtil.lorem}\n${GlobalUtil.lorem}\n${GlobalUtil.lorem}',
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
