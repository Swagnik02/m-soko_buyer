import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterItem extends StatelessWidget {
  final String label;
  final Function onPressedAction;
  final bool isSelected;
  Color? color;

  const FilterItem({
    super.key,
    required this.label,
    required this.onPressedAction,
    this.isSelected = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressedAction();
      },
      child: Container(
        height: 42,
        alignment: Alignment.center,
<<<<<<< HEAD
        margin: EdgeInsets.only(right: Get.width * 0.02),
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.002, horizontal: Get.width * 0.02),
=======
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
>>>>>>> main
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.black54,
            width: 1.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
