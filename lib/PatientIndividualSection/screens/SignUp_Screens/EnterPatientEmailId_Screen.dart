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
import 'EnterPatientEmailPassword_Screen.dart';

class EnterPatientEmailIdScreen extends StatefulWidget {
  static const routeName = '/patient-enter-email-id-screen';

  @override
  State<EnterPatientEmailIdScreen> createState() =>
      _EnterPatientEmailIdScreenState();
}

class _EnterPatientEmailIdScreenState extends State<EnterPatientEmailIdScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  String _verificationId = "";
  bool _userVerified = false;
  bool _submitOtpClicked = false;
  bool _isOtpSent = false;
  bool isLangEnglish = true;

  TextEditingController _userEmailId = TextEditingController();
  TextEditingController _userOtpValue = TextEditingController();

  List<String> Country_code = [
    'assets/images/India.png',
    'assets/images/India2.png',
    // 'assets/images/Am.png',
  ];
  String selectedItem = 'assets/images/India2.png';
  String selected_ccode = "91";

  //Image selectedImage = Image.asset('assets/images/USA.png');

  int phoneno = -1;

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

    return Scaffold(
      backgroundColor: Color(0xFFfbfcff),
      body: Stack(
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: CirclePainter(),
          ),
          CustomPaint(
            size: Size(
              0.785 * width,
              0.485 * height,
            ),
            painter: RoundedRectangle(),
          ),
          Positioned(
            left: 0.216666 * width,
            top: 0.06 * height,
            child: SizedBox(
              width: 0.5666666 * width,
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
          ),
          Positioned(
            left: 0.16111111 * width,
            top: 0.15984 * height,
            child: SizedBox(
              width: 0.675 * width,
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
          ),
          Positioned(
            left: 0.175 * width,
            top: 0.325 * height,
            child: SizedBox(
              width: 0.7 * width,
              child: Text(
                isLangEnglish
                    ? "Enter your Email Id\n(@gmail.com)"
                    : "अपनी ईमेल आईडी दर्ज करें\n(@gmail.com)",
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
          ),
          // Positioned(
          //   left: 0.1916666 * width,
          //   top: 0.413043 * height,
          //   child: Container(
          //     width: 0.61388 * width,
          //     child: Text(
          //       "Use the phone number to\n register or login",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontFamily: 'Roboto',
          //         fontWeight: FontWeight.w400,
          //         fontSize: 15,
          //         fontStyle: FontStyle.normal,
          //         color: Color(0xff2c2c2c),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            left: 0.1275 * width,
            top: 0.475 * height,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.035,
              ),
              width: 0.75 * width,
              height: 0.065 * height,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffebebeb),
                ),
                borderRadius: BorderRadius.circular(5),
                color: Color(0xfff9fafb),
              ),
              child: TextFormField(
                autocorrect: true,
                autofocus: true,
                enabled: true,
                // maxLength: 10,
                controller: _userEmailId,
                // keyboardType: TextInputType.number,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText:
                      isLangEnglish ? 'Enter your Email-Id' : 'अपना आईडी डालें',
                  counterText: "",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(8, 255, 198, 1),
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                ),
                maxLength: 50,
              ),
            ),
          ),
          Positioned(
            left: 0.1725 * width,
            top: 0.57 * height,
            child: TextButton(
              onPressed: () async {
                if (!_userEmailId.text.contains("@gmail.com")) {
                  String titleText =
                      isLangEnglish ? "Invalid Email Id" : "अमान्य ईमेल आईडी";
                  String contextText = isLangEnglish
                      ? "Email Id does not contains '@gmail.com'"
                      : "ईमेल आईडी में '@gmail.com' नहीं है";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                } else if (_userEmailId.text.trim().length < 15) {
                  String titleText =
                      isLangEnglish ? "Invalid Email Id" : "अमान्य ईमेल आईडी";
                  String contextText = isLangEnglish
                      ? "The length of the email id is very short!"
                      : "ईमेल आईडी की लंबाई बहुत कम है!";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                } 
                else if (_userEmailId.text.trim().length > 50) {
                  String titleText =
                      isLangEnglish ? "Invalid Email Id" : "अमान्य ईमेल आईडी";
                  String contextText = isLangEnglish
                      ? "The length of the email id is very large!"
                      : "ईमेल आईडी की लंबाई बहुत ज्यादा है!";
                  _checkForError(
                    context,
                    titleText,
                    contextText,
                  );
                } 
                else {
                  Provider.of<PatientEmailAuthDetails>(context, listen: false).checkExecution = true;
                  Provider.of<PatientUserDetails>(context, listen: false).setPatientEmailId(_userEmailId);
                  Navigator.of(context).pushNamed(EnterPatientEmailPasswordScreen.routeName);
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
                  0.15 * width,
                  0.014066 * height,
                  0.15 * width,
                  0.014066 * height,
                ),
                // minimumSize: Size(221, 55),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.center,
              ),
              child: Text(
                isLangEnglish
                    ? "Enter password 👉🏻"
                    : "पास वर्ड  दर्ज  करें 👉🏻",
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
