import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_journal/screens/display_journal_screen.dart';
import 'package:daily_journal/utils/common_functions.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatefulWidget {
  const CustomListView({super.key});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users/${currentUser?.uid}/journals")
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                QueryDocumentSnapshot<Object?> journal =
                    snapshot.data!.docs[index];
                return CustomTile(
                  entryData: journal,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class CustomTile extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> entryData;
  const CustomTile({super.key, required this.entryData});

  @override
  Widget build(BuildContext context) {
    var dateInfo = convertDateToArray(entryData['date']);
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => DisplayJournal(
                        data: entryData,
                      )),
                ),
              );
            },
            child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: Pallete.white1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${dateInfo[1]} ${dateInfo[2]}, ${dateInfo[0].substring(0, 3)}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Pallete.darkHint,
                                ),
                              ),
                              Text(
                                dateInfo[3],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Pallete.darkHint,
                                ),
                              )
                            ]),
                        const SizedBox(height: 8),
                        Text(
                          entryData['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          entryData['text'].length > 100
                              ? '${entryData['text'].substring(0, 100)}...'
                              : entryData['text'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
        const SizedBox(height: 16),
      ],
    );
  }
}
