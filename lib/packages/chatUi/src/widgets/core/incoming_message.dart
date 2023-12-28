import 'package:flutter/material.dart';

import '../../../chat_ui_kit.dart';

/// The default helper widget that represents an incoming [MessageBase]
/// It will build a title by default (author's username) above the user's first message
/// The avatar is built if you supply [IncomingMessageTileBuilders.avatarBuilder]
/// You can position the avatar on the first or last message with [MessageStyle.avatarBehaviour]
/// This widget display simple text by default
class IncomingMessage<T extends MessageBase> extends StatelessWidget {
  /// The item containing the tile data
  final T item;

  /// The list index of this tile
  final int index;

  /// Custom styling you want to apply
  final MessageStyle? style;

  /// The custom component builders
  final IncomingMessageTileBuilders builders;

  /// The message's position relative to other messages
  final MessagePosition? messagePosition;

  IncomingMessage(
      {Key? key,
      required this.item,
      required this.index,
      IncomingMessageTileBuilders? builders,
      this.messagePosition = MessagePosition.isolated,
      this.style = const MessageStyle()})
      : builders = builders ?? const IncomingMessageTileBuilders(),
        super(key: key);

  bool get _shouldBuildAvatar =>
      builders.avatarBuilder != null &&
      (messagePosition == MessagePosition.isolated ||
          (messagePosition == MessagePosition.surroundedBot &&
              style!.avatarBehaviour == AvatarBehaviour.alwaysTop) ||
          (messagePosition == MessagePosition.surroundedTop &&
              style!.avatarBehaviour == AvatarBehaviour.alwaysBottom));

  bool get _shouldBuildTitle =>
      builders.titleBuilder != null &&
      messagePosition != MessagePosition.surrounded &&
      messagePosition != MessagePosition.surroundedTop;

  @override
  Widget build(BuildContext context) {
    Widget _child;

    if (builders.bodyBuilder != null) {
      _child =
          builders.bodyBuilder!.call(context, index, item, messagePosition);
    } else {
      if (item.messageType == MessageBaseType.text) {
        _child =
            ChatMessageText(index, item, messagePosition, MessageFlow.incoming);
      } else if (item.messageType == MessageBaseType.image) {
        _child = ChatMessageImage(
            index, item, messagePosition, MessageFlow.incoming);
      } else if (item.messageType == MessageBaseType.audio) {
        _child = ChatMessageAudio(
            index, item, messagePosition, MessageFlow.incoming);
      } else if (item.messageType == MessageBaseType.video) {
        _child = ChatMessageVideo(
            index, item, messagePosition, MessageFlow.incoming);
      } else {
        _child = Container();
      }
    }

    final _messageBody = Row(
      crossAxisAlignment: style!.avatarBehaviour == AvatarBehaviour.alwaysTop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        if (_shouldBuildAvatar)
          builders.avatarBuilder!.call(context, index, item, messagePosition),
        if (!_shouldBuildAvatar && builders.avatarBuilder != null)
          Container(width: style!.avatarWidth),
        _child
      ],
    );

    if (!_shouldBuildTitle) return _messageBody;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: style!.avatarWidth),
            if (builders.titleBuilder != null)
              builders.titleBuilder!.call(context, index, item, messagePosition)
          ],
        ),
        _messageBody
      ],
    );
  }
}
