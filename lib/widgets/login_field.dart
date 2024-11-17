import 'package:daily_journal/utils/pallete.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscured;
  final String? labelText;

  const LoginField({
    super.key,
    required this.hintText,
    required this.controller,
    this.labelText,
    this.isObscured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != null
            ? Text(
                labelText!,
                style: const TextStyle(
                  color: Pallete.dark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            obscureText: isObscured,
            style: const TextStyle(color: Pallete.dark, fontSize: 17),
            cursorColor: Pallete.dark,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Pallete.dark,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Pallete.dark,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Pallete.white2,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
