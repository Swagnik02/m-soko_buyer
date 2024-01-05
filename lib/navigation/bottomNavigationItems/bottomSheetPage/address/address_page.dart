import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/common/utils.dart';
import 'package:m_soko/navigation/bottomNavigationItems/bottomSheetPage/address/address_controller.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController controller = Get.put(AddressController());
    controller.context = context;
    return Scaffold(
      body: GetBuilder<AddressController>(
        builder: (_) => SafeArea(
          child: Column(
            children: [
              // add address button
              _addAddressButton(controller),

              // add address field
              controller.addAddressIndex
                  ? _addAddressContainer(
                      controller,
                    )
                  : Container(),

              // Saved Address along with delete button
              Expanded(child: _listViewBody(controller)),
            ],
          ),
        ),
      ),
    );
  }

  // body
  // add address button
  Widget _addAddressButton(AddressController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
            color: ColorConstants.blue50,
            border: Border.symmetric(
                horizontal:
                    BorderSide(color: ColorConstants.skyBlue, width: 1))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Add Button
              InkWell(
                onTap: () => controller.updateAddAddressIndex(),
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
            ],
          ),
        ),
      ),
    );
  }

  // ListView saved addresses
  ListView _listViewBody(AddressController controller) {
    return ListView(
      children: controller.addressLinesMap.keys.map((String key) {
        String name = key.toString();
        String address = (controller.addressLinesMap[key]).toString();
        return _buildAddressContainer(controller, name, address, key);
      }).toList(),
    );
  }

  // saved address along with delete button containers
  Widget _buildAddressContainer(
      AddressController controller, String name, String address, String key) {
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
          height: 150,
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
                          // EDIT/SAVE Button
                          InkWell(
                            onTap: () => controller.onTapEditAddress(key),
                            child: const Icon(
                              Icons.edit_outlined,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),

                          // delete address button
                          InkWell(
                            onTap: () => controller.removeEntry(name),
                            child: const Icon(
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

  // add address containers
  Widget _addAddressContainer(AddressController controller) {
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
                        onPressed: () => controller.onTapAddNewAddress(
                          controller.addReceipentNameController,
                          controller.addAddressController,
                        ),
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
}
