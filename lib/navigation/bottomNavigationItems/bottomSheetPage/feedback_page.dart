import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_soko/common/colors.dart';
import 'package:m_soko/models/user_model.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late final TextEditingController _reviewController = TextEditingController();
  double rating = 0.0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
          child: Material(
            elevation: 5,
            child: Container(
              height: 390,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.bgColour),
              ),
              child: Column(
                children: [
                  // Stars
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: PannableRatingBar(
                      rate: rating,
                      items: List.generate(
                        5,
                        (index) => const RatingWidget(
                          selectedColor: Color(0xFFFFCE31),
                          unSelectedColor: Colors.grey,
                          child: Icon(
                            Icons.star,
                            size: 60,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                  ),

                  // TextField
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 125,
                      decoration: BoxDecoration(
                        color: ColorConstants.bgColour,
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(238, 181, 181, 181),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _reviewController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'Write your words and suggestions to help us improve.',
                            hintStyle: TextStyle(
                              color: Colors.black38,
                            ),
                            hintMaxLines: null,
                          ),
                          maxLines: null,
                        ),
                      ),
                    ),
                  ),

                  // Submit Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 80),
                    child: InkWell(
                      onTap: () {
                        // Call function to submit feedback
                        submitFeedback();
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: ColorConstants.skyBlue,
                        ),
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitFeedback() async {
    if (rating > 0) {
      final timestamp = DateTime.now();

      // Get user's email (replace with your authentication logic)
      final String userEmail = UserDataService().userModel!.email;

      // Create feedback data
      final Map<String, dynamic> feedbackData = {
        'feedback': _reviewController.text,
        'rating': rating,
      };

      final DocumentReference feedbackRef =
          _firestore.collection('buyerAppFeedbacks').doc(userEmail);

      await feedbackRef.set(
        {
          timestamp.toString(): feedbackData,
        },
        SetOptions(merge: true),
      );

      // Show success message
      Fluttertoast.showToast(msg: 'Feedback submitted successfully');

      // Navigate back
      Navigator.pop(context);
    } else {
      // Show error message if no rating is given
      Fluttertoast.showToast(msg: 'Please provide a rating');
    }
  }
}
