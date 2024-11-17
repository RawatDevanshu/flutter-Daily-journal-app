import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_journal/utils/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CrudMethods {
  final FirebaseFirestore _instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  DateTime today = DateTime.now();
  CrudMethods(this._instance);

  Future<void> addData({
    required String title,
    required String data,
    required BuildContext context,
  }) async {
    try {
      _instance
          .collection("users")
          .doc(currentUser!.uid)
          .collection("journals")
          .add({
        'title': title,
        'text': data,
        'date':
            "${today.day}-${today.month}-${today.year}-${today.hour}:${today.minute}",
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  getData() async {
    return await _instance
        .collection("users/${currentUser?.uid}/journals")
        .get();
  }

  Future<void> updateData({
    required String docId,
    required String title,
    required String text,
    required BuildContext context,
  }) async {
    try {
      await _instance
          .collection("users")
          .doc(currentUser!.uid)
          .collection("journals")
          .doc(docId)
          .update({
        'title': title,
        'text': text,
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> delete({required String docId}) async {
    return await _instance
        .collection("users/${currentUser?.uid}/journals")
        .doc(docId)
        .delete();
  }
}
