import 'package:flutter/material.dart';

import '../../../chat_ui_kit.dart';

class OutgoingMessage<T extends MessageBase> extends StatelessWidget {
  /// The item containing the tile data
  final T item;

  /// The list index of this tile
  final int index;

  /// The custom component builders
  final OutgoingMessageTileBuilders builders;

  /// The message's position relative to other messages
  final MessagePosition? messagePosition;

  OutgoingMessage(
      {Key? key,
      required this.item,
      required this.index,
      OutgoingMessageTileBuilders? builders,
      this.messagePosition = MessagePosition.isolated})
      : builders = builders ?? const OutgoingMessageTileBuilders(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (builders.bodyBuilder != null)
      return builders.bodyBuilder!.call(context, index, item, messagePosition);

    Widget _child;
    if (item.messageType == MessageBaseType.text) {
      _child =
          ChatMessageText(index, item, messagePosition, MessageFlow.outgoing);
    } else if (item.messageType == MessageBaseType.image) {
      _child =
          ChatMessageImage(index, item, messagePosition, MessageFlow.outgoing);
    } else if (item.messageType == MessageBaseType.audio) {
      _child =
          ChatMessageAudio(index, item, messagePosition, MessageFlow.outgoing);
    } else if (item.messageType == MessageBaseType.video) {
      _child =
          ChatMessageVideo(index, item, messagePosition, MessageFlow.outgoing);
    } else {
      _child = Container();
    }
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Align(alignment: Alignment.centerRight, child: _child));
  }
}
