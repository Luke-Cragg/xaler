import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Journal.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
    GetCurrentUserUID();
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal Entry"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your journal title"),
            ),
            SizedBox(height: 8.0),
            Text(date),
            SizedBox(height: 20),
            TextField(
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your journal entry"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
        child: Icon(Icons.save),
      ),
    );
  }
}
