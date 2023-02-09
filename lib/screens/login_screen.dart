import 'package:daily_journal/screens/home_screen.dart';
import 'package:daily_journal/services/firebase_auth_methods.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:daily_journal/widgets/gradient_button.dart';
import 'package:daily_journal/widgets/login_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginScreen({super.key});

  void dipose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void signUpUser(BuildContext context) async {
    String res = await FirebaseAuthMethods(FirebaseAuth.instance)
        .signUpWithEmail(
            email: emailController.text,
            password: passwordController.text,
            context: context);
    if (res == 'email-already-in-use') {
      logInUser(context);
    } else if (res == "success") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }
  }

  void logInUser(BuildContext context) async {
    String res = await FirebaseAuthMethods(FirebaseAuth.instance)
        .signInWithEmail(
            email: emailController.text,
            password: passwordController.text,
            context: context);
    if (res == "success") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/grav_journal.png',
                scale: 2,
                color: Pallete.backgroundColor,
                colorBlendMode: BlendMode.darken,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Sign in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Pallete.gradient2,
                ),
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              LoginField(
                hintText: 'Password',
                controller: passwordController,
                isObscured: true,
              ),
              const SizedBox(height: 15),
              GradientButton(
                text: 'Sign in',
                onPressed: () {
                  signUpUser(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
