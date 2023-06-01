// ignore_for_file: unused_field, prefer_const_constructors, use_build_context_synchronously, unused_import, unused_local_variable, unnecessary_import, unused_element

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/PatientIndividualSection/providers/patientEmailAuth_details.dart';
import 'package:swasthyamitra/screens/Tab_Screen.dart';

import '../../../screens/SignUp_Screens/SelectLanguage_Screen.dart';
import '../../Helper/circle_painter.dart';
import '../../Helper/rounded_rectangle.dart';

import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';

import '../Tabs_Screen.dart';
import './SelectLanguage_Screen.dart';
import './SelectSignInSignUp.dart';
import './EnterPersonalDetailsScreen.dart';
import './EnterPhoneNumber_Screen.dart';
import './EnterPhoneOtp_Screen.dart';

class EnterPatientEmailPasswordScreen extends StatefulWidget {
  static const routeName = '/patient-enter-email-id-password-screen';

  @override
  State<EnterPatientEmailPasswordScreen> createState() =>
      _EnterPatientEmailPasswordScreenState();
}

class _EnterPatientEmailPasswordScreenState
    extends State<EnterPatientEmailPasswordScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  String _verificationId = "";
  bool _userVerified = false;
  bool _submitOtpClicked = false;
  bool _isOtpSent = false;
  bool isLangEnglish = true;
  bool isSubmitButtonPressed = false;
  bool isPasswordVissible = false;

  TextEditingController _userEnteredPassword = TextEditingController();

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    return Scaffold(
      backgroundColor: Color(0xFFfbfcff),
      body: Stack(
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
            width: _width,
            padding: EdgeInsets.only(top: 0.159846 * _height),
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
              0.785 * _width,
              0.485 * _height,
            ),
            painter: RoundedRectangle(),
          ),
          Positioned(
            width: _width,
            top: 0.3 * _height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    isLangEnglish ? "Enter password" : "पासवर्ड दर्ज करें",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff2c2c2c),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0.1275 * _width,
            top: 0.375 * _height,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                    width: 0.75 * _width,
                    child: Text(
                      "Email:\n${Provider.of<PatientUserDetails>(context, listen: false).patientEmailId.text}",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.1275 * _width,
            top: 0.5125 * _height,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _width * 0.035,
              ),
              width: 0.75 * _width,
              height: 0.065 * _height,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffebebeb),
                ),
                borderRadius: BorderRadius.circular(5),
                color: Color(0xfff9fafb),
              ),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _userEnteredPassword,
                obscureText: !isPasswordVissible,
                autocorrect: true,
                autofocus: true,
                enabled: true,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: isLangEnglish
                      ? 'Enter your Password'
                      : 'अपना पासवर्ड डालें',
                  counterText: "",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(8, 255, 198, 1),
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVissible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xff42ccc3),
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVissible = !isPasswordVissible;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.17 * _width,
            top: 0.625 * _height,
            child: TextButton(
                    onPressed: () async {
                      if (_userEnteredPassword.text.trim().length < 6) {
                        String titleText =
                            isLangEnglish ? "Invalid password" : "अवैध पासवर्ड";
                        String contextText = isLangEnglish
                            ? "Length of the password is too short!"
                            : "पासवर्ड की लंबाई बहुत कम है!";
                        _checkForError(
                          context,
                          titleText,
                          contextText,
                        );
                      } else {
                        setState(() {
                          isSubmitButtonPressed = true;
                        });
                        if (Provider.of<PatientAuthDetails>(context,
                                listen: false)
                            .checkEntryType) {
                          Provider.of<PatientEmailAuthDetails>(context,
                                  listen: false)
                              .signIn(
                            context,
                            Provider.of<PatientUserDetails>(context,
                                    listen: false)
                                .getPatientEmailId()
                                .text,
                            _userEnteredPassword.text.trim(),
                          );
                        } else {
                          Provider.of<PatientEmailAuthDetails>(context,
                                  listen: false)
                              .signUp(
                            context,
                            Provider.of<PatientUserDetails>(context,
                                    listen: false)
                                .getPatientEmailId()
                                .text,
                            _userEnteredPassword.text.trim(),
                          );
                        }
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
                        0.14 * _width,
                        0.025 * _height,
                        0.14 * _width,
                        0.025 * _height,
                      ),
                      // minimumSize: Size(221, 55),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.center,
                    ),
                    child: isSubmitButtonPressed && Provider.of<PatientEmailAuthDetails>(context, listen: false).checkExecution
                  ? Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: _width * 0.35,
                      child: CircularProgressIndicator(),
                    ),
                  )
                  : Text(
                      isLangEnglish
                          ? "Submit password 👍"
                          : "पासवर्ड  सबमिट  करें 👍",
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
        ],
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
              if (popVal == false) {
                Navigator.pop(ctx);
              }
            },
            tooltip: "OK",
          ),
        ],
      ),
    );
  }
}
