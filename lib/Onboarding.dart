import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'models/Questions.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);
  @override
  State<Onboarding> createState() => onboardingPage();
}

class onboardingPage extends State<Onboarding> {
  //final List<ContentConfig> ContentList = [];
  final Color Purple = const Color(0xFFAC008F);
  final _PageController = PageController();
  bool isLastPage = false;

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
                child: const Center(child: Text('Page 1')),
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
                    borderRadius: BorderRadius.circular(0),
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.teal.shade700,
                  minimumSize: const Size.fromHeight(60),
                ),
                onPressed: () async {
                  // final prefs = await SharedPreferences.getInstance();
                  // prefs.setBool('showHome', true);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                child: Text(
                  'Lets Go!',
                  style: GoogleFonts.quicksand(fontSize: 24),
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () => _PageController.jumpToPage(2),
                          child: Text('Skip',
                              style: GoogleFonts.quicksand(fontSize: 18))),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _PageController,
                          count: 3,
                          effect: WormEffect(
                              spacing: 16,
                              dotColor: Colors.black38,
                              activeDotColor: Colors.teal.shade700),
                        ),
                      ),
                      TextButton(
                          onPressed: () => _PageController.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeOutCirc),
                          child: Text('Next',
                              style: GoogleFonts.quicksand(fontSize: 18))),
                    ]),
              ),
      );
}
