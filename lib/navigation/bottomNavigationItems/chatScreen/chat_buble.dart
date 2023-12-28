import 'package:flutter/material.dart';
import 'package:m_soko/common/colors.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String timeAgo;
  final bool isSender;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSender,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    var alignment = (isSender) ? Alignment.centerLeft : Alignment.centerRight;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (isSender) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          mainAxisAlignment:
              (isSender) ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:
                    isSender ? ColorConstants.blue50 : ColorConstants.blue600,
              ),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 16,
                    color: isSender ? Colors.black : ColorConstants.blue50),
              ),
            ),
            Text(timeAgo),
          ],
        ),
      ),
    );
  }
}
