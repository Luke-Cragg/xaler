import 'package:flutter/material.dart';
import 'Home.dart';
import 'Journal.dart';
import 'mindfulness.dart';
import 'Resources.dart';

var bottomNavKey = GlobalKey<State<BottomNavigationBar>>();
int pageIndex = 0;

class MyNav extends StatefulWidget {
  const MyNav({super.key});
  @override
  State<MyNav> createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  final Color BackGrey = Color(0xFF3A3A3A);
  List<Widget> PageList = <Widget>[
    Home(),
    Mindfulness(),
    Journal(),
    Resources(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        key: bottomNavKey,
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
              icon: Icon(Icons.sunny), label: 'Mindfulness'),
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
