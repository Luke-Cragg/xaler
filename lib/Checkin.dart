import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'Navigation.dart';

class Checkin extends StatefulWidget {
  const Checkin({Key? key}) : super(key: key);
  @override
  State<Checkin> createState() => CheckinPage();
}

class CheckinPage extends State<Checkin> {
  //final List<ContentConfig> ContentList = [];
  final Color XalerBlue = const Color(0xFF38434E);
  final _PageController = PageController();
  bool isLastPage = false;
  int mood = 0;
  int activityLevel = 0;

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
                                onPressed: () {
                                  setState(
                                    () {
                                      mood = 4;
                                    },
                                  );
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20),
                                    backgroundColor: const Color(0xffC7BCB1),
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
                                onPressed: () {
                                  setState(() {
                                    mood = 2;
                                  });
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
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
                                onPressed: () {
                                  setState(() {
                                    mood = 3;
                                  });
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
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
                                onPressed: () {
                                  setState(() {
                                    mood = 1;
                                  });
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
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
                        padding: EdgeInsets.only(left: 30),
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
                                onPressed: () {
                                  setState(
                                    () {
                                      activityLevel = 4;
                                    },
                                  );
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20),
                                    backgroundColor: const Color(0xfff6b19b),
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
                                onPressed: () {
                                  setState(() {
                                    activityLevel = 2;
                                  });
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
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
                                onPressed: () {
                                  setState(() {
                                    activityLevel = 3;
                                  });
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
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
                                onPressed: () {
                                  setState(() {
                                    activityLevel = 1;
                                  });
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
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
                    ],
                  ),
                ),
              ),
              Container(
                color: XalerBlue,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 210,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30),
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
                                onPressed: () {
                                  setState(
                                    () {
                                      activityLevel = 4;
                                    },
                                  );
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20),
                                    backgroundColor: const Color(0xffC7BCB1),
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
                                onPressed: () {
                                  setState(() {
                                    activityLevel = 2;
                                  });
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
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
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    activityLevel = 3;
                                  });
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
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
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    activityLevel = 1;
                                  });
                                  _PageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 800),
                                      curve: Curves.easeOutCirc);
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
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(),
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
                  // final prefs = await SharedPreferences.getInstance();
                  // prefs.setBool('showHome', true);

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
                          onPressed: () => _PageController.jumpToPage(2),
                          child: Text('Skip',
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
