import 'package:encrypt_shared_preferences/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Screens/Onboarding.dart';
import 'Navigation.dart';
import 'Login.dart';
import 'API/Firebase_api.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _MainPage(),
    );
  }
}

class _MainPage extends StatefulWidget {
  const _MainPage();
  @override
  State<_MainPage> createState() => MainPage();
}

class MainPage extends State<_MainPage> {
  bool onboarded = false;

  @override
  void initState() {
    super.initState();
    checkOnboarding();
  }

  checkOnboarding() async {
    await EncryptedSharedPreferences.initialize('1111111111111111',
        algorithm: EncryptionAlgorithm.aes);
    var prefs = EncryptedSharedPreferences.getInstance();
    bool complete = prefs.getBoolean('onboardingCompleted') ?? false;

    setState(() {
      onboarded = complete;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              if (user == null) {
                return const Login();
              } else {
                if (onboarded) {
                  return const MyNav();
                } else {
                  return const Onboarding();
                }
              }
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
