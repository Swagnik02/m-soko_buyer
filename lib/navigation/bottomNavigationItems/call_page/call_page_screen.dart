import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/navigation/bottomNavigationItems/call_page/call_page_controller.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallsPropertyScreen extends StatefulWidget {
  const CallsPropertyScreen({super.key});

  @override
  State<CallsPropertyScreen> createState() => _CallsPropertyScreenState();
}

class _CallsPropertyScreenState extends State<CallsPropertyScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CallPageController());
    return Scaffold(
        backgroundColor: ColorConstants.bgColour,
        body: StreamBuilder<QuerySnapshot>(
          stream: controller.getCallHistoryFromFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('No data');
            } else {
              final documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  bool detailed = false;
                  final document = documents[index];
                  Timestamp timestamp = document['Date-Time'];
                  DateTime dateTime = timestamp.toDate();
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(dateTime);
                  String formattedTime =
                      DateFormat('HH:mm:ss').format(dateTime);
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return ListTile(
                        onTap: () {
                          if (detailed) {
                            setState(() {
                              detailed = false;
                            });
                          } else {
                            setState(() {
                              detailed = true;
                            });
                          }
                        },
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        title: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (document['User Type'] == "Agents")
                                    ? "AGENT"
                                    : "SELLER",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontSize: 13),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            if (document['Direction'] ==
                                                'Outgoing')
                                              const Icon(
                                                Icons.call_made_rounded,
                                                color: Colors.green,
                                              ),
                                            if (document['Direction'] ==
                                                'Incoming')
                                              const Icon(
                                                Icons.call_received_rounded,
                                                color: Colors.red,
                                              ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Text(
                                            document['Name'],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: ZegoSendCallInvitationButton(
                                      onPressed: (code, message, p2) async {
                                        DateTime nowTime = DateTime.now();
                                        await FirebaseFirestore.instance
                                            .collection('Buyers')
                                            .doc(controller.currentUser?.email)
                                            .collection('Call History')
                                            .doc()
                                            .set({
                                          'Name': document['Name'],
                                          'CallID': document['CallID'],
                                          'Direction': "Outgoing",
                                          'Date-Time': nowTime,
                                          'User Type': document['User Type'],
                                        });
                                        await FirebaseFirestore.instance
                                            .collection(
                                                (document['User Type'] ==
                                                        "Seller")
                                                    ? "users"
                                                    : "Agents")
                                            .doc(document['CallID'])
                                            .collection('Call History')
                                            .doc()
                                            .set({
                                          'Name': controller
                                              .currentUser?.displayName,
                                          'CallID':
                                              controller.currentUser?.email,
                                          'Direction': "Incoming",
                                          'Date-Time': nowTime,
                                          'User Type': "Seller"
                                        });
                                        setState(() {});
                                      },
                                      notificationTitle:
                                          controller.currentUser?.displayName,
                                      notificationMessage:
                                          "Buyer is calling you",
                                      buttonSize: const Size(50, 50),
                                      icon: ButtonIcon(
                                          icon: const Icon(Icons.call)),
                                      iconSize: const Size(40, 40),
                                      isVideoCall: false,
                                      resourceID: "zego_sokoni",
                                      invitees: [
                                        ZegoUIKitUser(
                                          id: document['CallID'],
                                          name: document['Name'],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (detailed)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Date",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          formattedDate,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 81, 81, 81)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Time",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          formattedTime,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 81, 81, 81)),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ));
  }
}
