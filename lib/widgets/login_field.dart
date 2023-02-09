import 'package:daily_journal/utils/pallete.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscured;
  const LoginField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscured = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: TextFormField(
        controller: controller,
        obscureText: isObscured,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Pallete.gradient2,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Pallete.gradient3,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
