import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:m_soko/common/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class HomeScreenController extends GetxController {
  String get userId => FirebaseAuth.instance.currentUser?.uid ?? "";
  final currentUser = FirebaseAuth.instance.currentUser;

  // String get userName =>
  int navBarIndex = 2; // Some Changes here
  int topBarIndex = 0; // Some Changes here

  @override
  void onInit() {
    super.onInit();
    intializeCalling(
      userId: currentUser!.email.toString(),
      userName: currentUser!.displayName.toString(),
    );
  }

  void intializeCalling({
    required String userId,
    required String userName,
  }) {
    try {
      ZegoUIKitPrebuiltCallInvitationService().init(
        appID: GlobalUtil.appIdForCalling /*input your AppID*/,
        appSign: GlobalUtil.appSignForCalling /*input your AppSign*/,
        userID: userId,
        userName: userName,
        plugins: [
          ZegoUIKitSignalingPlugin(),
        ],
      );
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  void updateTopBarIndex(index) {
    topBarIndex = index;
    update();
  }

  void updateNavBarIndex(changedIndex) {
    navBarIndex = changedIndex;
    update();
  }
}
