// ignore_for_file: prefer_const_constructors, unused_import, unused_element, unused_local_variable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helper/circle_painter.dart';
import '../../Helper/rounded_rectangle.dart';

import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';

import './SelectLanguage_Screen.dart';
import './SelectSignInSignUp.dart';
import './EnterPersonalDetailsScreen.dart';
import './EnterPhoneNumber_Screen.dart';
import './EnterPhoneOtp_Screen.dart';
import 'SelectPhoneNumberEmail_Screen.dart';

class EnterPatientUserPersonalDetailsScreen extends StatefulWidget {
  static const routeName = 'patient-personal-details-screen';

  @override
  State<EnterPatientUserPersonalDetailsScreen> createState() =>
      _EnterPatientUserPersonalDetailsScreenState();
}

class _EnterPatientUserPersonalDetailsScreenState
    extends State<EnterPatientUserPersonalDetailsScreen> {
  TextEditingController _userFullName = TextEditingController();
  String? name;
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    int code = 91;
    int number = 9876745645;
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: Color(0xFFfbfcff),
      body: Stack(
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: CirclePainter(),
          ),
          Container(
            width: width,
            padding: EdgeInsets.only(top: 0.088235 * height),
            child: Text(
              isLangEnglish ? "AURIGA CARE PATIENT" : "औराईगा केयर मरीज",
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
            size: Size(
              0.785 * width,
              0.485 * height,
            ),
            painter: RoundedRectangle(),
          ),
          Container(
            width: width,
            padding: EdgeInsets.only(
              left: 0.1916666 * width,
              top: 0.4 * height,
            ),
            child: Text(
              isLangEnglish ? "Sign Up" : "साइन अप",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Color(0xff2c2c2c),
              ),
            ),
          ),
          // Container(
          //   width: width,
          //   padding:
          //       EdgeInsets.only(left: 0.1916666 * width, top: 0.34782 * height),
          //   child: Text(
          //     "+$code ${widget.phoneno}",
          //     style: TextStyle(
          //       fontFamily: 'Poppins',
          //       fontWeight: FontWeight.w500,
          //       fontSize: 17.0132,
          //       fontStyle: FontStyle.normal,
          //       color: Color(0xff6c757d),
          //     ),
          //   ),
          // ),
          Container(
            width: width,
            padding: EdgeInsets.only(
              top: 0.45 * height,
              left: 0.1916666 * width,
            ),
            child: Text(
              isLangEnglish
                  ? "Please enter your full name"
                  : "कृपया आपका पूरा नाम प्रविष्ट कीजिए",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                fontStyle: FontStyle.normal,
                color: Color(0xff2c2c2c),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 0.5664961 * height,
            ),
            alignment: Alignment.topCenter,
            child: TextButton(
              onPressed: () {
                if (_userFullName.text.isEmpty ||
                    _userFullName.text.length < 3) {
                  _displayErrorMessageInCenter(
                      context,
                      isLangEnglish
                          ? "Please enter your\n Full Name..."
                          : "कृपया अपना\n पूरा नाम दर्ज करें...");
                } else {
                  Provider.of<PatientUserDetails>(context, listen: false)
                      .setPatientFullName(_userFullName);
                  // Navigator.of(context).pushNamed(EnterPatientPhoneNumberScreen.routeName);
                  Navigator.of(context).pushNamed(EnterPhoneNumberEmailSectionScreen.routeName);
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff42ccc3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(27.5),
                  ),
                ),
                side: BorderSide(color: Color(0xffebebeb), width: 1),
                padding: EdgeInsets.fromLTRB(
                  0.208333 * width,
                  0.016624 * height,
                  0.205555 * width,
                  0.016624 * height,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.center,
              ),
              child: Text(
                isLangEnglish ? "CONTINUE" : "जारी रखें",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                ),
              ),
            ),
          ),
          Container(
            width: 0.80555555 * width,
            height: 0.53836317 * height,
            padding: EdgeInsets.only(
              left: 0.1916666 * width,
              top: 0.5 * height,
            ),
            child: TextFormField(
              textCapitalization: TextCapitalization.characters,
              onChanged: (val) {
                setState(() {
                  name = val;
                  _userFullName.text = val;
                });
              },
              decoration: InputDecoration(
                hintText: isLangEnglish ? "Full Name" : "पूरा नाम",
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff42ccc3),
                  ),
                ),
                hintStyle: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff42ccc3),
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
    );
  }

  Widget dropDownMenu(
    BuildContext context,
    List<String> dropDownList,
    TextEditingController _textCtr,
    String hintText,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Container(
      // alignment: Alignment.center,
      // width: screenWidth * 0.5,
      // height: screenHeight * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.0025,
      ),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.0025,
        horizontal: screenWidth * 0.001,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Align(
            alignment: Alignment.centerLeft,
            child: _textCtr.text.length == 0
                ? Text("${hintText}")
                : Text(
                    "${_textCtr.text}",
                    style: TextStyle(color: Colors.black),
                  ),
          ),
          isDense: true,
          isExpanded: true,
          iconSize: 30,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          onTap: () {},
          items: dropDownList.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() {
            _textCtr.text = value!;
          }),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      );

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
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
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

  Future<void> _displayErrorMessageInCenter(
    BuildContext context,
    String errorMessage,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xff42CCC3),
              ),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
