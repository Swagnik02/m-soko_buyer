import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/navigation/bottomNavigationItems/propertyMessageScreen/property_message_screen.dart';

class PropertyMessageList extends StatefulWidget {
  const PropertyMessageList({super.key});

  @override
  State<PropertyMessageList> createState() => _PropertyMessageListState();
}

class _PropertyMessageListState extends State<PropertyMessageList> {
  Map<String, String> chatPeopleList = {'': ""};

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: ColorConstants.bgColour,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Buyers')
            .doc(currentUser?.email.toString() ?? '')
            .collection('Chat History')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                width: double.maxFinite,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () {
                    Get.to(PropertyMessageScreen(
                      receiverEmail: document.id,
                      receiverName: data['Sender'],
                      myEmail: currentUser?.email.toString() ?? '',
                      myName: currentUser?.displayName.toString() ?? '',
                      userType: data['User Type'],
                    ));
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.person_circle_fill,
                              size: 45,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['Sender'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['Last Message'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 57, 57, 57)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${data['User Type']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 13),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
