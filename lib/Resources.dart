import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Navigation.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});
  @override
  State<Resources> createState() => MainResources();
}

class MainResources extends State<Resources> {
  String samnum = '';
  String SHOUTnum = '';
  @override
  void initState() {
    super.initState();
    getContactData();
    setResourceChallenge();
  }

  Future<void> setResourceChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentChallenge = prefs.getString('lastChallenge') ?? '';
    if (currentChallenge == "Visit the resource page") {
      await prefs.setBool('ChallengeStatus', true);
    }
  }

  Future<void> getContactData() async {
    try {
      DocumentSnapshot samaritans = await FirebaseFirestore.instance
          .collection('EmergencyContacts')
          .doc('Samaritans')
          .get();
      if (samaritans.exists) {
        setState(() {
          samnum = samaritans.get('Tel');
        });
      } else {
        samnum = '116123';
      }
    } catch (error) {
      print("error conntecting to DB: $error");
      samnum = '116123';
    }
    try {
      DocumentSnapshot SHOUT = await FirebaseFirestore.instance
          .collection('EmergencyContacts')
          .doc('SHOUT')
          .get();
      if (SHOUT.exists) {
        setState(() {
          SHOUTnum = SHOUT.get('Tel');
        });
      } else {
        SHOUTnum = '85258';
      }
    } catch (error) {
      print("error conntecting to DB: $error");
      SHOUTnum = '85258';
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color backColor = Color(0xFF38434E);
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources",
            style: GoogleFonts.quicksand(fontSize: 42, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: backColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                visualDensity: const VisualDensity(vertical: 3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.blueGrey,
                title: const Text("Call Samaritans FREE 24/7 Emergency Line"),
                onTap: () async {
                  Uri samNum = Uri.parse('tel:$samnum');
                  if (await launchUrl(samNum)) {
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            'Unable to open, Please dial $samnum for samaritans',
                        toastLength: Toast.LENGTH_LONG);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.blueGrey,
                title: const Text("Text SHOUT FREE 24/7 Emergency Number"),
                onTap: () async {
                  Uri SHOUT = Uri.parse('sms:$SHOUTnum');
                  if (await launchUrl(SHOUT)) {
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            'Unable to open, Please text $SHOUTnum for samaritans',
                        toastLength: Toast.LENGTH_LONG);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.blueGrey,
                title: const Text(
                    "Looking to get started with running?\nCheck out our friends at Couch to 5k to get started"),
                onTap: () async {
                  StoreRedirect.redirect(androidAppId: 'com.phe.couchto5K');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.blueGrey,
                title: const Text(
                    "Keeping a journal is a great way to look back on positives or see how far you have come on your mental health journey! \nCheck out our journal feature here"),
                onTap: () async {
                  final CurvedNavigationBarState? navBarState =
                      bottomNavKey.currentState;
                  navBarState?.setPage(2);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.blueGrey,
                title: const Text(
                    "Meditation is a great way to relieve some stress from the day, or even just to improve your mindfulness. \nCheck out our mindfulness page here to view our hand picked selection of meditations"),
                onTap: () async {
                  final CurvedNavigationBarState? navBarState =
                      bottomNavKey.currentState;
                  navBarState?.setPage(1);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                tileColor: Colors.blueGrey,
                title: const Text(
                    "Our meditation audios come from our friends over at the FreeMindfulnessProject. \nYou can check them out by pressing here!"),
                onTap: () async {
                  Uri mindfulness =
                      Uri.parse('https://www.freemindfulness.org/welcome');
                  if (await launchUrl(mindfulness)) {
                  } else {
                    Fluttertoast.showToast(
                        msg:
                            'Unable to redirect to The Free Mindfulness project.',
                        toastLength: Toast.LENGTH_LONG);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
