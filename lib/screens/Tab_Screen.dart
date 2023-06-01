// ignore_for_file: prefer_const_constructors, unused_import, duplicate_import, unused_local_variable, unused_element, deprecated_member_use, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, must_call_super, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
// import './StarterScreens/langpicker.dart';
// import './screens/Dashboard_Screens/DashBoard_Screen.dart';
// import './screens/Home_Screens/Home_Screen.dart';
// import './screens/Profile_Screens/Profile_Screen.dart';
// import './screens/Schedule_Screens/Schedule_Screen.dart';
// import './starter.dart';

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Helper/constants.dart';

import './HomeScreens/Home_Screen.dart';
import './DashBoardScreens/DashBoard_Screen.dart';
import './FindAddPatientScreens/FindAndAddPatient_Screen.dart';
import './AvailableTestsScreens/AvailableTests_Screen.dart';

import './ProfileScreens/MyProfile_Screen.dart';

class TabsScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-tabs-screen';

  @override
  State<TabsScreenSwasthyaMitra> createState() =>
      _TabsScreenSwasthyaMitraState();
}

class _TabsScreenSwasthyaMitraState extends State<TabsScreenSwasthyaMitra> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  // final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreenSwasthyaMitra(),
        'title': 'Home',
      },
      {
        'page': DashBoardScreenSwasthyaMitra(),
        'title': 'Dashboard',
      },
      {
        'page': FindAndAddPatientScreenSwasthyaMitra(),
        'title': 'Schedule',
      },
      {
        'page': AvailableTestsSwasthyaMitra(),
        'title': 'Available Tests',
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var maxDimension = max(screenHeight, screenWidth);
    var minDimension = min(screenHeight, screenWidth);

    final iconItemsInActive = <Widget>[
      const Icon(
        Icons.home_outlined,
        color: Color(0xff42ccc3),
        size: 30,
      ),
      const Icon(
        Icons.access_time_outlined,
        color: Color(0xff42ccc3),
        size: 30,
      ),
      const Icon(
        Icons.work_outline_outlined,
        color: Color(0xff42ccc3),
        size: 30,
      ),
      const Icon(
        Icons.assured_workload_rounded,
        color: Color(0xff42ccc3),
        size: 30,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff42ccc3),
        ),
        child: buildMyNavBar(context),
        // CurvedNavigationBar(
        //   onTap: _selectPage,
        //   backgroundColor: Colors.transparent,
        //   color: Theme.of(context).primaryColor,
        //   buttonBackgroundColor: Theme.of(context).primaryColor,
        //   index: 0,
        //   height: screenHeight * 0.070,
        //   animationCurve: Curves.easeInOut,
        //   animationDuration: const Duration(milliseconds: 300),
        //   items: iconItemsInActive,
        // ),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Container(
      height: screenHeight * 0.075,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22.5),
          topRight: Radius.circular(22.5),
          bottomRight: Radius.circular(22.5),
          bottomLeft: Radius.circular(22.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectPage(0);
              });
            },
            icon: _selectedPageIndex == 0
                ? const Icon(
                    Icons.home_rounded,
                    color: Color(0xff42ccc3),
                    size: 25,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectPage(1);
              });
            },
            icon: _selectedPageIndex == 1
                ? const Icon(
                    Icons.widgets_rounded,
                    color: Color(0xff42ccc3),
                    size: 25,
                  )
                : const Icon(
                    Icons.widgets_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectPage(2);
              });
            },
            icon: _selectedPageIndex == 2
                ? const Icon(
                    Icons.person_search_rounded,
                    color: Color(0xff42ccc3),
                    size: 25,
                  )
                : const Icon(
                    Icons.person_search_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectPage(3);
              });
            },
            icon: _selectedPageIndex == 3
                ? const Icon(
                    Icons.work_history_rounded,
                    color: Color(0xff42ccc3),
                    size: 25,
                  )
                : const Icon(
                    Icons.work_history_outlined,
                    color: Colors.grey,
                    size: 25,
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkForLogout(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.dangerous_rounded,
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_right_alt_rounded,
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
          // RaisedButton(
          //   child: Text('No'),
          //   onPressed: () {
          //     Navigator.of(ctx).pop(false);
          //   },
          // ),
          // RaisedButton(
          //   child: Text('Yes'),
          //   onPressed: () {
          //     // _auth.signOut();
          //     // Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          //   },
          // ),
        ],
      ),
    );
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_right_alt_rounded,
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
