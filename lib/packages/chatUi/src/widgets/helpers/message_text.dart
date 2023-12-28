import 'package:flutter/material.dart';

import '../../../chat_ui_kit.dart';

/// A default Widget that can be used to display text
/// This is more an example to give you an idea how to structure your own Widget
class ChatMessageText extends StatelessWidget {
  const ChatMessageText(
      this.index, this.message, this.messagePosition, this.messageFlow,
      {Key? key})
      : super(key: key);

  final int index;

  final MessageBase message;

  final MessagePosition? messagePosition;

  final MessageFlow messageFlow;

  @override
  Widget build(BuildContext context) {
    return MessageContainer(
        decoration: messageDecoration(context,
            messagePosition: messagePosition, messageFlow: messageFlow),
        child: Wrap(alignment: WrapAlignment.end, children: [
          Text(message.text ?? "", style: TextStyle(color: Colors.black)),
          MessageFooter(message)
        ]));
  }
}
