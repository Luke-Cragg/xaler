import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class journalEntry extends StatefulWidget {
  const journalEntry({super.key});

  @override
  State<journalEntry> createState() => _journalEntryState();
}

class _journalEntryState extends State<journalEntry> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String date = DateFormat('d/M/y').format(DateTime.now());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String UserId = '';

//Gets the current signed in users firebase UID. This allows for data to be created
//and retrieved for just that user.
  void GetCurrentUserUID() {
    final User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      UserId = uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color backColor = Color(0xFF38434E);
    GetCurrentUserUID();
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Journal Entry",
          style: GoogleFonts.quicksand(fontSize: 36),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: backColor,
      ),
      body: Container(
        decoration: const BoxDecoration(color: backColor),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  controller: _titleController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your journal title",
                      hintStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(96, 255, 255, 255)),
                      fillColor: Colors.white),
                ),
                const SizedBox(height: 8.0),
                Text(
                  date,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hints:\n• How was today?\n• What was the highlight of your day?\n• What was not so great today?\n• Use this area for whatever you need to vent\n• This is your private safe space to let it out!",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(96, 255, 255, 255),
                          width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      controller: _contentController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your journal entry",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(96, 255, 255, 255))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0XFF1E90FF),
        onPressed: () async {
          FirebaseFirestore.instance
              .collection("Journal")
              .doc(UserId)
              .collection("Entries")
              .add({
            "user_id": UserId,
            "entry_title": _titleController.text,
            "creation_date": date,
            "entry_content": _contentController.text
          }).then((value) {
            Navigator.pop(context);
          }).catchError((error) => print("Failed to add new note: $error"));
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
