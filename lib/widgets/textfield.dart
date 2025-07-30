import 'package:flutter/material.dart';
import 'package:task/constants/color_constants.dart';

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
    this.textColor = Colors.black,
    this.labelColor = Colors.black,
    this.labelFontStyle = FontStyle.normal,
    this.borderRadius = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obsecureText,
          validator: validator,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: secondaryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.only(left: 8),

            hintText: labelText,
            hintStyle: TextStyle(color: labelColor, fontStyle: labelFontStyle),
          ),
        ),
      ],
    );
  }
}
