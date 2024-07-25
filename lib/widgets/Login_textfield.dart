// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    required this.onSubmitted,
    this.obscure = false,
    this.suffixIcon = false,
  });
  final IconData icon;
  final String label;
  final Function(String)? onSubmitted;
  bool obscure;
  final bool suffixIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  void update() {
    setState(() {
      widget.obscure = !widget.obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "This field is required.";
            }
            return null;
          },
          obscureText: widget.obscure,
          onChanged: widget.onSubmitted,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon
                ? (widget.obscure
                ? IconButton(
              icon: const Icon(
                Icons.visibility_off,
                color: Color(0xffDEDEDE),
              ),
              onPressed: update,
            )
                : IconButton(
              icon: const Icon(Icons.visibility,
                  color: Color(0xffDEDEDE)),
              onPressed: update,
            ))
                : null,
            prefixIcon: Container(
              margin: const EdgeInsets.only(right: 15),
              width: 66,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                ),
                color: kPrimaryColor,
              ),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            hintText: widget.label,
            hintStyle: TextStyle(
              fontSize: 16,
              fontFamily: kFontText,
              color: const Color(0xffD9D9D9),
            ),
            contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
            isDense: true,
            errorStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
            ),
            border: InputBorder.none, // Remove underline
            enabledBorder: InputBorder.none, // Remove underline
            focusedBorder: InputBorder.none, // Remove underline
            disabledBorder: InputBorder.none, // Remove underline
          ),
        ),
      ),
    );
  }
}
