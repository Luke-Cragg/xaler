import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xaler/Navigation.dart';
import '../Login.dart';
import 'package:google_fonts/google_fonts.dart';

final _formKey = GlobalKey<FormState>();

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfirmController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  String UserId = '';

  void AddNameInfo() async {
    GetCurrentUserUID();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    CollectionReference users = _firestore.collection('users');
    DocumentReference userDoc = users.doc(UserId);

    await userDoc.set({
      'fname': fnameController.text.trim(),
      'surname': surnameController.text.trim(),
    });
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    final isValid = regex.hasMatch(value ?? '');
    if (!isValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  Future<void> _signUp() async {
    try {
      validateEmail(emailController.text);
      if (passController.text != passConfirmController.text) {
        Fluttertoast.showToast(msg: 'Passwords do not match');
      } else {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passController.text.trim());
        AddNameInfo();
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MyNav()));
        }
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  void GetCurrentUserUID() {
    final User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      UserId = uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color backGround = Color(0xFF003A6C);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "XALER",
          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 60),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: backGround,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_outlined,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: backGround),
        padding: const EdgeInsets.all(16.0),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Register",
                        style: GoogleFonts.quicksand(
                            fontSize: 30, color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white),
                    validator: validateEmail,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                      controller: fnameController,
                      decoration: const InputDecoration(
                          labelText: 'First Name',
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                      controller: surnameController,
                      decoration: const InputDecoration(
                          labelText: 'Surname',
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your Surname';
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                      controller: passController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Password is Empty';
                        }
                        return null;
                      }),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: passConfirmController,
                    obscureText: true,
                    onChanged: (val) {
                      val = passConfirmController.text;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Password is Empty';
                      }
                      if (val != passController.text) {
                        Fluttertoast.showToast(msg: 'Passwords do not match');
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                      _signUp();
                    },
                    child: const Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
