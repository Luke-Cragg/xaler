import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<Settings> createState() => SettingsPage();
}

class SettingsPage extends State<Settings> {
  final Color backGround = const Color(0xFF003A6C);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: backGround,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_outlined,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 375,
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('email');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainStatefulWidget()));
                      },
                      child: Text(
                        "Sign out",
                        style: GoogleFonts.merriweather(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
