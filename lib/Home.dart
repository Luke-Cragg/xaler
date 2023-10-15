import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'settings.dart';
import 'Checkin.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => HomePage();
}

class HomePage extends State<Home> {
  final Color backColor = const Color(0xFF38434E);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "XALER",
            style: GoogleFonts.quicksand(fontSize: 42, color: Colors.white),
          ),
          backgroundColor: backColor,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.settings,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: backColor),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
                  child: Text(
                    "How are you today?",
                    style: GoogleFonts.quicksand(
                        fontSize: 28, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 375,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Checkin()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffC7BCB1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(3.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Tell me about it",
                    style: GoogleFonts.merriweather(
                        //fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
