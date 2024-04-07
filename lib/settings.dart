import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xaler/Screens/About.dart';
import 'package:xaler/Screens/Privacy.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  final Color backGround = const Color(0xFF38434E);
  String UserId = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void GetCurrentUserUID() {
    final User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      UserId = uid;
    }
  }

  void deleteConfirmation(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("CONFIRM ACCOUNT DELETE"),
            content: const Text(
                "Are you sure you want to delete your account? \nTHIS ACTION CANNOT BE UNDONE."),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    try {
                      await _firestore
                          .collection('DailyInfo')
                          .doc(UserId)
                          .delete();
                    } catch (e) {
                      print("No daily info to delete");
                    }

                    try {
                      await _firestore
                          .collection('Journal')
                          .doc(UserId)
                          .delete();
                    } catch (e) {
                      print("No journals to delete");
                    }
                    try {
                      await _firestore.collection('users').doc(UserId).delete();
                    } catch (e) {
                      print("No User details to delete");
                    }

                    try {
                      await _auth.currentUser!.delete();
                    } catch (e) {
                      print(e);
                    }
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Delete"))
            ],
          );
        });
  }

  Future<void> resetPassword() async {
    try {
      User? user = _auth.currentUser;
      await _auth.sendPasswordResetEmail(email: user!.email!);
      Fluttertoast.showToast(
          msg: "Reset email has been sent. Please check your email",
          toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      Fluttertoast.showToast(
          msg:
              "Error sending reset email. Please report issue via feedback button on the about page",
          toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: backGround,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_outlined,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  visualDensity: const VisualDensity(vertical: 3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: backGround, width: 1)),
                  tileColor: Colors.white,
                  title: Center(
                    child: Text(
                      "About",
                      style: GoogleFonts.merriweather(color: Colors.black),
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutPage()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  visualDensity: const VisualDensity(vertical: 3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: backGround, width: 1)),
                  tileColor: Colors.white,
                  title: Center(
                    child: Text(
                      "Privacy Policy",
                      style: GoogleFonts.merriweather(color: Colors.black),
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Privacy()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                    visualDensity: const VisualDensity(vertical: 3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: backGround, width: 1)),
                    tileColor: Colors.white,
                    title: Center(
                      child: Text(
                        "Reset Password",
                        style: GoogleFonts.merriweather(color: Colors.black),
                      ),
                    ),
                    onTap: () {
                      resetPassword();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  visualDensity: const VisualDensity(vertical: 3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: backGround, width: 1)),
                  tileColor: Colors.blue,
                  title: Center(
                    child: Text(
                      "Sign out",
                      style: GoogleFonts.merriweather(color: Colors.black),
                    ),
                  ),
                  onTap: () async {
                    await _auth.signOut();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  visualDensity: const VisualDensity(vertical: 3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: backGround, width: 1)),
                  tileColor: Colors.white,
                  title: Center(
                    child: Text(
                      "DELETE ACCOUNT",
                      style: GoogleFonts.merriweather(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onTap: () {
                    deleteConfirmation(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
