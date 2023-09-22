import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';

final Color Purple = const Color(0xFFAC008F);

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => OnboardingPage();
}

class OnboardingPage extends State<Onboarding> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    Container(
      color: Purple,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Column(
            children: [
              //alignment: Alignment.topCenter,
              Text(
                "Hey, Lets get to know each other!",
                style: GoogleFonts.quicksand(fontSize: 25, color: Colors.white),
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    "I'm Xaler, your personal 24/7 mental health tracker and buddy. I have a few questions to ask you so I can get to know you better!",
                    style: GoogleFonts.quicksand(
                        fontSize: 21, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    ),
    Container(
      color: Purple,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Column(
            children: [
              //alignment: Alignment.topCenter,
              Text(
                "Hey, Lets get to know each other!",
                style: GoogleFonts.quicksand(fontSize: 25, color: Colors.white),
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    "I'm Xaler, your personal 24/7 mental health tracker and buddy. I have a few questions to ask you so I can get to know you better!",
                    style: GoogleFonts.quicksand(
                        fontSize: 21, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        children: _pages,
      ),
    );
  }
}
