import 'package:flutter/material.dart';
import 'Home.dart';
import 'Vent.dart';
import 'Progress.dart';
import 'Resources.dart';

class MyNav extends StatefulWidget {
  const MyNav({super.key});
  @override
  State<MyNav> createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  final Color BackGrey = Color(0xFF3A3A3A);
  int pageIndex = 0;
  List<Widget> PageList = <Widget>[
    Home(),
    Progress(),
    Vent(),
    Resources(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: BackGrey,
        selectedItemColor: Color(0XFF1E90FF),
        unselectedItemColor: Color(0XFFFFFFFF),
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined_outlined),
              label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined), label: 'Vent'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined),
              label: 'Resources')
        ],
      ),
    );
  }
}
