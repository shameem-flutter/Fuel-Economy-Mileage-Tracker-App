import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obsecureText;
  final Color backgroundColor;
  final Color textColor;
  final Color labelColor;
  final FontStyle labelFontStyle;
  final double borderRadius;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.number,
    this.validator,
    this.obsecureText = false,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.labelColor = Colors.black,
    this.labelFontStyle = FontStyle.italic,
    this.borderRadius = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obsecureText,
            validator: validator,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 8),
              border: InputBorder.none,
              hintText: labelText,
              hintStyle: TextStyle(
                color: labelColor,
                fontStyle: labelFontStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
