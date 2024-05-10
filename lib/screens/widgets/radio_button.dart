import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class RadioButton extends StatefulWidget {
  final String nameOption1, nameOption2;

  const RadioButton({super.key, required this.nameOption1, required this.nameOption2});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  
  bool? _isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: true,
          groupValue: _isSelected,
          onChanged: (value) {
            setState(() {
              _isSelected = value;
            });
          },
        ),
        Text(
          widget.nameOption1,
          style: TextStyle(fontSize: 20.sp),
        ),
        Radio(
          value: false,
          groupValue: _isSelected,
          onChanged: (value) {
            setState(() {
              _isSelected = value;
            });
          },
        ),
        Text(
          widget.nameOption2,
          style: TextStyle(fontSize: 20.sp),
        ),
      ],
    );
  }
}
