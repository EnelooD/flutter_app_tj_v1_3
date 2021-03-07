import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens/favorite_ui.dart';
import 'package:flutter_app_tj_v1_3/screens/home_ui.dart';
import 'package:flutter_app_tj_v1_3/screens/inbox_ui.dart';
import 'package:flutter_app_tj_v1_3/screens/map_ui.dart';


class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choice = const <Choice>[
  const Choice(title: 'Home', icon: Icons.home),
  const Choice(title: 'Favorite', icon: Icons.favorite),
  const Choice(title: 'Map', icon: Icons.map),
  const Choice(title: 'Inbox', icon: Icons.inbox),
];

class ScreensUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 2,
      length: choice.length,
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.brown,
        //   title: Text('Home'),
        //   centerTitle: true,
        //   // bottom: TabBar(
        //   //   unselectedLabelColor: Colors.white,
        //   //   indicatorWeight: 5,
        //   //   indicatorColor: Colors.orange,
        //   //   labelColor: Colors.black,
        //   //   isScrollable: true,
        //   //   onTap: (index) {
        //   //     print('index: ${index}');
        //   //   },
        //   //   tabs: choice.map((Choice choice) {
        //   //     return Tab(
        //   //       // text: choice.title,
        //   //       // icon: Icon(choice.icon),
        //   //       child: Row(
        //   //         children: [
        //   //           Icon(choice.icon),
        //   //           Container(
        //   //             margin: EdgeInsets.only(left: 8),
        //   //             child: Text(
        //   //               choice.title,
        //   //             ),
        //   //           ),
        //   //         ],
        //   //       ),
        //   //     );
        //   //   }).toList(),
        //   // ),
        // ),
        body: TabBarView(
          children: [
            HomeUI(),
            FavoriteUI(),
            MapUI(),
            InboxUI(),
          ],
        ),

        bottomNavigationBar: Container(
          color: Colors.brown,
          child: TabBar(
            unselectedLabelColor: Colors.white,
            indicatorWeight: 5,
            indicatorColor: Colors.orange,
            labelColor: Colors.black,
            isScrollable: true,
            onTap: (index) {
              print('index: ${index}');
            },
            tabs: choice.map((Choice choice) {
              return Tab(
                // text: choice.title,
                // icon: Icon(choice.icon),
                child: Row(
                  children: [
                    Icon(choice.icon),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        choice.title,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
