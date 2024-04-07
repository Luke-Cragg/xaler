import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  final Color backGround = const Color(0xFF38434E);

  void launchMailClient(String targetEmail) async {
    String mailUrl = 'mailto:$targetEmail';
    try {
      await launchUrlString(mailUrl);
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: targetEmail));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 30),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left_outlined, size: 40),
        ),
        backgroundColor: backGround,
      ),
      body: Container(
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(color: backGround),
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daily Check in:\n",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "The daily check in is a great way to get advice on how you have been doing throughout the day, and what things you could do to improve\n",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              Text(
                "Just press the 'Tell me about it' button and see your feedback for the day!",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 50),
              Text(
                "Daily Challenges:",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Challenges are provided every day for you to complete. This is a good way to experience the apps features\n",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              Text(
                "We always advise to complete the daily challenges to find new features, whilst keeping it fun. We will always be adding new challenges for you to complete so make sure to keep an eye out! 👀",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 50),
              Text(
                "Mindfulness page:",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "This is a page full of our favourite mindfulness and meditation audios that we have found and used ourselves.",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              Text(
                "We have a list of audios created and curated by professionals at the FreeMindfulnessProject, aswell as other organisations.\nIf you are considering trying meditation, we definitely recommend atleast giving it a go.\nWho knows, it might be your next favourite thing!",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 50),
              Text(
                "Journal:",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "As the title suggests this is your area to keep your own personal diary.\n",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              Text(
                "We provide some prompts to help you if you aren't sure what to write or how to start.\n\nBut remember this is for you to look back on and see how far you have come.\nSo make it real and make it yours!",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 50),
              Text(
                "Resources:",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "This is a list of carefully curated resoruces that we feel can be very valuable to all users.\nAt the top are emergency resources which will provide you with contact details for 24/7 emergency services\n",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              Text(
                "We also provide other apps and resources that we believe can benefit all users who are looking to improve their mental well being.\n\nThis list is regularly updated, and only with products and resources that our team either believe are a good fit, or services we use ourselves.",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 50),
              Text(
                "Feedback:",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Do you have feedback or suggestions for the app that you'd like us to hear?\nPress the button below and personally let us know with the provided email!\n",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0XFF1E90FF))),
                  onPressed: () {
                    launchMailClient('example@example.com');
                  },
                  child: const Text(
                    "Send Feedback",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
