import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int n = 4;
  int _index = 0;

  // Controllers for the TextFields in _editProfile
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set initial values for the controllers
    _userNameController.text = Users.userName!;
    _mobileController.text = Users.mobile!;
    _cityController.text = Users.city!;
    _stateController.text = Users.state!;
    _countryController.text = Users.country!;
    _pincodeController.text = Users.pin!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // main body
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _index == 0 ? _miniProfile() : _editProfile(),
                    const SizedBox(height: 16),
                    _index == 0
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _showAboutSection(context),
                                _otherSection(context),
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
    );
  }

  // EDIT PROFILE

  Widget _editProfile() {
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
              padding: const EdgeInsets.all(10),
              child: _editAboutSection(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _index = 0;
                    });
                  },
                  child: const Text('Update'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _index = 0;
                    });
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _editAboutSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Primary Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),

        _customRow('Username', _userNameController, 'Enter you new Username'),
        Row(
          children: [
            const Icon(CupertinoIcons.device_phone_portrait),
            const SizedBox(width: 5),
            Expanded(
              child: SizedBox(
                height: 20,
                child: TextField(
                  controller: _mobileController,
                  decoration: InputDecoration(
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
            Icon(CupertinoIcons.mail),
            SizedBox(width: 5),
            Text(Users.email),
          ],
        ),

        const SizedBox(height: 25),
        const Text(
          'Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        _customRow('City', _cityController, 'Enter you new city'),
        _customRow('Pincode', _pincodeController, 'Enter you new pincode'),
        _customRow('State', _stateController, 'Enter you new state'),
        _customRow('Country', _countryController, 'Enter you new country'),
      ],
    );
  }

  Widget _customRow(
    String label,
    TextEditingController controller,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text('$label:'),
          const SizedBox(width: 5),
          Expanded(
            child: SizedBox(
              height: 20,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: EdgeInsets.only(bottom: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // DISPLAY PROFILE

  Widget _miniProfile() {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello ${Users.userName}!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${Users.mobile}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _index = 1; // Update the index to show the _miniProfile
                });
              },
              icon: Icon(Icons.edit_outlined),
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
            Text(Users.mobile.toString()),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Icon(CupertinoIcons.mail),
            SizedBox(width: 5),
            Text(Users.email),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          'Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text('${Users.city} ${Users.pin}'),
        const SizedBox(height: 5),
        Text('${Users.state}, ${Users.country}'),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _otherSection(BuildContext context) {
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
          onTap: () {
            Fluttertoast.showToast(msg: 'My Review');
          },
          child: const Text(
            'My Review',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        const SizedBox(height: 3),
        Text('$n Messages Sent'),

        // Manage Accounts
        const SizedBox(height: 25),
        const Text('Manage Accounts'),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Fluttertoast.showToast(msg: 'Add Accounts');
          },
          child: const Text('Add Accounts'),
        ),
        const SizedBox(height: 3),
        InkWell(
          onTap: () {
            FirebaseAuth.instance
                .signOut()
                .then((value) => Get.offAllNamed(AppRoutes.loginScreen));
            Fluttertoast.showToast(msg: 'Logged Out');
          },
          child: const Text('Log Out'),
        ),
      ],
    );
  }
}
