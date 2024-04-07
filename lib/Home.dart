import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';
import 'Screens/Checkin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppState extends ChangeNotifier {
  bool resourceVisit = false;
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => HomePage();
}

class HomePage extends State<Home> {
  int streak = 0;
  String UserId = '';
  String dailyAdvice = '';
  String lastAdviceUpdate = '';
  String lastChallengeUpdate = '';
  String userName = '';
  double progressValue = 0;
  bool challengeComplete = false;
  String dailyChallenge = '';
  late DateTime lastUsedDate;
  final Color backColor = const Color(0xFF38434E);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    GetCurrentUserUID();
    lastAdviceCheck();
    lastChallengeCheck();
    getUserName();
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  Future<void> lastAdviceCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedLastUpdate = prefs.getString('lastAdviceUpdate') ?? '';

    if (savedLastUpdate.isNotEmpty) {
      DateTime lastUpdatedTime = DateFormat.yMMMd().parse(savedLastUpdate);
      if (!isToday(lastUpdatedTime)) {
        await getQuote();
      }
    }
    String savedAdvice = prefs.getString('lastAdvice') ?? '';
    if (savedAdvice.isNotEmpty) {
      setState(() {
        dailyAdvice = savedAdvice;
        lastAdviceUpdate = savedLastUpdate;
      });
    } else {
      await getQuote();
    }
  }

  Future<void> lastChallengeCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedLastChallengeUpdate =
        prefs.getString('lastChallengeUpdate') ?? '';
    if (savedLastChallengeUpdate.isNotEmpty) {
      DateTime lastUpdatedTime =
          DateFormat.yMMMd().parse(savedLastChallengeUpdate);
      if (!isToday(lastUpdatedTime)) {
        prefs.remove('ChallengeStatus');
        await setChallenge();
      }
    }
    String savedChallenge = prefs.getString('lastChallenge') ?? '';
    if (savedChallenge.isNotEmpty) {
      setState(() {
        dailyChallenge = savedChallenge;
        lastChallengeUpdate = savedLastChallengeUpdate;
      });
    } else {
      await setChallenge();
    }
    checkChallenge();
  }

  Future<void> setChallenge() async {
    final snapshot =
        await _firestore.collection('DailyChallenges').doc('Challenges').get();
    final data = snapshot.data();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data != null) {
      final numChallenges = data.length;
      final randomIndex = Random().nextInt(numChallenges) + 1;
      final challenge = data[randomIndex.toString()];
      if (challenge != null) {
        setState(() {
          dailyChallenge = challenge.toString();
          lastChallengeUpdate = DateFormat.yMMMd().format(DateTime.now());
        });
        prefs.setString('lastChallengeUpdate', lastChallengeUpdate);
        prefs.setString('lastChallenge', dailyChallenge);
      }
    }
  }

  Future<void> getQuote() async {
    final snapshot = await _firestore.collection('Quotes').doc('Quote').get();
    final data = snapshot.data();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (data != null) {
      final numQuotes = data.length;
      final randomIndex = Random().nextInt(numQuotes) + 1;
      final quoteField = data[randomIndex.toString()];
      if (quoteField != null) {
        setState(() {
          dailyAdvice = quoteField.toString();
          lastAdviceUpdate = DateFormat.yMMMd().format(DateTime.now());
        });
        prefs.setString('lastAdvice', dailyAdvice);
        prefs.setString('lastAdviceUpdate', lastAdviceUpdate);
      }
    } else {
      print("Error finding document");
      setState(() {
        dailyAdvice = "Error Finding quotes";
      });
    }
  }

  void GetCurrentUserUID() {
    final User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      UserId = uid;
    }
  }

  Future<String> getUserName() async {
    try {
      GetCurrentUserUID();
      CollectionReference users = _firestore.collection('users');
      DocumentSnapshot userDoc = await users.doc(UserId).get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        if (userData.containsKey('fname')) {
          setState(() {
            userName = userData['fname'];
          });
          return userData['fname'];
        }
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      userName = 'Admin';
    });
    return '';
  }

  Future<void> checkChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    challengeComplete = prefs.getBool('ChallengeStatus') ?? false;
    if (challengeComplete) {
      setState(() {
        progressValue = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "XALER",
          style: GoogleFonts.quicksand(fontSize: 50, color: Colors.white),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: backColor),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Hey $userName!",
                    style: GoogleFonts.quicksand(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Daily Advice:',
                    style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  dailyAdvice,
                  style: GoogleFonts.montserratAlternates(
                      color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(height: 45),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 10.0),
                  child: Text(
                    "How are you today?",
                    style: GoogleFonts.quicksand(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 375,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Checkin()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC7BCB1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(3.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Tell me about it",
                    style: GoogleFonts.merriweather(
                        fontSize: 30, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text("Daily Challenge: ",
                          style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 161, 161, 161),
                              width: 3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                              child: Column(
                                children: [
                                  Text(dailyChallenge,
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white, fontSize: 22)),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 350,
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.grey,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.green),
                                      value: progressValue,
                                      minHeight: 30,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
