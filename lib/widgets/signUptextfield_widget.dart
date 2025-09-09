import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class SignUpTextField extends StatelessWidget {
  SignUpTextField({
    super.key,
    required this.hint,
    required this.icon,
    required this.onChange,
    this.obscure = false,
  });
  Function(String)? onChange;
  final IconData icon;
  final String hint;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          obscureText: obscure,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
          onChanged: onChange,
          cursorColor: Colors.teal,
          decoration: InputDecoration(
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
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              color: Color(0xffD9D9D9),
            ),
            contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
            isDense: true,
            errorStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
            ),
            border: InputBorder.none, // no underline
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}