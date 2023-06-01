// ignore_for_file: prefer_const_constructors, unused_local_variable, unused_import, unused_element

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helper/circle_painter.dart';
import '../../Helper/rounded_rectangle.dart';
import '../../Lang_Page/lang_page.dart';

import './SelectLanguage_Screen.dart';
import './SelectSignInSignUp.dart';
import './EnterPersonalDetailsScreen.dart';
import './EnterPhoneNumber_Screen.dart';
import './EnterPhoneOtp_Screen.dart';

import '../../providers/SM_Auth_Details.dart';
import '../../providers/SM_User_Details.dart';

class SelectSignInSignUpScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-select-signup-signin-screen';

  @override
  State<SelectSignInSignUpScreenSwasthyaMitra> createState() =>
      _SelectSignInSignUpScreenSwasthyaMitraState();
}

class _SelectSignInSignUpScreenSwasthyaMitraState
    extends State<SelectSignInSignUpScreenSwasthyaMitra> {
  bool isLangEnglish = true;
  bool ispressed_eng = false;
  bool ispressed_hindi = false;

  @override
  void initState() {
    super.initState();

    Provider.of<SwasthyaMitraAuthDetails>(context, listen: false)
        .getExistingSwasthyaMitrasUserPhoneNumbers(context);
    // Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
    //     .clearStateOfLoggedInUser(context);
    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    double _aspect_ratio = _width / _height;
    return Scaffold(
      backgroundColor: Color(0xFFfbfcff),
      body: Container(
        child: Stack(
          children: [
            CustomPaint(
              size: Size(_width, _height),
              painter: CirclePainter(),
            ),
            Container(
              width: _width,
              padding: EdgeInsets.only(top: 0.088235 * _height),
              child: Text(
                // isLangEnglish ? "SWASTHYA MITRA" : "औराईगा केयर मरीज",
                isLangEnglish ? "SWASTHYA MITRA" : "स्वास्थ्य मित्र",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                  // height: ,
                ),
              ),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.159846 * height),
              child: Text(
                isLangEnglish
                    ? '24/7 Video Consultations,\nexclusively on app'
                    : "24/7 वीडियो परामर्श,\nविशेष रूप से ऐप पर",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                ),
              ),
            ),
            CustomPaint(
              size: Size(0.7805 * _width, 0.3554 * _height),
              painter: RoundedRectangle2(),
            ),
            Container(
              width: _width,
              padding: EdgeInsets.only(top: 0.36828 * _height),
              child: Text(
                isLangEnglish
                    ? "Select Entry Type"
                    : "प्रवेश प्रकार का चयन करें",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.45012 * _height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    ispressed_eng = !ispressed_eng;
                    ispressed_hindi = !ispressed_eng;
                  });

                  Provider.of<SwasthyaMitraAuthDetails>(context, listen: false)
                      .setEntryType(true);
                  Provider.of<SwasthyaMitraAuthDetails>(context, listen: false).checkEntryType = true;
                  Navigator.of(context)
                      .pushNamed(EnterPhoneNumberScreen.routeName);
                },
                style: TextButton.styleFrom(
                    backgroundColor:
                        ispressed_eng ? Color(0xff42ccc3) : Color(0xFFfbfcff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(27.5),
                      ),
                    ),
                    side: BorderSide(
                      color: Color(0xffebebeb),
                      width: 1,
                    ),
                    // padding: EdgeInsets.fromLTRB(0.208333 * _width,
                    //     0.016624 * _height, 0.205555 * _width, 0.016624 * _height),
                    minimumSize: Size(0.6138888 * _width, 0.0703324 * _height),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: Text(
                  isLangEnglish ? "Sign In" : "साइन इन",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color:
                        ispressed_eng ? Color(0xFFfbfcff) : Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.56393 * _height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    ispressed_hindi = !ispressed_hindi;
                    ispressed_eng = !ispressed_hindi;
                  });

                  Provider.of<SwasthyaMitraAuthDetails>(context, listen: false)
                      .setEntryType(false);
                  Provider.of<SwasthyaMitraAuthDetails>(context, listen: false).checkEntryType = false;
                  Navigator.of(context)
                      .pushNamed(EnterUserPersonalDetailsScreen.routeName);
                },
                style: TextButton.styleFrom(
                    backgroundColor:
                        ispressed_hindi ? Color(0xff42ccc3) : Color(0xFFfbfcff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(27.5),
                      ),
                    ),
                    side: BorderSide(color: Color(0xffebebeb), width: 1),
                    // padding: EdgeInsets.fromLTRB(0.208333 * _width,
                    //     0.016624 * _height, 0.205555 * _width, 0.016624 * _height),
                    minimumSize: Size(0.6138888 * _width, 0.0703324 * _height),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: Text(
                  isLangEnglish ? "Sign Up" : "साइन अप",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color:
                        ispressed_hindi ? Color(0xFFfbfcff) : Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.65 * height),
              alignment: Alignment.topCenter,
              child: Align(
                child: Container(
                  height: screenHeight * 0.175,
                  width: screenWidth * 0.35,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: screenWidth,
                    child: CircleAvatar(
                      radius: screenWidth * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.2,
                        ),
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              "assets/images/agLogo.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
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
