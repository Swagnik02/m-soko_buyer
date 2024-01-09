import 'package:flutter/material.dart';

Widget customRow(
  String label,
  TextEditingController controller,
  String hintText,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Text('$label:'),
        const SizedBox(width: 5),
        Expanded(
          child: SizedBox(
            height: 20,
            child: TextField(
              controller: controller,
              keyboardType: label == 'Pincode'
                  ? TextInputType.number
                  : TextInputType.text,
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.only(bottom: 12),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
