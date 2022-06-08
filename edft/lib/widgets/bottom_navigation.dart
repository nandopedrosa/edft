import 'package:edft/utils/colors.dart';
import 'package:edft/utils/functions.dart';
import 'package:edft/utils/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentPage;
  const MyBottomNavigationBar({Key? key, required this.currentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      backgroundColor: backgroundColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color:
                (currentPage == homePageIndex) ? primaryColor : secondaryColor,
          ),
          label: '',
          backgroundColor: backgroundColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: (currentPage == profilePageIndex)
                ? primaryColor
                : secondaryColor,
          ),
          label: '',
          backgroundColor: primaryColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color:
                (currentPage == aboutPageIndex) ? primaryColor : secondaryColor,
          ),
          label: '',
          backgroundColor: primaryColor,
        ),
      ],
      onTap: (int page) {
        Widget w = pickPage(page);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => w,
          ),
        );
      },
      currentIndex: currentPage,
    );
  }
}
