import 'package:flutter/material.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});
  @override
  State<Resources> createState() => MainResources();
}

class MainResources extends State<Resources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
      ),
      body: Text("Resources"),
    );
  }
}
