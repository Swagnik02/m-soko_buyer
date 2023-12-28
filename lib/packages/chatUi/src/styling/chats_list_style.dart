import 'package:flutter/material.dart';

/// Styling and settings for [ChatsList].
class ChatsListStyle {
  /// [ScrollPhysics] parameter for the list of chats.
  /// Defaults to platform default.
  final ScrollPhysics? physics;

  /// [EdgeInsetsGeometry] parameter for the list of chats.
  final EdgeInsetsGeometry? padding;

  const ChatsListStyle({this.physics, this.padding});
}
