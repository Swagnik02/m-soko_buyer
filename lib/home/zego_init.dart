import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallInitPage {
  Future onUserLogin(String userID, String userName) async {
    try {
      await ZegoUIKitPrebuiltCallInvitationService().init(
        appID: 268260452,
        appSign: "7a4f548819ac66227eab9c1f882ded0a38b3b62dd3a52f8bba75c313a015a18b",
        userID: userID,
        userName: userName,
        plugins: [ZegoUIKitSignalingPlugin()],
      );
    // ignore: empty_catches
    } catch (e) {}
  }
}
