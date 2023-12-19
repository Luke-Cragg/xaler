import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});
  @override
  State<Resources> createState() => MainResources();
}

class MainResources extends State<Resources> {
  List<ListTile> resources = [
    ListTile(
      title: Text("Samaritans Emergency Line"),
      onTap: () async {
        Uri samNum = Uri.parse('tel:116123');
        if (await launchUrl(samNum)) {
        } else {
          Fluttertoast.showToast(
              msg: 'Unable to open, Please dial 116 123 for samaritans',
              toastLength: Toast.LENGTH_LONG);
        }
      },
    ),
    ListTile(),
  ];
  @override
  Widget build(BuildContext context) {
    final Color backColor = const Color(0xFF38434E);
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources",
            style: GoogleFonts.quicksand(fontSize: 42, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: backColor,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  visualDensity: VisualDensity(vertical: 3),
                  tileColor: Colors.blueGrey,
                  leading: Text("Leading"),
                  title: Text("Samaritans Emergency Line"),
                  onTap: () async {
                    Uri samNum = Uri.parse('tel:116123');
                    if (await launchUrl(samNum)) {
                    } else {
                      Fluttertoast.showToast(
                          msg:
                              'Unable to open, Please dial 116 123 for samaritans',
                          toastLength: Toast.LENGTH_LONG);
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  tileColor: Colors.blueGrey,
                  leading: Text("Leading"),
                  title: Text("Second tile"),
                  onTap: () async {
                    Uri samNum = Uri.parse('tel:116123');
                    if (await launchUrl(samNum)) {
                    } else {
                      Fluttertoast.showToast(
                          msg:
                              'Unable to open, Please dial 116 123 for samaritans',
                          toastLength: Toast.LENGTH_LONG);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
