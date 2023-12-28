import 'package:flutter/material.dart';

import '../../chat_ui_kit.dart';

/// Builder called to construct parts of the [ChatsListTile] widget.
/// [index] is the item's position in the list
typedef ChatsWidgetBuilder<T extends ChatBase> = Widget Function(
    BuildContext context, int index, ChatBase item);

typedef DateBuilder = Widget Function(BuildContext context, DateTime date);

/// Builder called to construct parts of the [MessagesListTile] widget.
/// [index] is the item's position in the list
typedef MessageWidgetBuilder<T extends MessageBase> = Widget Function(
    BuildContext context, int index, T item, MessagePosition? messagePosition);
