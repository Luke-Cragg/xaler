import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';
import 'package:intro_slider/intro_slider.dart';
import 'models/Questions.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);
  @override
  State<Onboarding> createState() => onboardingPage();
}

class onboardingPage extends State<Onboarding> {
  final List<ContentConfig> ContentList = [];
  final Color Purple = const Color(0xFFAC008F);
  final Question = questions[0];

  @override
  void initState() {
    super.initState();

    ContentList.add(
      const ContentConfig(
        title: "Hey, I'm Xaler",
        description:
            "Lets get to know each other! \n\nI have a few questions to ask you so I can get to know you better!",
        backgroundColor: Color(0xFFAC008F),
      ),
    );
    ContentList.add(
      const ContentConfig(
        
        description: "How are you feeling today",
        backgroundColor: Color(0xFFFF5F1F),
      ),
    );
  }

  @override
  Widget build(BuildContext) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: ContentList,
      onDonePress: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Home()),
      ),
      curveScroll: Curves.bounceIn,
      indicatorConfig: IndicatorConfig(
        sizeIndicator: 10,
        indicatorWidget: Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        activeIndicatorWidget: Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
        ),
        spaceBetweenIndicator: 5,
        typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
      ),
    );
  }
}

// class Onboarding extends StatefulWidget {
//   const Onboarding({super.key});
//   @override
//   State<Onboarding> createState() => OnboardingPage();
// }

// class OnboardingPage extends State<Onboarding> {
//   int currentPage = 0;
//   final PageController _pageController = PageController(initialPage: 0);

//   final List<Widget> _pages = [
//     Container(
//       color: Purple,
//       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Container(
//           child: Column(
//             children: [
//               //alignment: Alignment.topCenter,
//               Text(
//                 "Hey I'm Xaler, \nLets get to know each other!",
//                 style: GoogleFonts.quicksand(fontSize: 25, color: Colors.white),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 100),
//               Center(
//                 child: Container(
//                   child: Text(
//                     "I'm your personal 24/7 mental health tracker and buddy. \n",
//                     style: GoogleFonts.quicksand(
//                         fontSize: 21, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ]),
//     ),
//     Container(
//       color: Purple,
//       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Container(
//           child: Column(
//             children: [
//               //alignment: Alignment.topCenter,
//               Text(
//                 ,
//                 style: GoogleFonts.quicksand(fontSize: 25, color: Colors.white),
//               ),
//               SizedBox(height: 50),
//               Center(
//                 child: Container(
//                   padding: const EdgeInsets.all(0.0),
//                   child: Text(
//                     "I'm Xaler, your personal 24/7 mental health tracker and buddy. I have a few questions to ask you so I can get to know you better!",
//                     style: GoogleFonts.quicksand(
//                         fontSize: 21, color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ]),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: PageView(
//           controller: _pageController,
//           onPageChanged: (int page) {
//             setState(() {
//               currentPage = page;
//             });
//           },
//           children: _pages,
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         floatingActionButton: Stack(
//           fit: StackFit.expand,
//           children: [
//             Positioned(
//               left: 30,
//               bottom: 20,
//               child: FloatingActionButton(
//                 heroTag: "Previous",
//                 backgroundColor: currentPage > 0 ? Colors.blue : Colors.grey,
//                 onPressed: currentPage > 0
//                     ? () {
//                         setState(() {
//                           currentPage -= 1;
//                         });
//                         _pageController.previousPage(
//                             duration: const Duration(milliseconds: 500),
//                             curve: Curves.ease);
//                       }
//                     : null,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.arrow_left, size: 40),
//               ),
//             ),
//             Positioned(
//               right: 30,
//               bottom: 20,
//               child: FloatingActionButton(
//                 heroTag: "next",
//                 onPressed: currentPage < _pages.length - 1
//                     ? () {
//                         setState(() {
//                           currentPage += 1;
//                         });
//                         _pageController.nextPage(
//                             duration: const Duration(milliseconds: 500),
//                             curve: Curves.ease);
//                       }
//                     : () {
//                         Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(builder: (_) => const Home()));
//                       },
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.arrow_right, size: 40),
//               ),
//             )
//           ],
//         ));
//   }
// }
//}