import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Login.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim());
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
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
        decoration: BoxDecoration(color: backGround),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text("Register",
                    style: GoogleFonts.quicksand(
                        fontSize: 30, color: Colors.white)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            ElevatedButton(onPressed: _signUp, child: Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}
