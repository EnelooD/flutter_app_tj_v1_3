import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens/favorite_ui.dart';
import 'package:flutter_app_tj_v1_3/screens/home_ui.dart';
import 'package:flutter_app_tj_v1_3/screens/inbox_ui.dart';
import 'package:flutter_app_tj_v1_3/screens/map_ui.dart';

class Screens2UI extends StatefulWidget {
  @override
  _Screens2UIState createState() => _Screens2UIState();
}

class _Screens2UIState extends State<Screens2UI> {
  int _page = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(45),
          topLeft: Radius.circular(45),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.brown[800],
          currentIndex: _page,
          onTap: (idx) {
            _pageController.jumpToPage(idx);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Container(
                height: 0.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              title: Container(
                height: 0.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.map,
                color: Colors.white,
              ),
              title: Container(
                height: 0.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.inbox,
                color: Colors.grey,
              ),
              activeIcon: Icon(
                Icons.inbox,
                color: Colors.white,
              ),
              title: Container(
                height: 0.0,
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (idx) {
          setState(() {
            _page = idx;
          });
        },
        children: <Widget>[
          HomeUI(),
          FavoriteUI(),
          MapUI(),
          InboxUI(),
        ],
      ),
    );
  }
}
