import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future Signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    //GetCurrentUserUID();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.leave_bags_at_home))
        ],
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: Signin,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
