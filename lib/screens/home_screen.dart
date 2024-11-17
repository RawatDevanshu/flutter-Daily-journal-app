import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_journal/screens/create_journal_screen.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:daily_journal/widgets/custom_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<DocumentSnapshot> userData;

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
  }

  Future<DocumentSnapshot> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    } else {
      throw Exception("User not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.backgroundColor,
          title: const Text("Home",
              style: TextStyle(
                  color: Pallete.dark,
                  fontSize: 24,
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        drawer: Builder(
          builder: (context) => FutureBuilder<DocumentSnapshot>(
            future: userData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Drawer(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Drawer(
                  child: Center(child: Text("Error: ${snapshot.error}")),
                );
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Drawer(
                  child: Center(
                      child: Text("No Entries Yet!!",
                          style: TextStyle(color: Pallete.darkHint))),
                );
              }
              // Pass the actual data to CustomDrawer
              return CustomDrawer(userData: snapshot.data!);
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: FloatingActionButton(
                backgroundColor: Pallete.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateJournal()));
                },
                child: const Icon(
                  Icons.edit,
                  color: Pallete.white2,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 80,
            ),
          ],
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: userData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(
                    child: Text("No Entries Yet!!",
                        style: TextStyle(color: Pallete.darkHint)));
              } else {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: const CustomListView(),
                );
              }
            }));
  }
}
