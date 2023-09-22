import 'package:flutter/material.dart';
import 'Home.dart';
import 'Vent.dart';
import 'Progress.dart';

class MyNav extends StatefulWidget {
  const MyNav({super.key});
  @override
  State<MyNav> createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  final Color BackGrey = const Color(0xFF222222);
  final Color DarkBlue = const Color(0xFF02275D);

  int pageIndex = 0;
  List<Widget> PageList = <Widget>[Home(), Progress(), Vent()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: DarkBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 87, 87, 87),
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined_outlined),
              label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined), label: 'Vent'),
        ],
      ),
    );
  }
}
