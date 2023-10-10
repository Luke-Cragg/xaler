import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xaler/Home.dart';
import 'package:xaler/Onboarding.dart';
import 'Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Container SignInButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    height: 50,
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: const Text('Log In'),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'XALER';
  static const type = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 120,
          title: Container(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(_title,
                style:
                    GoogleFonts.quicksand(color: Colors.white, fontSize: 60.0)),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: const MainStatefulWidget(),
      ),
    );
  }
}

class MainStatefulWidget extends StatefulWidget {
  const MainStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MainStatefulWidget> createState() => _MainStatefulWidget();
}

class _MainStatefulWidget extends State<MainStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');

    if (email != null && password != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyNav()));
    }
  }

  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future LogIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: nameController.text.trim(),
        password: passwordController.text.trim());
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final Color BackGrey = const Color(0xFF222222);
  final Color DarkBlue = const Color(0xFF02275D);
  final Color Bground = const Color(0xFF003A6C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Bground,
          ),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Log in',
                  style:
                      GoogleFonts.quicksand(fontSize: 30, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'UserName',
                    )),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Password',
                    )),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password'),
              ),
              ElevatedButton(
                onPressed: () async {
                  String email = nameController.text;
                  String password = passwordController.text;
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('email', email);
                  prefs.setString('password', password);

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyNav()));
                },
                child: Text("Sign in"),
              ),
            ],
          )),
    );
  }
}
