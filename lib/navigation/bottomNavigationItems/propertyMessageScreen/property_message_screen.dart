import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/models/user_model.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

// ignore: must_be_immutable
class PropertyMessageScreen extends StatefulWidget {
  String receiverName;
  String receiverEmail;
  String myName;
  String myEmail;
  String userType;

  PropertyMessageScreen({
    super.key,
    required this.myEmail,
    required this.userType,
    required this.myName,
    required this.receiverEmail,
    required this.receiverName,
  });

  @override
  State<PropertyMessageScreen> createState() => _PropertyMessageScreenState();
}

class _PropertyMessageScreenState extends State<PropertyMessageScreen> {
  final TextEditingController _textController = TextEditingController();
  String roomID = "";

  @override
  void initState() {
    super.initState();
    findChatRoomId(widget.receiverEmail, widget.myEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: ColorConstants.green700,
        title: Text(
          widget.receiverName,
          style: const TextStyle(
              color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/chat_bg2.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color.fromARGB(116, 0, 0, 0).withOpacity(0.3),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            if (roomID == "")
              const Expanded(
                  child: Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()))),
            if (roomID != "")
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chatrooms')
                      .doc(roomID)
                      .collection('messages')
                      .orderBy('Date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data?.docs.length ?? 0,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        if (data['Sender'] == widget.receiverEmail) {
                          Timestamp timestamp = data['Date'];
                          return ChatBubble(
                            clipper: ChatBubbleClipper1(
                                type: BubbleType.receiverBubble),
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(
                                top: 20, left: 10, right: 70, bottom: 5),
                            backGroundColor: Colors.white,
                            padding: const EdgeInsets.fromLTRB(30, 12, 6, 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['Text'],
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  formatTimestamp(timestamp),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 88, 88, 88)),
                                )
                              ],
                            ),
                          );
                        }
                        if (data['Sender'] == widget.myEmail) {
                          Timestamp timestamp = data['Date'];
                          return ChatBubble(
                            clipper:
                                ChatBubbleClipper1(type: BubbleType.sendBubble),
                            alignment: Alignment.topRight,
                            margin: const EdgeInsets.only(
                                top: 20, right: 10, left: 70, bottom: 5),
                            padding: const EdgeInsets.fromLTRB(15, 12, 30, 12),
                            backGroundColor:
                                const Color.fromRGBO(231, 234, 243, 1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['Text'],
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  formatTimestamp(timestamp),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 88, 88, 88)),
                                )
                              ],
                            ),
                          );
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 2),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              style: const TextStyle(
                                  color: Colors.black), // Set text color
                              cursorColor: Colors.black, // Set cursor color
                              decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                        msg: "Under Construction");
                                  },
                                  icon: const Icon(
                                      Icons.emoji_emotions_outlined)),
                                suffixIcon: IconButton(
                              onPressed: () {
                                Fluttertoast.showToast(
                                    msg: "Under Construction");
                              },
                              icon: const Icon(Icons.attach_file_rounded)),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03),
                                hintText: 'Write message here',
                                hintStyle: const TextStyle(fontSize: 14),
                                // Set hint text color
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors
                                          .transparent), // Set border color
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors
                                          .transparent), // Set enabled border color
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.blue700,
                    ),
                    width: 60,
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (_textController.text != "") {
                          if (roomID == "blank") {
                            DocumentReference<Map<String, dynamic>>
                                newChatRoomRef = FirebaseFirestore.instance
                                    .collection('chatrooms')
                                    .doc();
                            await newChatRoomRef.set({
                              'Last Message': "",
                              'Participants': [
                                widget.myEmail,
                                widget.receiverEmail
                              ],
                            }).then((value) {
                              setState(() {
                                roomID = newChatRoomRef.id;
                              });
                            });
                            String x = _textController.text;
                            _textController.text = "";
                            await FirebaseFirestore.instance
                                .collection('chatrooms')
                                .doc(roomID)
                                .collection('messages')
                                .doc('${DateTime.now().millisecondsSinceEpoch}')
                                .set({
                              'Date': DateTime.now(),
                              'Seen': "False",
                              'Sender': widget.myEmail,
                              'Text': x,
                              'Type': "message",
                            });
                            await FirebaseFirestore.instance
                                .collection('Buyers')
                                .doc(widget.myEmail)
                                .collection('Chat History')
                                .doc(widget.receiverEmail)
                                .set({
                              'Last Message Date': DateTime.now(),
                              'Last Message': x,
                              'Sender': widget.receiverName,
                              'User Type': widget.userType
                            });
                            await FirebaseFirestore.instance
                                .collection((widget.userType == "Seller")
                                    ? "users"
                                    : "Agents")
                                .doc(widget.receiverEmail)
                                .collection('Chat History')
                                .doc(widget.myEmail)
                                .set({
                              'Last Message Date': DateTime.now(),
                              'Last Message': x,
                              'Sender': widget.myName,
                              'User Type': 'Buyers'
                            });
                          } else if (roomID != "") {
                            String x = _textController.text;
                            _textController.text = "";
                            await FirebaseFirestore.instance
                                .collection('chatrooms')
                                .doc(roomID)
                                .collection('messages')
                                .doc('${DateTime.now().millisecondsSinceEpoch}')
                                .set({
                              'Date': DateTime.now(),
                              'Seen': "False",
                              'Sender': widget.myEmail,
                              'Text': x,
                              'Type': "message",
                            });
                            await FirebaseFirestore.instance
                                .collection('Buyers')
                                .doc(widget.myEmail)
                                .collection('Chat History')
                                .doc(widget.receiverEmail)
                                .update({
                              'Last Message Date': DateTime.now(),
                              'Sender': widget.receiverName,
                              'Last Message': x,
                            });
                            await FirebaseFirestore.instance
                                .collection((widget.userType == "Seller")
                                    ? "users"
                                    : "Agents")
                                .doc(widget.receiverEmail)
                                .collection('Chat History')
                                .doc(widget.myEmail)
                                .update({
                              'Last Message Date': DateTime.now(),
                              'Sender': UserDataService()
                                  .userModel!
                                  .userName
                                  .toString(),
                              'Last Message': x,
                            });
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    // Create a DateTime object from the Timestamp
    DateTime dateTime = timestamp.toDate();
    String formattedDate = "";
    if (isToday(dateTime)) {
      formattedDate = DateFormat('HH:mm').format(dateTime);
    } else {
      formattedDate = DateFormat('MM-dd HH:mm').format(dateTime);
    }
    return formattedDate;
  }

  bool isToday(DateTime dateTime) {
    DateTime now = DateTime.now();

    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  void findChatRoomId(String participantId1, String participantId2) async {
    try {
      String localRoomID = "";
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('chatrooms').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> room
          in querySnapshot.docs) {
        List<dynamic>? participants = room.data()['Participants'];

        if (participants != null &&
            participants.contains(participantId1) &&
            participants.contains(participantId2)) {
          setState(() {
            localRoomID = room.id;
          });
        }
      }
      if (localRoomID == "") {
        setState(() {
          roomID = "blank";
        });
      } else {
        setState(() {
          roomID = localRoomID;
        });
      }
    } catch (e) {}
  }
}
