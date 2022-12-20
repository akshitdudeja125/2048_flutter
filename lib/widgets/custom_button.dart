import 'package:flutter/material.dart';
import 'package:flutter_2048/utils/colors.dart';

class CustomButton extends StatefulWidget {
  final Icon icon;
  final VoidCallback onPressed;
  const CustomButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: IconButton(
          color: textColorWhite,
          onPressed: widget.onPressed,
          icon: widget.icon),
    );
  }
}
