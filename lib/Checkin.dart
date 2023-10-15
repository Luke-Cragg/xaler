import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'Navigation.dart';
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
    //   final json = {
    //     'mood': mood,
    //     'Activity': activityLevel,
    //     'Socialising': socialLevel,
    //     'total': total
    //   };
    //   await dailyUpdate.add(json);
    // }
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
                                        : () {
                                            setState(
                                              () {
                                                mood = 4;
                                                total = total + mood;
                                                Q1Answered = true;
                                              },
                                            );
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
                                        : () {
                                            setState(
                                              () {
                                                mood = 2;
                                                total = total + mood;
                                                Q1Answered = true;
                                              },
                                            );
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
                                        : () {
                                            setState(
                                              () {
                                                mood = 3;
                                                total = total + mood;
                                                Q1Answered = true;
                                              },
                                            );
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
                                        : () {
                                            setState(
                                              () {
                                                mood = 1;
                                                total = total + mood;
                                                Q1Answered = true;
                                              },
                                            );
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
                          mood == 4 || mood == 3
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                  child: SizedBox(
                                      width: 150,
                                      height: 60,
                                      child: Text(
                                        "Thats great to hear!",
                                        style: GoogleFonts.quicksand(
                                            color: Colors.white, fontSize: 20),
                                        textAlign: TextAlign.center,
                                      )))
                              : mood == 2 || mood == 1
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 40, 0, 0),
                                      child: SizedBox(
                                          width: 150,
                                          height: 60,
                                          child: Text(
                                            "I'm sorry to hear!",
                                            style: GoogleFonts.quicksand(
                                                color: Colors.white,
                                                fontSize: 20),
                                            textAlign: TextAlign.center,
                                          )))
                                  : Text("")
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
                                        : () {
                                            setState(
                                              () {
                                                activityLevel = 4;
                                                total = total + activityLevel;
                                                Q2Answered = true;
                                              },
                                            );
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
                                        : () {
                                            setState(() {
                                              activityLevel = 2;
                                              total = total + activityLevel;
                                              Q2Answered = true;
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
                                        : () {
                                            setState(() {
                                              activityLevel = 3;
                                              total = total + activityLevel;
                                              Q2Answered = true;
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
                                        : () {
                                            setState(() {
                                              activityLevel = 1;
                                              total = total + activityLevel;
                                              Q2Answered = true;
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
                          activityLevel == 4 || activityLevel == 3
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                  child: SizedBox(
                                      width: 150,
                                      height: 60,
                                      child: Text(
                                        "Thats fantastic, well done!",
                                        style: GoogleFonts.quicksand(
                                            color: Colors.white, fontSize: 20),
                                        textAlign: TextAlign.center,
                                      )))
                              : activityLevel == 2 || activityLevel == 1
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 40, 0, 0),
                                      child: SizedBox(
                                          width: 200,
                                          height: 200,
                                          child: Text(
                                            "Did you know that even small amounts \nof physical activity can reduce dementia and depression by up to 30%",
                                            style: GoogleFonts.quicksand(
                                                color: Colors.black,
                                                fontSize: 16),
                                            textAlign: TextAlign.center,
                                          )))
                                  : const Text(""),
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
                                        : () {
                                            setState(() {
                                              socialLevel = 4;
                                              total = total + socialLevel;
                                              Q3Answered = true;
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
                                        : () {
                                            setState(() {
                                              socialLevel = 2;
                                              total = total + socialLevel;
                                              Q3Answered = true;
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
                                        : () {
                                            setState(() {
                                              socialLevel = 3;
                                              total = total + socialLevel;
                                              Q3Answered = true;
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
                                        : () {
                                            setState(() {
                                              socialLevel = 1;
                                              total = total + socialLevel;
                                              Q3Answered = true;
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
                        socialLevel == 4 || socialLevel == 3
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                child: SizedBox(
                                    width: 150,
                                    height: 60,
                                    child: Text(
                                      "Thats great, socialising is key to improving mental health!",
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    )))
                            : socialLevel == 2 || socialLevel == 1
                                ? Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                    child: SizedBox(
                                        width: 200,
                                        height: 200,
                                        child: Text(
                                          "Did you know socialising with family, friends and even new people can massively help manage mental health symptoms",
                                          style: GoogleFonts.quicksand(
                                              color: Colors.white,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        )))
                                : const Text(""),
                      ]))),
                  total >= 10
                      ? Container(
                          decoration: BoxDecoration(color: XalerBlue),
                          child: Column(children: [
                            SizedBox(height: 150),
                            SizedBox(
                                width: 300,
                                child: Text(
                                    "From your inputs, it looks as though you have had a good day! \n Here are some insights for you",
                                    style: GoogleFonts.merriweather(
                                        color: const Color(0xffC7BCB1),
                                        fontSize: 18),
                                    textAlign: TextAlign.center)),
                            SizedBox(height: 30),
                            activityLevel > 2
                                ? SizedBox(
                                    width: 300,
                                    child: Text(
                                        "Your activity level for the day is great. Exercise is one of the best things for improving your mental health. So keeping up your activity levels will really help! \n Well Done!",
                                        style: GoogleFonts.merriweather(
                                            color: const Color(0xffC7BCB1),
                                            fontSize: 15),
                                        textAlign: TextAlign.center))
                                : SizedBox(
                                    width: 300,
                                    child: Text(
                                        "I noticed that your activity level wasn't very high today. That is ok, everybody needs rest days. \n However, implementing exercise into your daily life can greatly improve your mental health and physical health also",
                                        style: GoogleFonts.merriweather(
                                            color: const Color(0xffC7BCB1),
                                            fontSize: 15),
                                        textAlign: TextAlign.center)),
                            SizedBox(height: 30),
                            socialLevel > 2
                                ? SizedBox(
                                    width: 300,
                                    child: Text(
                                        "Looks like you have done plenty socialising, this is fantastic. Socialising with friends and family is a great way to improve your mood, and hey, maybe some plans or new friends will come from it!",
                                        style: GoogleFonts.merriweather(
                                            color: const Color(0xffC7BCB1),
                                            fontSize: 15),
                                        textAlign: TextAlign.center))
                                : SizedBox(
                                    width: 300,
                                    child: Text(
                                        "It looks as though you weren't in a social mood today. That is ok, everybody needs to recharge their social battery. But socialising is a great way of lowering stress and improving mood. \nAnd always remember, they are your family and friends for a reason. Never be afraid to talk.",
                                        style: GoogleFonts.merriweather(
                                            color: const Color(0xffC7BCB1),
                                            fontSize: 15),
                                        textAlign: TextAlign.center)),
                          ]))
                      : total < 10 && total >= 5
                          ? Container()
                          : total < 5 && total > 2
                              ? Container()
                              : Container(
                                  child: Text("You have broken me"),
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
