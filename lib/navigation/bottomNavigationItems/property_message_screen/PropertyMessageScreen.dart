import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/navigation/bottomNavigationItems/property_message_screen/property_message_controller.dart';

class PropertyMessageScreen extends StatefulWidget {
  String receiverName;
  String receiverEmail;
  String myName;
  String myEmail;
  String userType;

  PropertyMessageScreen(
      {super.key,
      required this.myEmail,
      required this.userType,
      required this.myName,
      required this.receiverEmail,
      required this.receiverName});

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
    final controller = Get.put(PropertyMessageController());
    return Scaffold(
      backgroundColor: ColorConstants.bgColour,
      appBar: AppBar(
        backgroundColor: ColorConstants.green800,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.receiverName,
          style: const TextStyle(
              color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
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
                        return ListTile(
                          title: Container(
                              margin: const EdgeInsets.only(right: 30),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: Text(
                                data['Text'],
                                textAlign: TextAlign.left,
                              )),
                        );
                      }
                      if (data['Sender'] == widget.myEmail) {
                        return ListTile(
                          title: Container(
                              margin: const EdgeInsets.only(left: 30),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 184, 197, 228),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['Text'],
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              )),
                        );
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
          _buildTextField(
            _textController,
            () {
              controller.uploadDataToFirebase(
                roomID: roomID,
                currentEmail: widget.myEmail,
                receiverEmail: widget.receiverEmail,
                receiverName: widget.receiverName,
                currentName: widget.myName,
                userType: widget.userType,
                controller: _textController,
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, Function onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(left: 14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Enter text...",
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => onTap(),
            child: const CircleAvatar(
              backgroundColor: Colors.indigo,
              child: Center(child: Icon(Icons.send, color: Colors.white)),
            ),
          )
        ],
      ),
    );
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
