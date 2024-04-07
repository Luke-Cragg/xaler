import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget journalCard(Function()? onTap, QueryDocumentSnapshot doc,
    Function(String)? onDelete, BuildContext context) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  DeleteConfirmation(context, doc.id, onDelete);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          Text(
            doc["entry_title"],
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            doc["creation_date"],
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

void DeleteConfirmation(
    BuildContext context, String documentId, Function(String)? onDelete) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Journal Delete"),
          content: const Text(
              "Are you sure you want to delete this entry? \nThis cannot be undone."),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  onDelete?.call(documentId);
                  Navigator.of(context).pop();
                },
                child: const Text("Delete"))
          ],
        );
      });
}
