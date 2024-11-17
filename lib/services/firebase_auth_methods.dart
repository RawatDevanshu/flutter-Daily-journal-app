import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:daily_journal/utils/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  Stream<User?> get authState => _auth.authStateChanges();

  Future<String> signUpWithEmail({
    required String username,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = "some error occured";
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'username': username,
        'email': email,
      });

      res = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        res = e.code;
      } else {
        showSnackBar(context, e.message!);
      }
    }
    return res;
  }

  Future<String> signInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = "some error occured";
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success";
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
