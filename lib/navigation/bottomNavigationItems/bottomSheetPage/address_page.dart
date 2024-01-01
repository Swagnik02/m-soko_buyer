import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/address_controller.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController controller = Get.put(AddressController());
    return Scaffold(
      body: GetBuilder<AddressController>(
        builder: (_) => SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
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
                        controller.updateAddAddressIndex();

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
              ),
              controller.addAddressIndex
                  ? _buildAddressContainer(context, controller, '', '')
                  : Container(),
              Expanded(
                child: _builder(context, controller),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressContainer(BuildContext context,
      AddressController controller, String name, String address) {
    controller.addressLineController = TextEditingController(text: address);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Material(
        elevation: 6,
        child: Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: ColorConstants.bgColour,
              ),
            ),
          ),
          height: 186,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: InkWell(
                          onTap: () {
                            controller.updateEditAddressIndex();
                          },
                          child: Icon(Icons.edit_outlined)),
                    ),
                    controller.editAddressIndex
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                          ),
                  ],
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: controller.addressLineController,
                  readOnly: controller.editAddressIndex ? false : true,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _builder(BuildContext context, AddressController controller) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchAddressLines(UserDataService().userModel!.email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              _buildAddressContainer(context, controller, '', ''),
              _buildAddressContainer(context, controller, '', ''),
              _buildAddressContainer(context, controller, '', ''),
            ],
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data found'));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> addressLines = snapshot.data!;
          return ListView.builder(
            itemCount: addressLines.length,
            itemBuilder: (context, index) {
              return _buildAddressContainer(
                context,
                controller,
                (addressLines[index]['name']).toString(),
                (addressLines[index]['address']).toString(),
              );
            },
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchAddressLines(String email) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection(FirestoreCollections.usersCollection)
        .doc(email)
        .collection('addressLines')
        .get();

    return querySnapshot.docs.map((doc) {
      return {
        'name': doc['name'],
        'address': doc['address'],
      };
    }).toList();
  }
}
