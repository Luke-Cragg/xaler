import 'package:flutter/material.dart';

class Vent extends StatefulWidget {
  const Vent({super.key});
  @override
  State<Vent> createState() => MainVent();
}

class MainVent extends State<Vent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vent"),
      ),
      body: Text("Vent"),
    );
  }
}
