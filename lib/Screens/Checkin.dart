import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Checkin extends StatefulWidget {
  const Checkin({Key? key}) : super(key: key);
  @override
  State<Checkin> createState() => CheckinPage();
}

class CheckinPage extends State<Checkin> {
  final Color XalerBlue = const Color(0xFF38434E);
  final _PageController = PageController();
  bool isLastPage = false;
  int mood = 0;
  int activityLevel = 0;
  int socialLevel = 0;
  int total = 0;
  bool Q1Answered = false;
  bool Q2Answered = false;
  bool Q3Answered = false;

  String CurrentDate = DateFormat('dMy').format(DateTime.now());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String UserId = '';
  String activityAdvice = '';
  String moodAdvice = '';
  String socialAdvice = '';
  String finalResponse = '';
  String finalActivityResponse = '';
  String finalSocialResponse = '';

//Gets the current signed in users firebase UID. This allows for data to be created
//and retrieved for just that user.
  void GetCurrentUserUID() {
    final User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      UserId = uid;
    }
  }

  void CreateDailyInfo() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    GetCurrentUserUID();

    final json = {
      'mood': mood,
      'Activity': activityLevel,
      'Socialising': socialLevel,
      'total': total
    };

    final CollectionReference collection =
        _firestore.collection('DailyInfo').doc(UserId).collection(CurrentDate);
    final QuerySnapshot collectionData = await collection.get();
    if (collectionData.docs.isEmpty) {
      await collection.add(json);
    }
  }

  Future<String> getRandomActivityResult(int score) async {
    CollectionReference collectionReference;
    if (score > 2) {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('ActivityLevel')
          .collection('highActivity');
    } else {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('ActivityLevel')
          .collection('poorActivity');
    }

    QuerySnapshot querySnapshot = await collectionReference.get();
    int randomIndex = Random().nextInt(querySnapshot.docs.length);
    Map<String, dynamic> data =
        querySnapshot.docs[randomIndex].data() as Map<String, dynamic>;
    return data['response'];
  }

  Future<String> getRandomSocialResult(int score) async {
    CollectionReference collectionReference;
    if (score > 2) {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('SocialisingLevel')
          .collection('HighSocial');
    } else {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('SocialisingLevel')
          .collection('LowSocial');
    }

    QuerySnapshot querySnapshot = await collectionReference.get();
    int randomIndex = Random().nextInt(querySnapshot.docs.length);
    Map<String, dynamic> data =
        querySnapshot.docs[randomIndex].data() as Map<String, dynamic>;
    return data['response'];
  }

  Future<String> getRandomMoodResult(int score) async {
    CollectionReference collectionReference;
    if (score > 2) {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('MoodLevel')
          .collection('HighMood');
    } else {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('MoodLevel')
          .collection('LowMood');
    }

    QuerySnapshot querySnapshot = await collectionReference.get();
    int randomIndex = Random().nextInt(querySnapshot.docs.length);
    Map<String, dynamic> data =
        querySnapshot.docs[randomIndex].data() as Map<String, dynamic>;
    return data['response'];
  }

  Future<String> getRandomFinalResult(int score) async {
    CollectionReference collectionReference;
    if (score > 10) {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('Finals')
          .collection('HighFinal');
    } else if (score < 10 && score >= 5) {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('Finals')
          .collection('MediumFinal');
    } else {
      collectionReference =
          _firestore.collection('Checkin').doc('Finals').collection('LowFinal');
    }

    QuerySnapshot querySnapshot = await collectionReference.get();
    int randomIndex = Random().nextInt(querySnapshot.docs.length);
    Map<String, dynamic> data =
        querySnapshot.docs[randomIndex].data() as Map<String, dynamic>;
    return data['response'];
  }

  Future<String> getFinalActivityResponse(int score) async {
    CollectionReference collectionReference;
    if (score > 2) {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('Finals')
          .collection('HighActivity');
    } else {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('Finals')
          .collection('LowActivity');
    }

    QuerySnapshot querySnapshot = await collectionReference.get();
    int randomIndex = Random().nextInt(querySnapshot.docs.length);
    Map<String, dynamic> data =
        querySnapshot.docs[randomIndex].data() as Map<String, dynamic>;
    return data['response'];
  }

  Future<String> getFinalSocialResponse(int score) async {
    CollectionReference collectionReference;
    if (score > 2) {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('Finals')
          .collection('HighSocial');
    } else {
      collectionReference = _firestore
          .collection('Checkin')
          .doc('Finals')
          .collection('LowSocial');
    }

    QuerySnapshot querySnapshot = await collectionReference.get();
    int randomIndex = Random().nextInt(querySnapshot.docs.length);
    Map<String, dynamic> data =
        querySnapshot.docs[randomIndex].data() as Map<String, dynamic>;
    return data['response'];
  }

  Future<void> setCheckinChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentChallenge = await prefs.getString('lastChallenge') ?? '';
    if (currentChallenge == "Complete a check in today") {
      await prefs.setBool('ChallengeStatus', true);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _PageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) => Scaffold(
        body: Container(
            padding: const EdgeInsets.only(bottom: 0),
            child: PageView(
                controller: _PageController,
                onPageChanged: (index) {
                  setState(() => isLastPage = index == 3);
                },
                children: [
                  Container(
                    color: Color(0xff915c83),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 250,
                          ),
                          Text(
                            'How do you feel today?',
                            style: GoogleFonts.quicksand(
                                fontSize: 32, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 80,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: Q1Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              mood = 4;
                                              total = total + mood;
                                              Q1Answered = true;
                                            });
                                            String result =
                                                await getRandomMoodResult(mood);
                                            setState(() {
                                              moodAdvice = result;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(20),
                                        backgroundColor:
                                            const Color(0xffC7BCB1),
                                        minimumSize: const Size(100, 100)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Very Good",
                                        style: GoogleFonts.merriweather(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: Q1Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              mood = 2;
                                              total = total + mood;
                                              Q1Answered = true;
                                            });
                                            String result =
                                                await getRandomMoodResult(mood);
                                            setState(() {
                                              moodAdvice = result;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color(0xffC7BCB1),
                                      minimumSize: const Size(100, 100),
                                    ),
                                    child: Text(
                                      "Not Great",
                                      style: GoogleFonts.merriweather(
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: Q1Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              mood = 3;
                                              total = total + mood;
                                              Q1Answered = true;
                                            });
                                            String result =
                                                await getRandomMoodResult(mood);
                                            setState(() {
                                              moodAdvice = result;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color(0xffC7BCB1),
                                      minimumSize: const Size(100, 100),
                                    ),
                                    child: Text(
                                      "Pretty good",
                                      style: GoogleFonts.merriweather(
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: Q1Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              mood = 1;
                                              total = total + mood;
                                              Q1Answered = true;
                                            });
                                            String result =
                                                await getRandomMoodResult(mood);
                                            setState(() {
                                              moodAdvice = result;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color(0xffC7BCB1),
                                      minimumSize: const Size(100, 100),
                                    ),
                                    child: Text(
                                      "Terrible",
                                      style: GoogleFonts.merriweather(
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: SizedBox(
                              width: 250,
                              height: 250,
                              child: Text(
                                moodAdvice,
                                style: GoogleFonts.quicksand(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xffa4dded),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 210,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'What was your activity level today?',
                              style: GoogleFonts.quicksand(
                                  fontSize: 32, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 80,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: Q2Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              activityLevel = 4;
                                              total = total + activityLevel;
                                              Q2Answered = true;
                                            });
                                            String result =
                                                await getRandomActivityResult(
                                                    activityLevel);
                                            setState(() {
                                              activityAdvice = result;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(20),
                                        backgroundColor:
                                            const Color(0xfff6b19b),
                                        minimumSize: const Size(100, 100)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Very active",
                                        style: GoogleFonts.merriweather(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: Q2Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              activityLevel = 2;
                                              total = total + activityLevel;
                                              Q2Answered = true;
                                            });
                                            String result =
                                                await getRandomActivityResult(
                                                    activityLevel);
                                            setState(() {
                                              activityAdvice = result;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color(0xfff6b19b),
                                      minimumSize: const Size(100, 100),
                                    ),
                                    child: Text(
                                      "A little",
                                      style: GoogleFonts.merriweather(
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: Q2Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              activityLevel = 3;
                                              total = total + activityLevel;
                                              Q2Answered = true;
                                            });
                                            String result =
                                                await getRandomActivityResult(
                                                    activityLevel);
                                            setState(() {
                                              activityAdvice = result;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color(0xfff6b19b),
                                      minimumSize: const Size(100, 100),
                                    ),
                                    child: Text(
                                      "Quite Active",
                                      style: GoogleFonts.merriweather(
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: Q2Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              activityLevel = 1;
                                              total = total + activityLevel;
                                              Q2Answered = true;
                                            });
                                            String result =
                                                await getRandomActivityResult(
                                                    activityLevel);
                                            setState(() {
                                              activityAdvice = result;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color(0xfff6b19b),
                                      minimumSize: const Size(100, 100),
                                    ),
                                    child: Text(
                                      "Very little",
                                      style: GoogleFonts.merriweather(
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: SizedBox(
                              width: 350,
                              height: 250,
                              child: Text(
                                activityAdvice,
                                style: GoogleFonts.quicksand(
                                    color: Colors.black, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      color: XalerBlue,
                      child: Center(
                          child: Column(children: [
                        const SizedBox(
                          height: 210,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Did you socialise much today?',
                            style: GoogleFonts.quicksand(
                                fontSize: 32, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 80,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: Q3Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              socialLevel = 4;
                                              total = total + socialLevel;
                                              Q3Answered = true;
                                            });
                                            String result =
                                                await getRandomSocialResult(
                                                    socialLevel);
                                            String finalTotal =
                                                await getRandomFinalResult(
                                                    total);
                                            String finalActivity =
                                                await getFinalActivityResponse(
                                                    activityLevel);
                                            String finalSocial =
                                                await getFinalSocialResponse(
                                                    socialLevel);
                                            setState(() {
                                              socialAdvice = result;
                                              finalResponse = finalTotal;
                                              finalActivityResponse =
                                                  finalActivity;
                                              finalSocialResponse = finalSocial;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(20),
                                        backgroundColor:
                                            const Color(0xffC7BCB1),
                                        minimumSize: const Size(100, 100)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Yes, lots",
                                        style: GoogleFonts.merriweather(
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: Q3Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              socialLevel = 2;
                                              total = total + socialLevel;
                                              Q3Answered = true;
                                            });
                                            String result =
                                                await getRandomSocialResult(
                                                    socialLevel);
                                            String finalTotal =
                                                await getRandomFinalResult(
                                                    total);
                                            String finalActivity =
                                                await getFinalActivityResponse(
                                                    activityLevel);
                                            String finalSocial =
                                                await getFinalSocialResponse(
                                                    socialLevel);
                                            setState(() {
                                              socialAdvice = result;
                                              finalResponse = finalTotal;
                                              finalActivityResponse =
                                                  finalActivity;
                                              finalSocialResponse = finalSocial;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color(0xffC7BCB1),
                                      minimumSize: const Size(100, 100),
                                    ),
                                    child: Text(
                                      "Usual amount",
                                      style: GoogleFonts.merriweather(
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Column(children: [
                                ElevatedButton(
                                    onPressed: Q3Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              socialLevel = 3;
                                              total = total + socialLevel;
                                              Q3Answered = true;
                                            });
                                            String result =
                                                await getRandomSocialResult(
                                                    socialLevel);
                                            String finalTotal =
                                                await getRandomFinalResult(
                                                    total);
                                            String finalActivity =
                                                await getFinalActivityResponse(
                                                    activityLevel);
                                            String finalSocial =
                                                await getFinalSocialResponse(
                                                    socialLevel);
                                            setState(() {
                                              socialAdvice = result;
                                              finalResponse = finalTotal;
                                              finalActivityResponse =
                                                  finalActivity;
                                              finalSocialResponse = finalSocial;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color(0xffC7BCB1),
                                      minimumSize: const Size(100, 100),
                                    ),
                                    child: Text(
                                      "A bit more",
                                      style: GoogleFonts.merriweather(
                                          color: Colors.black),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: Q3Answered
                                        ? null
                                        : () async {
                                            setState(() {
                                              socialLevel = 1;
                                              total = total + socialLevel;
                                              Q3Answered = true;
                                            });
                                            String result =
                                                await getRandomSocialResult(
                                                    socialLevel);
                                            String finalTotal =
                                                await getRandomFinalResult(
                                                    total);
                                            String finalActivity =
                                                await getFinalActivityResponse(
                                                    activityLevel);
                                            String finalSocial =
                                                await getFinalSocialResponse(
                                                    socialLevel);
                                            setState(() {
                                              socialAdvice = result;
                                              finalResponse = finalTotal;
                                              finalActivityResponse =
                                                  finalActivity;
                                              finalSocialResponse = finalSocial;
                                            });
                                          },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(20),
                                      backgroundColor: const Color(0xffC7BCB1),
                                      minimumSize: const Size(100, 100),
                                    ),
                                    child: Text(
                                      "Very little",
                                      style: GoogleFonts.merriweather(
                                          color: Colors.black),
                                    ))
                              ])
                            ]),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: SizedBox(
                            width: 250,
                            height: 250,
                            child: Text(
                              socialAdvice,
                              style: GoogleFonts.quicksand(
                                  color: Colors.white, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]))),
                  Container(
                    decoration: BoxDecoration(color: XalerBlue),
                    child: Column(
                      children: [
                        const SizedBox(height: 150),
                        SizedBox(
                            width: 300,
                            child: Text(finalResponse,
                                style: GoogleFonts.merriweather(
                                    color: const Color(0xffC7BCB1),
                                    fontSize: 18),
                                textAlign: TextAlign.center)),
                        const SizedBox(height: 30),
                        SizedBox(
                            width: 300,
                            child: Text(finalActivityResponse,
                                style: GoogleFonts.merriweather(
                                    color: const Color(0xffC7BCB1),
                                    fontSize: 18),
                                textAlign: TextAlign.center)),
                        const SizedBox(height: 30),
                        SizedBox(
                            width: 300,
                            child: Text(finalSocialResponse,
                                style: GoogleFonts.merriweather(
                                    color: const Color(0xffC7BCB1),
                                    fontSize: 18),
                                textAlign: TextAlign.center)),
                      ],
                    ),
                  )
                ])),
        bottomSheet: isLastPage
            ? TextButton(
                style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  foregroundColor: Colors.blue,
                  backgroundColor: const Color(0xFF3A3A3A),
                  minimumSize: const Size.fromHeight(60),
                ),
                onPressed: () async {
                  CreateDailyInfo();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MyNav()));
                  setCheckinChallenge();
                },
                child: Text(
                  'Finish',
                  style: GoogleFonts.quicksand(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () => _PageController.previousPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeOutCirc),
                          child: Text('Back',
                              style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _PageController,
                          count: 3,
                          effect: const WormEffect(
                              spacing: 16,
                              dotColor: Colors.black38,
                              activeDotColor: Colors.blue),
                        ),
                      ),
                      TextButton(
                          onPressed: () => _PageController.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeOutCirc),
                          child: Text('Next',
                              style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))),
                    ]),
              ),
      );
}
