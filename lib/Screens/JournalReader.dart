import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JournalReader extends StatefulWidget {
  JournalReader(this.doc, {super.key});
  QueryDocumentSnapshot doc;
  @override
  State<JournalReader> createState() => _JournalReaderState();
}

class _JournalReaderState extends State<JournalReader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.doc["entry_title"]),
            Text(widget.doc["creation_date"]),
            SizedBox(height: 28.0),
            Text(widget.doc["entry_content"]),
          ],
        ),
      ),
    );
  }
}
