import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xaler/Screens/JournalEntry.dart';
import 'package:xaler/Screens/JournalReader.dart';
import 'package:xaler/Widgets/JournalCard.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  final Color backColor = const Color(0xFF38434E);
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

  Future<void> setJournalChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentChallenge = prefs.getString('lastChallenge') ?? '';
    if (currentChallenge == "Create a journal entry") {
      await prefs.setBool('ChallengeStatus', true);
    }
  }

  void deleteJournalEntry(String documentId) {
    FirebaseFirestore.instance
        .collection("Journal")
        .doc(UserId)
        .collection("Entries")
        .doc(documentId)
        .delete()
        .then((_) {
      print("Deleted Journal");
    }).catchError((error) {
      print("Failed to delete");
    });
  }

  @override
  Widget build(BuildContext context) {
    GetCurrentUserUID();
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal",
            style: GoogleFonts.quicksand(color: Colors.white, fontSize: 42)),
        elevation: 0,
        backgroundColor: backColor,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: backColor),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text("Recent Notes",
                  style:
                      GoogleFonts.quicksand(color: Colors.white, fontSize: 26)),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("Journal")
                  .doc(UserId)
                  .collection("Entries")
                  .where("user_id", isEqualTo: UserId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    children: snapshot.data!.docs
                        .map((note) => journalCard(
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JournalReader(note),
                                ),
                              );
                            },
                            note,
                            (String documentId) {
                              deleteJournalEntry(documentId);
                            },
                            context))
                        .toList(),
                  );
                } else {
                  return Text(
                    "There are no journals to display",
                    style: GoogleFonts.quicksand(color: Colors.black),
                  );
                }
              },
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0XFF1E90FF),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const journalEntry()));
          setJournalChallenge();
        },
        label: const Text("Add Entry"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
