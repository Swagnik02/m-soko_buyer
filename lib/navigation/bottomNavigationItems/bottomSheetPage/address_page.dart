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
    Map<String, List<String>>? addressLinesMap =
        UserDataService().userModel?.addressLines;
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
                  ? _addAddressContainer(
                      context,
                      controller,
                    )
                  : Container(),
              Expanded(
                child: ListView.builder(
                  itemCount: addressLinesMap?.length ?? 0,
                  itemBuilder: (context, index) {
                    String name =
                        addressLinesMap?.values.elementAt(index)[0] ?? '';
                    String address =
                        addressLinesMap?.values.elementAt(index)[1] ?? '';

                    return _buildAddressContainer(
                      context,
                      controller,
                      name,
                      address,
                    );
                  },
                ),
              ),
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 15),
                      child: Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: InkWell(
                                onTap: () {
                                  controller.updateEditAddressIndex();
                                },
                                child: const Icon(Icons.edit_outlined)),
                          ),
                          controller.editAddressIndex
                              ? InkWell(
                                  onTap: () =>
                                      controller.updateEditAddressIndex(),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                )
                              : const InkWell(
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextField(
                    controller: controller.addressLineController,
                    readOnly: controller.editAddressIndex ? false : true,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addAddressContainer(
      BuildContext context, AddressController controller) {
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
          height: 170,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.addReceipentNameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter name of the reciever',
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (controller.isLoading)
                      Container(
                        height: 48,
                        width: 48,
                        padding: const EdgeInsets.all(8.0),
                        child: Utils.customLoadingSpinner(),
                      )
                    else
                      TextButton(
                        child: const Text('save'),
                        onPressed: () => controller.onTapAddNewAddress(),
                      )
                  ],
                ),
                Expanded(
                  child: TextField(
                    controller: controller.addAddressController,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Enter the address',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<List<Map<String, dynamic>>> fetchAddressLines(String email) async {
  //   var querySnapshot = await FirebaseFirestore.instance
  //       .collection(FirestoreCollections.usersCollection)
  //       .doc(email)
  //       .collection('addressLines')
  //       .get();

  //   return querySnapshot.docs.map((doc) {
  //     return {
  //       'name': doc['name'],
  //       'address': doc['address'],
  //     };
  //   }).toList();
  // }
}
