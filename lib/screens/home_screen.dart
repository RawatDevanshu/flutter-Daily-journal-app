import 'package:daily_journal/screens/Create_journal_screen.dart';
import 'package:daily_journal/screens/login_screen.dart';
import 'package:daily_journal/services/firebase_auth_methods.dart';
import 'package:daily_journal/utils/pallete.dart';
import 'package:daily_journal/widgets/gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? currUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.gradient1,
        title: const Text("Entries"),
        centerTitle: true,
      ),
      drawer: Drawer(
          backgroundColor: Pallete.backgroundColor,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Pallete.gradient1),
                child: Column(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Pallete.gradient3,
                      size: 100,
                    ),
                    Text(
                      "${currUser?.email}",
                      style: const TextStyle(color: Pallete.gradient3),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              GradientButton(
                text: 'Sign Out',
                onPressed: () async {
                  await FirebaseAuthMethods(FirebaseAuth.instance).signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
              ),
            ],
          )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: FloatingActionButton(
              backgroundColor: Pallete.gradient2,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateJournal()));
              },
              child: const Icon(
                Icons.add,
                color: Pallete.backgroundColor,
                size: 50,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
            height: 150,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const CustomListView(),
      ),
    );
  }
}
