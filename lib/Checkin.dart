import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'models/Questions.dart';
import 'Navigation.dart';

class Checkin extends StatefulWidget {
  const Checkin({Key? key}) : super(key: key);
  @override
  State<Checkin> createState() => CheckinPage();
}

class CheckinPage extends State<Checkin> {
  //final List<ContentConfig> ContentList = [];
  final Color Purple = const Color(0xFFAC008F);
  final _PageController = PageController();
  bool isLastPage = false;
  int mood = 0;

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
              setState(() => isLastPage = index == 2);
            },
            children: [
              Container(
                color: Colors.indigo,
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
                          SizedBox(
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
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(20),
                                    backgroundColor: Color(0xffC7BCB1),
                                    minimumSize: Size(100, 100)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Very Good",
                                    style: GoogleFonts.merriweather(
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
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
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  backgroundColor: Color(0xffC7BCB1),
                                  minimumSize: Size(100, 100),
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
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  backgroundColor: Color(0xffC7BCB1),
                                  minimumSize: Size(100, 100),
                                ),
                                child: Text(
                                  "Pretty good",
                                  style: GoogleFonts.merriweather(
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
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
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  backgroundColor: Color(0xffC7BCB1),
                                  minimumSize: Size(100, 100),
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
                color: Colors.orange,
                child: const Center(child: Text('Page 2')),
              ),
              Container(
                color: Purple,
                child: const Center(child: Text('Page 3')),
              ),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  primary: Colors.blue,
                  backgroundColor: Color(0xFF3A3A3A),
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
                decoration: BoxDecoration(
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
                          effect: WormEffect(
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
