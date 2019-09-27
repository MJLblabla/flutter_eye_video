import 'package:flutter/material.dart';

import 'discovery/DiscoveryPage.dart';
import 'home/TopSelect.dart';
import 'hot/HotPage.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  var _currentIndex = 0;
  var _pageController = PageController();
  var tabImages;

//  var tabPages;
  final tabTitles = <String>['精选', '发现', '热门', '我的'];

  @override
  void initState() {
    super.initState();
    tabImages ??= [
      [
        getTabImage('images/ic_home_normal.png'),
        getTabImage('images/ic_home_selected.png')
      ],
      [
        getTabImage('images/ic_discovery_normal.png'),
        getTabImage('images/ic_discovery_selected.png')
      ],
      [
        getTabImage('images/ic_hot_normal.png'),
        getTabImage('images/ic_hot_selected.png')
      ],
      [
        getTabImage('images/ic_mine_normal.png'),
        getTabImage('images/ic_mine_selected.png')
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xffedeef0),
          Color(0xffe6e7e9),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            controller: _pageController,
            children: <Widget>[
              TopSelectPage(),
              DiscoveryPage(),
              HotPage(),
              Text("4"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _pageController.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
            BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
            BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
            BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3)),
          ]),
    );
  }

  Text getTabTitle(index) => Text(
        tabTitles[index],
        style: getTabTextStyle(index),
      );
  final tabTextStyleNormal = TextStyle(color: Colors.black38);
  final tabTextStyleSelected = TextStyle(color: Colors.black);

  TextStyle getTabTextStyle(int index) {
    if (_currentIndex == index) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image getTabImage(imagePath) => Image.asset(imagePath, width: 22, height: 22);

  Image getTabIcon(int index) {
    if (_currentIndex == index) {
      return tabImages[index][1];
    }
    return tabImages[index][0];
  }
}
