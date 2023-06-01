// ignore_for_file: unused_field, prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_import, unnecessary_import, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, avoid_print, unnecessary_this, unused_element, unused_local_variable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../Helper/circle_painter.dart';
import '../../Helper/rounded_rectangle.dart';

import './SelectLanguage_Screen.dart';
import './SelectSignInSignUp.dart';
import './EnterPersonalDetailsScreen.dart';
import './EnterPhoneNumber_Screen.dart';
import './EnterPhoneOtp_Screen.dart';

import '../../providers/SM_Auth_Details.dart';
import '../../providers/SM_User_Details.dart';

class EnterPhoneNumberScreen extends StatefulWidget {
  static const routeName = 'swasthya-mitra-enter-phone-number-screen';

  @override
  State<EnterPhoneNumberScreen> createState() => _EnterPhoneNumberScreenState();
}

class _EnterPhoneNumberScreenState extends State<EnterPhoneNumberScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _verificationId = "";
  bool _userVerified = false;
  bool _submitOtpClicked = false;
  bool _isOtpSent = false;
  bool isLangEnglish = true;

  TextEditingController _userPhoneNumber = TextEditingController();
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

    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
    
    print(Provider.of<SwasthyaMitraAuthDetails>(context, listen: false).checkEntryType);
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
            size: Size(0.7805 * width, 0.476982 * height),
            painter: RoundedRectangle(),
          ),
          Positioned(
            left: 0.216666 * width,
            top: 0.06 * height,
            child: SizedBox(
              width: 0.5666666 * width,
              child: Text(
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
            left: 0.25833 * width,
            top: 0.38 * height,
            child: SizedBox(
              width: 0.4861111 * width,
              child: Text(
                isLangEnglish
                    ? "Enter your Phone Number"
                    : "अपना दूरभाष क्रमांक दर्ज करें",
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
            left: 0.17 * width,
            top: 0.485 * height,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.035,
              ),
              width: 0.65 * width,
              height: 0.05 * height,
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
                controller: _userPhoneNumber,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText:
                      isLangEnglish ? 'Enter your Number' : 'अपना नंबर डालें',
                  counterText: "",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(8, 255, 198, 1),
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                ),
                maxLength: 10,
              ),
            ),
          ),
          Positioned(
            left: 0.155 * width,
            top: 0.5754475 * height,
            child: TextButton(
              onPressed: () async {
                // _userPhoneNumber.text = phoneno.toString();
                print(_userPhoneNumber);

                if (_userPhoneNumber.text.length != 10) {
                  String titleText = isLangEnglish
                      ? "Invild Mobile Number"
                      : "इनविल मोबाइल नंबर";
                  String contextText = isLangEnglish
                      ? "Please Enter a Valid 10 Digit Number!"
                      : "कृपया 10 अंकों की मान्य संख्या दर्ज करें!";
                  _checkForError(context, titleText, contextText);
                } else if (int.tryParse(_userPhoneNumber.text) == null) {
                  String titleText = isLangEnglish
                      ? "Invild Mobile Number"
                      : "इनविल मोबाइल नंबर";
                  String contextText = isLangEnglish
                      ? "Entered Number is Not Valid!"
                      : "दर्ज संख्या मान्य नहीं है!";
                  _checkForError(context, titleText, contextText);
                } else if (int.parse(_userPhoneNumber.text) < 0) {
                  String titleText = isLangEnglish
                      ? "Invild Mobile Number"
                      : "इनविल मोबाइल नंबर";
                  String contextText = isLangEnglish
                      ? "Mobile Number Cannot be Negative!"
                      : "मोबाइल नंबर नेगेटिव नहीं हो सकता!";
                  _checkForError(context, titleText, contextText);
                } else {
                  Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                      .setSwasthyaMitraMobileNumber(_userPhoneNumber);

                  if (Provider.of<SwasthyaMitraAuthDetails>(context,
                          listen: false)
                      .getEntryType()) {
                    // Sign - In
                    if ((await Provider.of<SwasthyaMitraAuthDetails>(context,
                                listen: false)
                            .checkIfEnteredNumberExists(
                                context, _userPhoneNumber)) ==
                        true) {
                      Navigator.of(context)
                          .pushNamed(EnterPhoneOtpScreen.routeName);
                    } else {
                      String titleText = isLangEnglish
                          ? "Un-Identified User!"
                          : "अज्ञात उपयोगकर्ता!";
                      String contextText = isLangEnglish
                          ? "Entered User does not Exists..."
                          : "दर्ज किया गया उपयोगकर्ता मौजूद नहीं है...";
                      _checkForError(context, titleText, contextText).then((value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          SelectLanguageScreenSwasthyaMitra.routeName,
                          (route) => false);
                      });

                      
                    }
                  } else {
                    // Sign - Up
                    if ((await Provider.of<SwasthyaMitraAuthDetails>(context,
                                listen: false)
                            .checkIfEnteredNumberExists(
                                context, _userPhoneNumber)) ==
                        false) {
                      Navigator.of(context)
                          .pushNamed(EnterPhoneOtpScreen.routeName);
                    } else {
                      String titleText = isLangEnglish
                          ? "Existing User!"
                          : "मौजूदा उपयोगकर्ता!";
                      String contextText = isLangEnglish
                          ? "Entered User already Exists..."
                          : "दर्ज किया गया उपयोगकर्ता पहले से मौजूद है...";
                      _checkForError(context, titleText, contextText).then((value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          SelectLanguageScreenSwasthyaMitra.routeName,
                          (route) => false);
                      });
                      
                    }
                  }

                  // if (Provider.of<DoctorAuthDetails>(context, listen: false)
                  //         .getEntryType() ==
                  //     true) {
                  //   // Sign - In
                  //   if ((await Provider.of<DoctorAuthDetails>(context,
                  //               listen: false)
                  //           .checkIfEnteredNumberExists(
                  //               context, _userPhoneNumber)) ==
                  //       true) {
                  //     _checkForAuthentication(context, _userPhoneNumber);
                  //   } else {
                  //     String titleText = "Un-Identified User!";
                  //     String contextText = "Entered User does not Exists...";
                  //     _checkForError(context, titleText, contextText);
                  //     Navigator.of(context).pushNamedAndRemoveUntil(
                  //         SelectSignInSignUpScreenDoctor.routeName,
                  //         (route) => false);
                  //   }
                  // } else {
                  //   // Sign - Up
                  //   if ((await Provider.of<DoctorAuthDetails>(context, listen: false).checkIfEnteredNumberExists(context, _userPhoneNumber)) == false) {
                  //     _checkForAuthentication(context, _userPhoneNumber);
                  //   } else {
                  //     String titleText = "Existing User!";
                  //     String contextText = "Entered User already Exists...";
                  //     _checkForError(context, titleText, contextText);
                  //     Navigator.of(context).pushNamedAndRemoveUntil(
                  //         SelectSignInSignUpScreenDoctor.routeName,
                  //         (route) => false);
                  //   }
                  // }

                  // _checkForAuthentication(context, _userPhoneNumber);
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
                  0.25277777 * width,
                  0.014066 * height,
                  0.25277777 * width,
                  0.014066 * height,
                ),
                // minimumSize: Size(221, 55),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.center,
              ),
              child: Text(
                isLangEnglish ? "Send Otp" : "OTP भेजें",
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

  Future<void> openOtpSubmittingWidget() async {
    String titleText = isLangEnglish ? "Authentication" : "प्रमाणीकरण";
    String contextText = isLangEnglish ? "Enter the Otp:" : "ओटीपी दर्ज करें:";
    _enterUserOtp(context, titleText, contextText);
  }

  Future<void> _checkForAuthentication(
    BuildContext context,
    TextEditingController phoneController,
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",

      // After the Authentication has been Completed Successfully
      verificationCompleted: (phoneAuthCredential) async {
        // setState(() {
        //   _isAuthenticationAccepted = true;
        //   _submitOtpClicked = false;
        //   print('auth successful');
        // });

        // // // signInWithPhoneAuthCred(context, phoneAuthCredential);
      },

      // After the Authentication has been Failed/Declined
      verificationFailed: (verificationFailed) async {
        // setState(() {
        _isOtpSent = false;
        //   _isAuthenticationAccepted = false;
        //   _showLoading = false;
        //   _isSubmitClicked = false;
        //   _submitOtpClicked = false;
        // });
        print('verification failed');
        print(verificationFailed);

        String titleText =
            isLangEnglish ? "Authenticatoin Failed!" : "प्रमाणीकरण विफल!";
        String contextText = isLangEnglish
            ? "Unable to generate the OTP."
            : "ओटीपी जनरेट करने में असमर्थ।";
        // _checkForError(context, titleText, contextText);

        // _scaffoldKey.currentState
        //     ?.showSnackBar(SnackBar(content: Text("${contextText}")));
      },

      // After the OTP has been sent to Mobile Number Successfully
      codeSent: (verificationId, resendingToken) async {
        print('otp sent');

        openOtpSubmittingWidget();

        setState(() {
          _isOtpSent = true;
          // _isAuthenticationAccepted = false;
          // _showLoading = false;
          // _isSubmitClicked = false;
          // _submitOtpClicked = false;

          this._verificationId = verificationId;
        });
      },

      // After the Otp Timeout period
      codeAutoRetrievalTimeout: (verificationID) async {
        // setState(() {
        _isOtpSent = false;
        //   _isAuthenticationAccepted = false;
        //   _showLoading = false;
        //   _isSubmitClicked = false;
        //   _submitOtpClicked = false;
        // });

        if (!_userVerified) {
          String titleText = isLangEnglish
              ? "Authenticatoin Timeout!"
              : "प्रमाणिकता समयबाह्य!";
          String contextText =
              isLangEnglish ? "Please Re-Try Again" : "कृपया पुन: प्रयास करें";
          _checkForError(context, titleText, contextText);
        }
      },
    );
  }

  Future<void> _enterUserOtp(
    BuildContext context,
    String titleText,
    String contextText,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          Container(
            height: screenHeight * 0.2,
            width: screenWidth * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            margin: EdgeInsets.all(screenWidth * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText:
                        isLangEnglish ? 'Enter the OTP: ' : "ओटीपी दर्ज करें: ",
                  ),
                  controller: _userOtpValue,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) {},
                ),
              ],
            ),
          ),
          // RaisedButton(
          //   elevation: 5,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(screenWidth * 0.5),
          //   ),
          //   color: Colors.blue.shade400,
          //   child: Text(isLangEnglish ? 'Submit Otp' : "ओटीपी सबमिट करें"),
          //   onPressed: () async {
          //     setState(() {
          //       _submitOtpClicked = true;
          //     });
          //     PhoneAuthCredential phoneAuthCredential =
          //         PhoneAuthProvider.credential(
          //       verificationId: this._verificationId,
          //       smsCode: _userOtpValue.text,
          //     );
          //     signInWithPhoneAuthCred(context, phoneAuthCredential);
          //   },
          // ),
        ],
      ),
    );
  }

  void signInWithPhoneAuthCred(
    BuildContext context,
    PhoneAuthCredential phoneAuthCredential,
  ) async {
    // setState(() {
    //   _showLoading = true;
    // });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      // setState(() {
      //   _showLoading = false;
      // });

      if (authCredential.user != null) {
        print('authentication completed!');
        // _scaffoldKey.currentState?.showSnackBar(
        //   SnackBar(
        //     content: Text(isLangEnglish
        //         ? "Creating your Account..."
        //         : "आपका खाता बनाया जा रहा है..."),
        //   ),
        // );
        setState(() {
          _userVerified = true;
          _submitOtpClicked = false;
        });

        if (Provider.of<SwasthyaMitraAuthDetails>(context, listen: false)
                .getEntryType() ==
            true) {
          // Sign - In
          // Navigator.of(context)
          //     .pushReplacementNamed(TabsScreenSwasthyaMitra.routeName);
          // Navigator.of(context).pop(false);
        } else {
          // Sign - Up
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
              .upLoadNewSwasthyaMitraPersonalInformation(
            context,
            authCredential,
          );
        }

        // // Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
        // Navigator.of(context).pushReplacementNamed(TabsScreenDoctor.routeName);
        // Navigator.of(context).pop(false);
      }
    } on FirebaseAuthException catch (errorVal) {
      print(errorVal);

      if (_isOtpSent) {
        // setState(() {
        //   _showLoading = false;
        // });

        String titleText = isLangEnglish
            ? "Authentication Failed!"
            : "प्रमाणीकरण विफल हो गया!";
        String contextText =
            isLangEnglish ? "Otp is InValid!" : "ओटीपी अमान्य है!";
        _checkForError(context, titleText, contextText);

        print(errorVal.message);
      }
    }
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
                    style: TextStyle(
                      color: Colors.black,
                    ),
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
