import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_soko/common/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallInvitationPage extends StatelessWidget {
  final String callId;

  const CallInvitationPage({super.key, required this.callId});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return ZegoUIKitPrebuiltCall(
      appID: GlobalUtil.appIdForCalling,
      appSign: GlobalUtil.appSignForCalling,
      callID: "1234567",
      userID: /*currentUser!.uid*/ "Mohd'Phone",
      userName: /*currentUser.displayName.toString()*/ "Mohd'Phone",
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
