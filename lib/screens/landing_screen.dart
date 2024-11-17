import 'package:daily_journal/screens/login_screen.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:daily_journal/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
            child: Container(
                decoration: const BoxDecoration(
                  color: Pallete.backgroundColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/images/Book.png',
                      width: 256,
                      height: 256,
                      color: Pallete.backgroundColor,
                      colorBlendMode: BlendMode.darken,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    const Text(
                      "Journaling!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Pallete.dark,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Made Easier, Simpler and Intuitive!",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Pallete.dark,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomButton(
                            height: 48,
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (route) => false);
                            },
                            text: "Get Started")),
                  ],
                ))));
  }
}
