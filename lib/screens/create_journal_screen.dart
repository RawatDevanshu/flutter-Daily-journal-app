import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_crud_methods.dart';
import '../widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../utils/pallete.dart';

/// A screen for creating a new journal entry.
class CreateJournal extends StatelessWidget {
  final TextEditingController dataController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  CreateJournal({super.key});

  void uploadData(String title, String data, BuildContext context) async {
    await CrudMethods(FirebaseFirestore.instance)
        .addData(title: title, data: data, context: context);
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  /// Uploads the journal data to Firestore.
  ///
  /// Takes the title, data, and context to handle navigation after upload.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        actions: [
          GestureDetector(
            onTap: () {
              // Trigger data upload when the save icon is tapped.
              uploadData(titleController.text, dataController.text, context);
            },
            child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.save_rounded, size: 32)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              CustomTextField(
                  controller: titleController, // Controller for title input.
                  hintText: "Title/Quote for the day", // Placeholder text.
                  maxLines: 2), // Allow up to 2 lines for title.
              const SizedBox(height: 20), // Space between fields.
              CustomTextField(
                  controller: dataController, // Controller for data input.
                  hintText: "How was your day?", // Placeholder text.
                  maxLines: 20) // Allow up to 20 lines for data.
            ],
          ),
        ),
      ),
    );
  }
}
