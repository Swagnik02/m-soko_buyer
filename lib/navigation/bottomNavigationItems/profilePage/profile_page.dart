import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/profilePage/profile_controller.dart';
import 'package:m_soko/navigation/bottomNavigationItems/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    // controller.index = 0;
    return Scaffold(
      body: GetBuilder<ProfileController>(
        builder: (_) => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // main body
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.index == 0
                          ? _miniProfile(controller)
                          : _editProfile(controller, context),
                      const SizedBox(height: 16),
                      controller.index == 0
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _showAboutSection(context),
                                  _otherSection(controller, context),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // EDIT PROFILE
  Widget _editProfile(ProfileController controller, BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset('assets/def_profile.png'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Profile!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tap on the values you \nwant to edit..',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 90.0),
                child: Divider(
                  color: Colors.black26,
                  thickness: 1.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: _editAboutSection(context, controller),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => controller.onTapUpdateProfile(),
                    child: const Text('Update'),
                  ),
                  if (controller.isLoading.value)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Utils.customLoadingSpinner(),
                    ),
                  TextButton(
                    onPressed: () => controller.updateIndex(0),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _editAboutSection(BuildContext context, ProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Primary Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),

        customRow('Username', controller.userNameController,
            'Enter you new Username'),
        Row(
          children: [
            const Icon(CupertinoIcons.device_phone_portrait),
            const SizedBox(width: 5),
            Expanded(
              child: SizedBox(
                height: 20,
                child: TextField(
                  controller: controller.mobileController,
                  decoration: const InputDecoration(
                    hintText: 'Enter you new mobile',
                    contentPadding: EdgeInsets.only(bottom: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 3),
        Row(
          children: [
            const Icon(CupertinoIcons.mail),
            const SizedBox(width: 5),
            Text(UserDataService().userModel!.email),
          ],
        ),

        const SizedBox(height: 25),
        const Text(
          'Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        customRow('City', controller.cityController, 'Enter you new city'),
        customRow(
            'Pincode', controller.pincodeController, 'Enter you new pincode'),
        customRow('State', controller.stateController, 'Enter you new state'),
        customRow(
            'Country', controller.countryController, 'Enter you new country'),
      ],
    );
  }

  // DISPLAY PROFILE

  Widget _miniProfile(ProfileController controller) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset('assets/def_profile.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ${UserDataService().userModel?.userName}!',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${UserDataService().userModel?.mobile}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                controller.updateIndex(1);
              },
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showAboutSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Primary Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(CupertinoIcons.device_phone_portrait),
            const SizedBox(width: 5),
            Text(UserDataService().userModel!.mobile.toString()),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            const Icon(CupertinoIcons.mail),
            const SizedBox(width: 5),
            Text(UserDataService().userModel!.email),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          'Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
            '${UserDataService().userModel!.city} ${UserDataService().userModel!.pin}'),
        const SizedBox(height: 5),
        Text(
            '${UserDataService().userModel!.state}, ${UserDataService().userModel!.country}'),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _otherSection(ProfileController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Activity

        const Text(
          'Activity',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => controller.onTapMyReview(),
          child: const Text(
            'My Review',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        const SizedBox(height: 3),
        Text('${controller.n} Messages Sent'),

        // Manage Accounts
        const SizedBox(height: 25),
        const Text('Manage Accounts'),
        const SizedBox(height: 10),
        InkWell(
          onTap: () => controller.onTapAddAccounts(),
          child: const Text('Add Accounts'),
        ),
        const SizedBox(height: 3),
        InkWell(
          onTap: () => controller.onTapLogOut(),
          child: const Text('Log Out'),
        ),
      ],
    );
  }
}
