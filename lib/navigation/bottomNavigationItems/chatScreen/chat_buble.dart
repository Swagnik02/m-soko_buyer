import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String timeAgo;
  final bool isBuyer;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isBuyer,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    var alignment = (isBuyer) ? Alignment.centerLeft : Alignment.centerRight;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
        child: Column(
          crossAxisAlignment:
              (isBuyer) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          mainAxisAlignment:
              (isBuyer) ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isBuyer ? ColorConstants.blue50 : ColorConstants.blue600,
              ),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 16,
                    color: isBuyer ? Colors.black : ColorConstants.blue50),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(timeAgo),
            ),
          ],
        ),
      ),
    );
  }
}

// chat bubble for banners
class BannerChatBubble extends StatelessWidget {
  final String imageUrl;
  final String message;
  final String timeAgo;
  final bool isBuyer;

  const BannerChatBubble({
    super.key,
    required this.imageUrl,
    required this.message,
    required this.isBuyer,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 290,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorConstants.blue50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(imageUrl, height: 185, width: 185),
                Text(
                  textAlign: TextAlign.center,
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(timeAgo),
          ),
        ],
      ),
    );
  }
}
