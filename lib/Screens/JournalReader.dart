import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JournalReader extends StatefulWidget {
  JournalReader(this.doc, {super.key});
  QueryDocumentSnapshot doc;
  @override
  State<JournalReader> createState() => _JournalReaderState();
}

class _JournalReaderState extends State<JournalReader> {
  final Color backColor = const Color(0xFF38434E);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.doc["entry_title"],
                style: GoogleFonts.quicksand(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.doc["creation_date"],
                style: GoogleFonts.quicksand(fontSize: 22, color: Colors.white),
              ),
              SizedBox(height: 28.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.doc["entry_content"],
                  style:
                      GoogleFonts.quicksand(fontSize: 22, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
