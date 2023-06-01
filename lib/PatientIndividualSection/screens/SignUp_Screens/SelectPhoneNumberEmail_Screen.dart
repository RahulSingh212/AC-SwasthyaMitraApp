// ignore_for_file: prefer_const_constructors, unused_import, unused_element, unused_local_variable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/PatientIndividualSection/screens/SignUp_Screens/EnterPatientEmailId_Screen.dart';

import '../../Helper/circle_painter.dart';
import '../../Helper/rounded_rectangle.dart';

import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';

import './SelectLanguage_Screen.dart';
import './SelectSignInSignUp.dart';
import './EnterPersonalDetailsScreen.dart';
import './EnterPhoneNumber_Screen.dart';
import './EnterPhoneOtp_Screen.dart';

class EnterPhoneNumberEmailSectionScreen extends StatefulWidget {
  static const routeName = '/patient-enter-phone-number-email-section-screen';

  @override
  State<EnterPhoneNumberEmailSectionScreen> createState() => _EnterPhoneNumberEmailSectionScreenState();
}

class _EnterPhoneNumberEmailSectionScreenState extends State<EnterPhoneNumberEmailSectionScreen> {
  bool isLangEnglish = true;
  bool ispressed_MobileSection = false;
  bool ispressed_EmailSection = false;

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

    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
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
              width: _width,
              padding: EdgeInsets.only(top: 0.36828 * _height),
              child: Text(
                isLangEnglish
                    ? "Select your account type"
                    : "अपना खाता प्रकार चुनें",
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
                    ispressed_MobileSection = !ispressed_MobileSection;
                    ispressed_EmailSection = !ispressed_MobileSection;
                  });

                  // Provider.of<PatientUserDetails>(context, listen: false).patientEmailId.text = "Null...";
                  Navigator.of(context).pushNamed(EnterPatientPhoneNumberScreen.routeName);
                  // if (Provider.of<PatientAuthDetails>(context, listen: false).checkEntryType) {
                  //   Navigator.of(context).pushNamed(EnterPatientPhoneNumberScreen.routeName);
                  // }
                  // else {
                  //   Navigator.of(context).pushNamed(EnterPatientUserPersonalDetailsScreen.routeName);
                  // }
                },
                style: TextButton.styleFrom(
                    backgroundColor:
                        ispressed_MobileSection ? Color(0xff42ccc3) : Color(0xFFfbfcff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(27.5),
                      ),
                    ),
                    side: BorderSide(color: Color(0xffebebeb), width: 1),
                    minimumSize: Size(0.6138888 * _width, 0.0703324 * _height),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: Text(
                  isLangEnglish ? "Mobile Number" : "मोबाइल नंबर से",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color:
                        ispressed_MobileSection ? Color(0xFFfbfcff) : Color(0xff2c2c2c),
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
                    ispressed_EmailSection = !ispressed_EmailSection;
                    ispressed_MobileSection = !ispressed_EmailSection;
                  });

                  // Provider.of<PatientUserDetails>(context, listen: false).patientMobileNumber.text = "Null...";
                  Navigator.of(context).pushNamed(EnterPatientEmailIdScreen.routeName);
                  // if (Provider.of<PatientAuthDetails>(context, listen: false).checkEntryType) {
                  //   Navigator.of(context).pushNamed(EnterPatientEmailIdScreen.routeName);
                  // }
                  // else {
                  //   Navigator.of(context).pushNamed(EnterPatientUserPersonalDetailsScreen.routeName);
                  // }
                },
                style: TextButton.styleFrom(
                    backgroundColor:
                        ispressed_EmailSection ? Color(0xff42ccc3) : Color(0xFFfbfcff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(27.5),
                      ),
                    ),
                    side: BorderSide(color: Color(0xffebebeb), width: 1),
                    minimumSize: Size(0.6138888 * _width, 0.0703324 * _height,),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: Text(
                  isLangEnglish ? "Email Id" : "ईमेल से",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color:
                        ispressed_EmailSection ? Color(0xFFfbfcff) : Color(0xff2c2c2c),
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
}