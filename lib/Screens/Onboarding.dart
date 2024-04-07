import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);
  @override
  State<Onboarding> createState() => OnboardingPage();
}

class OnboardingPage extends State<Onboarding> {
  final Color XalerBlue = const Color(0xFF38434E);
  final _PageController = PageController();
  bool isLastPage = false;
  String gender = '';
  String age = '';
  String employment = '';
  String loneliness = '';
  String goal = '';
  bool Q1Answered = false;
  bool Q2Answered = false;
  bool Q3Answered = false;
  bool Q4Answered = false;
  bool Q5Answered = false;
  bool AllAnswered = false;

  void completeOnboarding() async {
    await EncryptedSharedPreferences.initialize('1111111111111111',
        algorithm: EncryptionAlgorithm.aes);
    var prefs = EncryptedSharedPreferences.getInstance();
    await prefs.setBoolean('onboardingCompleted', true);
  }

  String CurrentDate = DateFormat('dMy').format(DateTime.now());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String UserId = '';
  bool OnboardComplete = false;

//Gets the current signed in users firebase UID. This allows for data to be created
//and retrieved for just that user.
  void GetCurrentUserUID() {
    final User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      UserId = uid;
    }
  }

  void CreateOnboardingInfo() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    GetCurrentUserUID();

    final json = {
      'Gender': gender,
      'AgeRange': age,
      'Employment': employment,
      'Loneliness': loneliness,
      'Goal': goal
    };

    final CollectionReference collection =
        _firestore.collection('Onboarding').doc(UserId).collection(CurrentDate);
    final QuerySnapshot collectionData = await collection.get();
    if (collectionData.docs.isEmpty) {
      await collection.add(json);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _PageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 0),
          child: PageView(
            controller: _PageController,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 5);
            },
            children: [
              Container(
                color: const Color(0xff915c83),
                child: Center(
                    child: Column(children: [
                  const SizedBox(
                    height: 210,
                  ),
                  Text(
                    'What is your Gender?',
                    style: GoogleFonts.quicksand(
                        fontSize: 32, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    const SizedBox(
                      width: 100,
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
                                      gender = 'Male';
                                      Q1Answered = true;
                                    },
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(20),
                              backgroundColor: const Color(0xffC7BCB1),
                              minimumSize: const Size(100, 100)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Male",
                              style:
                                  GoogleFonts.merriweather(color: Colors.black),
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
                                      gender = 'Other';
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
                            "Other",
                            style:
                                GoogleFonts.merriweather(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Column(children: [
                      ElevatedButton(
                        onPressed: Q1Answered
                            ? null
                            : () {
                                setState(
                                  () {
                                    gender = 'Female';
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
                          "Female",
                          style: GoogleFonts.merriweather(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ])
                  ])
                ])),
              ),
              Container(
                color: const Color(0xffa4dded),
                child: Center(
                  child: Column(children: [
                    const SizedBox(
                      height: 210,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'What age range are you in?',
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
                                            age = '0-21';
                                            Q2Answered = true;
                                          },
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20),
                                    backgroundColor: const Color(0xfff6b19b),
                                    minimumSize: const Size(100, 100)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "0-21",
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
                                          age = '36-64';
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
                                  "36-64",
                                  style: GoogleFonts.merriweather(
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(children: [
                            ElevatedButton(
                              onPressed: Q2Answered
                                  ? null
                                  : () {
                                      setState(() {
                                        age = '22-35';
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
                                "22-35",
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
                                        age = '65+';
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
                                "65+",
                                style: GoogleFonts.merriweather(
                                    color: Colors.black),
                              ),
                            )
                          ])
                        ])
                  ]),
                ),
              ),
              Container(
                  color: XalerBlue,
                  child: Center(
                      child: Column(children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'What is your employment status?',
                        style: GoogleFonts.quicksand(
                            fontSize: 32, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 60,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: Q3Answered
                                    ? null
                                    : () {
                                        setState(() {
                                          employment = 'Full-time Education';
                                          Q3Answered = true;
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20),
                                    backgroundColor: const Color(0xffC7BCB1),
                                    minimumSize: const Size(120, 120)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Full-time \nEducation",
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
                                          employment = 'Unemployed';
                                          Q3Answered = true;
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: const Color(0xffC7BCB1),
                                  minimumSize: const Size(120, 120),
                                ),
                                child: Text(
                                  "Unemployed",
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
                                          employment = 'Employed';
                                          Q3Answered = true;
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: const Color(0xffC7BCB1),
                                  minimumSize: const Size(120, 120),
                                ),
                                child: Text(
                                  "Employed",
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
                                          employment = 'Retired';
                                          Q3Answered = true;
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: const Color(0xffC7BCB1),
                                  minimumSize: const Size(120, 120),
                                ),
                                child: Text(
                                  "Retired",
                                  style: GoogleFonts.merriweather(
                                      color: Colors.black),
                                ))
                          ])
                        ]),
                  ]))),
              Container(
                color: const Color(0xffa4dded),
                child: Center(
                    child: Column(children: [
                  const SizedBox(
                    height: 210,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      'Would you class yourself as lonely?',
                      style: GoogleFonts.quicksand(
                          fontSize: 32, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    const SizedBox(
                      width: 80,
                    ),
                    ElevatedButton(
                      onPressed: Q4Answered
                          ? null
                          : () {
                              setState(
                                () {
                                  age = 'Yes';
                                  Q4Answered = true;
                                },
                              );
                            },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: const Color(0xfff6b19b),
                          minimumSize: const Size(100, 100)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Yes",
                          style: GoogleFonts.merriweather(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: Q4Answered
                          ? null
                          : () {
                              setState(() {
                                loneliness = 'No';
                                Q4Answered = true;
                              });
                            },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: const Color(0xfff6b19b),
                        minimumSize: const Size(100, 100),
                      ),
                      child: Text(
                        "No",
                        style: GoogleFonts.merriweather(color: Colors.black),
                      ),
                    ),
                  ])
                ])),
              ),
              Container(
                  color: XalerBlue,
                  child: Center(
                      child: Column(children: [
                    const SizedBox(
                      height: 210,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'What is your goal?',
                        style: GoogleFonts.quicksand(
                            fontSize: 32, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: Q5Answered
                                    ? null
                                    : () {
                                        setState(() {
                                          goal = 'Control';
                                          Q5Answered = true;
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20),
                                    backgroundColor: const Color(0xffC7BCB1),
                                    minimumSize: const Size(140, 140)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Take Control \nof my mental \nhealth",
                                    style: GoogleFonts.merriweather(
                                        color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: Q5Answered
                                    ? null
                                    : () {
                                        setState(() {
                                          goal = 'Waiting';
                                          Q5Answered = true;
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20),
                                    backgroundColor: const Color(0xffC7BCB1),
                                    minimumSize: const Size(140, 140),
                                    alignment: Alignment.centerRight),
                                child: Text(
                                  "Help whilst \nwaiting for \nappointment",
                                  style: GoogleFonts.merriweather(
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Column(children: [
                            ElevatedButton(
                                onPressed: Q5Answered
                                    ? null
                                    : () {
                                        setState(() {
                                          goal = 'Insights';
                                          Q5Answered = true;
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: const Color(0xffC7BCB1),
                                  minimumSize: const Size(140, 140),
                                ),
                                child: Text(
                                  "Gain personal \ninsights",
                                  style: GoogleFonts.merriweather(
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: Q5Answered
                                    ? null
                                    : () {
                                        setState(() {
                                          employment = 'Not sure';
                                          Q5Answered = true;
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: const Color(0xffC7BCB1),
                                  minimumSize: const Size(140, 140),
                                ),
                                child: Text(
                                  "Not sure",
                                  style: GoogleFonts.merriweather(
                                      color: Colors.black),
                                ))
                          ])
                        ]),
                  ]))),
              Q1Answered == true &&
                      Q2Answered == true &&
                      Q3Answered == true &&
                      Q4Answered == true &&
                      Q5Answered == true
                  ? Container(
                      decoration: BoxDecoration(color: XalerBlue),
                      child: Column(children: [
                        const SizedBox(height: 150),
                        SizedBox(
                          width: 300,
                          child: Text(
                              "Thank you for completing that questionnaire, This information allows for me to provide the best insights to you",
                              style: GoogleFonts.merriweather(
                                  color: const Color(0xffC7BCB1), fontSize: 18),
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                            width: 350,
                            child: Text(
                                "We operate with the greatest respect for our users, so you can rest easy that all data you enter into the app will stay completely confidential and will never be shared with anybody",
                                style: GoogleFonts.merriweather(
                                    color: const Color(0xffC7BCB1),
                                    fontSize: 18),
                                textAlign: TextAlign.center)),
                      ]),
                    )
                  : Container(
                      decoration: BoxDecoration(color: XalerBlue),
                      child: Column(
                        children: [
                          const SizedBox(height: 150),
                          SizedBox(
                            width: 300,
                            child: Text(
                                "You have missed a question, please answer all the questions to allow for the best insights",
                                style: GoogleFonts.merriweather(
                                    color: const Color(0xffC7BCB1),
                                    fontSize: 18),
                                textAlign: TextAlign.center),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
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
                  CreateOnboardingInfo();
                  completeOnboarding();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MyNav()));
                },
                child: Text(
                  'Lets Go!',
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
                          count: 5,
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
