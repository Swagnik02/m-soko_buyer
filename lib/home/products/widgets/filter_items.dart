import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  final String label;
  final Function onPressedAction;
  final bool isSelected;

  const FilterItem({
    super.key,
    required this.label,
    required this.onPressedAction,
    this.isSelected = false,
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
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
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
