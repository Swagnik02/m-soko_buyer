import 'dart:io';

import 'package:flutter/material.dart';

import '../../../chat_ui_kit.dart';

/// A default Widget that can be used to load an image
/// This is more an example to give you an idea how to structure your own Widget,
/// since too many aspects would require to be customized, for instance
/// implementing your own image loader, padding, constraints, footer etc.
class ChatMessageImage extends StatelessWidget {
  const ChatMessageImage(
      this.index, this.message, this.messagePosition, this.messageFlow,
      {Key? key, this.callback})
      : super(key: key);

  final int index;

  final MessageBase message;

  final MessagePosition? messagePosition;

  final MessageFlow messageFlow;

  final void Function()? callback;

  @override
  Widget build(BuildContext context) {
    final Widget _image = message.url.startsWith('/')
        ? Image.file(File(message.url),
            errorBuilder: (_, e, s) => Icon(Icons.broken_image))
        : Image.network(message.url,
            errorBuilder: (_, e, s) => Icon(Icons.broken_image));

    return MessageContainer(
        constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
        padding: EdgeInsets.zero,
        decoration: messageDecoration(context,
            messagePosition: messagePosition,
            messageFlow: messageFlow,
            color: Colors.transparent),
        child: GestureDetector(
            onTap: callback ?? () => {},
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Hero(tag: message.url, child: _image),
                MessageFooter(message)
              ],
            )));
  }
}
