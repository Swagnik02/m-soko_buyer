import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:m_soko/common/colors.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late final TextEditingController _reviewCOntroller = TextEditingController();
  double rating = 0.0;

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
                          controller: _reviewCOntroller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'Write your words and suggestions to help us improve.',
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
                    child: Expanded(
                      child: InkWell(
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Submit');
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
