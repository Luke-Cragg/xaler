import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'Journal.dart';
import 'mindfulness.dart';
import 'Resources.dart';

int pageIndex = 0;
GlobalKey<CurvedNavigationBarState> bottomNavKey = GlobalKey();

class MyNav extends StatefulWidget {
  const MyNav({super.key});
  @override
  State<MyNav> createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  final Color BackGrey = Color(0xFF3A3A3A);
  bool resourceVisited = false;

  List<Widget> PageList = <Widget>[
    Home(),
    Mindfulness(),
    Journal(),
    Resources(),
  ];
  void updateHomePage(bool completed) {
    if (completed) {
      setState(() {
        pageIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageList[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavKey,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        color: BackGrey,
        backgroundColor: Color(0XFF1E90FF),
        buttonBackgroundColor: BackGrey,
        index: pageIndex,
        items: const [
          CurvedNavigationBarItem(
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
              labelStyle: TextStyle(color: Colors.white)),
          CurvedNavigationBarItem(
              child: Icon(
                Icons.sunny,
                color: Colors.white,
              ),
              label: 'Mindfulness',
              labelStyle: TextStyle(color: Colors.white)),
          CurvedNavigationBarItem(
              child: Icon(
                Icons.message_outlined,
                color: Colors.white,
              ),
              label: 'Journal',
              labelStyle: TextStyle(color: Colors.white)),
          CurvedNavigationBarItem(
              child: Icon(
                Icons.format_list_bulleted_outlined,
                color: Colors.white,
              ),
              label: 'Resources',
              labelStyle: TextStyle(color: Colors.white)),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   key: bottomNavKey,
      //   elevation: 0,
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: BackGrey,
      //   selectedItemColor: Color(0XFF1E90FF),
      //   unselectedItemColor: Color(0XFFFFFFFF),
      //   currentIndex: pageIndex,
      //   onTap: (index) {
      //     setState(() {
      //       pageIndex = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.sunny), label: 'Mindfulness'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.message_outlined), label: 'Journal'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.format_list_bulleted_outlined),
      //         label: 'Resources')
      //   ],
      // ),
    );
  }
}
