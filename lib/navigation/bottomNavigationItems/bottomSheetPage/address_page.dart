import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: const BoxDecoration(
                    color: ColorConstants.blue50,
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            color: ColorConstants.skyBlue, width: 1))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      Fluttertoast.showToast(msg: 'Add');
                    },
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: Icon(
                            Icons.add_rounded,
                            size: 20,
                            color: ColorConstants.skyBlue,
                          ),
                        ),
                        Text(
                          'Add a new address',
                          style: TextStyle(
                              color: ColorConstants.skyBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // ListView(
              //   children: <Widget>[
              //     ListTile(
              //       leading: Icon(Icons.notifications_active_outlined),
              //       title: Text('Notifications'),
              //       onTap: () {},
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
