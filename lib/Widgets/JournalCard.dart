import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget journalCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: [
          Text(doc["entry_title"]),
          Text(doc["creation_date"]),
          Text(doc["entry_content"]),
        ],
      ),
    ),
  );
}
