import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  final Color backGround = const Color(0xFF38434E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.quicksand(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: backGround,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_outlined,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: backGround),
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Information:",
                style: GoogleFonts.quicksand(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "When you create an account with Xaler, we may collect the following personal information:",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              Text(
                "\t\u2022 Gender\n\t\u2022 Age Range\n\t\u2022 Employment Status\n\t\u2022 Email Address\n\t\u2022 Name\n\t\u2022 Password",
                style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(height: 30),
              Text(
                "Analytics:",
                style: GoogleFonts.quicksand(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Xaler utilizes Google Analytics to analyze trends and usage patterns within the App. This may include anonymous data such as country location and operating system versions.",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                "\t\u2022 Your email address may be used to communicate important updates, service announcements, and promotional offers related to Xaler.\n\n\t\u2022 Anonymous Geolocation and device operating system analytics data is used to improve the functionality and user experience of the App.",
                style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(height: 30),
              Text(
                "Data Security and Retention:",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "We take the security of your personal information seriously. All data collected by Xaler is securely encrypted both at rest and during transit.",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                "\t\u2022 Access to your personal information is restricted to authorized personnel only and is used solely for the purpose of providing you with our services.\n\n\t\u2022 Access to your data will only be authorised upon your request to view any data that we hold of your account in our systems\n\n\t\u2022 Upon deletion of your Xaler account, all associated user data, including personal information, will be permanently removed from our servers.",
                style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(height: 30),
              Text(
                "User Rights:",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "You have the right to request access to, correction of, or deletion of your personal information, aswell as request a copy of any of your data held by Xaler. You can do so by emailing lcragg1@uclan.ac.uk.",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 30),
              Text(
                "Changes to this policy:",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "We reserve the right to update or modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the revised policy on the App. Your continued use of Xaler after any changes indicates your acceptance of the updated Privacy Policy.",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 30),
              Text(
                "Contact Us:",
                style: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "If you have any questions, concerns, or feedback about this Privacy Policy or our privacy practices, please contact us at lcragg1@uclan.ac.uk",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
              Text(
                "\nThis Privacy Policy is for informational purposes only and should not be considered legal advice. It is advisable to seek legal counsel to ensure compliance with applicable privacy laws and regulations.",
                style: GoogleFonts.quicksand(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
