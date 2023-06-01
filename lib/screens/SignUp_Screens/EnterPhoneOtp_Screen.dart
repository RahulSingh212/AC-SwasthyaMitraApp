// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, avoid_print, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, unused_local_variable, avoid_unnecessary_containers

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helper/circle_painter.dart';
import '../../Helper/rounded_rectangle.dart';

import '../../providers/SM_Auth_Details.dart';
import '../../providers/SM_User_Details.dart';

import '../Tab_Screen.dart';
import './SelectLanguage_Screen.dart';
import './SelectSignInSignUp.dart';
import './EnterPersonalDetailsScreen.dart';
import './EnterPhoneNumber_Screen.dart';
import './EnterPhoneOtp_Screen.dart';

class EnterPhoneOtpScreen extends StatefulWidget {
  static const routeName = 'swasthya-mitra-enter-phone-number-otp-screen';

  TextEditingController enteredPhoneNumber = TextEditingController();

  // EnterPhoneOtpScreen(this.enteredPhoneNumber);

  @override
  State<EnterPhoneOtpScreen> createState() => _EnterPhoneOtpScreenState();
}

class _EnterPhoneOtpScreenState extends State<EnterPhoneOtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isOtpButtonPressed = false;

  String _verificationId = "";
  bool _userVerified = false;
  bool _submitOtpClicked = false;
  bool _isOtpSent = false;
  bool isLangEnglish = true;

  TextEditingController _userPhoneNumber = TextEditingController();
  TextEditingController _userOtpValue = TextEditingController();

  // for verification
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _userPhoneNumber =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .SwasthyaMitraMobileNumber;
    _checkForAuthentication(context, _userPhoneNumber);
    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  String _userTypedOTP = '';
  late String _vericationcode;

  bool showLoading = false;
  bool _isAuthenticationAccepted = false;

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();

  _otpfield(bool first, bool last, TextEditingController otp) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;

    return Container(
      width: 0.1 * _width,
      height: 0.1 * _height,
      child: TextField(
        autofocus: true,
        showCursor: true,
        controller: otp,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontFamily: 'Popins',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          color: Color(0xff42ccc3),
        ),
        maxLength: 1,
        decoration: InputDecoration(
          counter: Offstage(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffebebeb)),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff42ccc3),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && !last) FocusScope.of(context).nextFocus();
          if (value.isEmpty && !first) FocusScope.of(context).previousFocus();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    return showLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            key: _scaffoldKey,
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
                Container(
                  child: CustomPaint(
                    size: Size(
                      0.7805 * _width,
                      0.506982 * _height,
                    ),
                    painter: RoundedRectangle(),
                  ),
                ),
                Positioned(
                  width: _width,
                  top: 0.30690 * _height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          isLangEnglish ? "Enter OTP" : "ओटीपी दर्ज करें",
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
                  left: 0.175 * _width,
                  top: 0.375 * _height,
                  child: Container(
                    child: Text(
                      isLangEnglish
                          ? "We have sent you SMS with 6\ndigit verification code on"
                          : "हमने आपको 6 अंकों के साथ एसएमएस\nभेजा है सत्यापन कोड",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff2c2c2c),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.1916666 * _width,
                  top: 0.44373 * _height,
                  child: Container(
                    child: Text(
                      "+91 ${Provider.of<SwasthyaMitraUserDetails>(context, listen: false).SwasthyaMitraMobileNumber.text}",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.191666 * _width,
                  top: 0.496163 * _height,
                  child: SizedBox(
                    width: 0.61388 * _width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _otpfield(true, false, otp1),
                        _otpfield(false, false, otp2),
                        _otpfield(false, false, otp3),
                        _otpfield(false, false, otp4),
                        _otpfield(false, false, otp5),
                        _otpfield(false, true, otp6),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0.620243 * _height,
                  width: _width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: TextButton(
                          onPressed: () async {
                            setState(
                              () {
                                _userTypedOTP = otp1.text +
                                    otp2.text +
                                    otp3.text +
                                    otp4.text +
                                    otp5.text +
                                    otp6.text;

                                _userOtpValue.text = _userTypedOTP;
                              },
                            );

                            if (_userOtpValue.text.length != 6) {
                              String titleText =
                                  isLangEnglish ? "Invild OTP" : "अमान्य ओटीपी";
                              String contextText = isLangEnglish
                                  ? "Please Enter a Valid 6 Digit Code!"
                                  : "कृपया 6 अंकों का एक वैध कोड दर्ज करें!";
                              _checkForError(context, titleText, contextText);
                            } else if (int.tryParse(_userOtpValue.text) ==
                                null) {
                              String titleText =
                                  isLangEnglish ? "Invild OTP" : "अमान्य ओटीपी";
                              String contextText = isLangEnglish
                                  ? "Entered Code is Not Valid!"
                                  : "दर्ज किया गया कोड मान्य नहीं है!";
                              _checkForError(context, titleText, contextText);
                            } else if (int.parse(_userPhoneNumber.text) < 0) {
                              String titleText =
                                  isLangEnglish ? "Invild OTP" : "अमान्य ओटीपी";
                              String contextText = isLangEnglish
                                  ? "Otp Code cannot be Negative!"
                                  : "ओटीपी कोड नेगेटिव नहीं हो सकता!";
                              _checkForError(context, titleText, contextText);
                            } else {
                              setState(() {
                                _submitOtpClicked = true;
                                isOtpButtonPressed = true;
                              });
                              PhoneAuthCredential phoneAuthCredential =
                                  PhoneAuthProvider.credential(
                                verificationId: this._verificationId,
                                smsCode: _userOtpValue.text,
                              );
                              signInWithPhoneAuthCred(
                                context,
                                phoneAuthCredential,
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xff42ccc3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(27.5),
                              ),
                            ),
                            side: BorderSide(
                              color: Color(0xffebebeb),
                              width: 1,
                            ),
                            padding: EdgeInsets.fromLTRB(
                              0.208333 * _width,
                              0.016624 * _height,
                              0.205555 * _width,
                              0.016624 * _height,
                            ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center,
                          ),
                          child: !isOtpButtonPressed
                              ? Text(
                                  isLangEnglish ? "SUBMIT" : "प्रस्तुत",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFFfbfcff),
                                  ),
                                )
                              : CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0.695683 * _height,
                  width: _width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLangEnglish
                            ? 'Not receiving OTP?'
                            : "ओटीपी प्राप्त नहीं हो रहा है?",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF323657),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0.71079 * _height,
                  width: _width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          String text = isLangEnglish
                              ? "Resending Otp..."
                              : "ओटीपी फिर से भेजा...";
                          // _scaffoldKey.currentState
                          //     ?.showSnackBar(SnackBar(content: Text(text)));
                          _checkForAuthentication(context, _userPhoneNumber);
                        },
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.center,
                        ),
                        child: Text(
                          isLangEnglish
                              ? "Resending Otp..."
                              : "ओटीपी फिर से भेजा...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF42CCC3),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Future<void> _checkForAuthentication(
    BuildContext context,
    TextEditingController phoneController,
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",

      // After the Authentication has been Completed Successfully
      verificationCompleted: (phoneAuthCredential) async {
        setState(() {
          isOtpButtonPressed = false;
        });
      },

      // After the Authentication has been Failed/Declined
      verificationFailed: (verificationFailed) async {
        setState(() {
          isOtpButtonPressed = false;
        });
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
        _checkForError(context, titleText, contextText);
      },

      // After the OTP has been sent to Mobile Number Successfully
      codeSent: (verificationId, resendingToken) async {
        print('otp sent');

        setState(() {
          _isOtpSent = true;
          isOtpButtonPressed = false;

          this._verificationId = verificationId;
        });
      },

      // After the Otp Timeout period
      codeAutoRetrievalTimeout: (verificationID) async {
        // setState(() {
        //   isOtpButtonPressed = false;
        // });
        // // setState(() {
        // _isOtpSent = false;
        // //   _isAuthenticationAccepted = false;
        // //   _showLoading = false;
        // //   _isSubmitClicked = false;
        // //   _submitOtpClicked = false;
        // // });

        // if (!_userVerified) {
        //   setState(() {
        //     isOtpButtonPressed = false;
        //   });
        //   String titleText = isLangEnglish
        //       ? "Authenticatoin Timeout!"
        //       : "Authenticatoin Timeout!";
        //   String contextText =
        //       isLangEnglish ? "Please Re-Try Again" : "कृपया पुन: प्रयास करें";
        //   // _checkForError(context, titleText, contextText);
        //   _scaffoldKey.currentState?.showSnackBar(
        //     SnackBar(
        //       content: Text(
        //         isLangEnglish
        //             ? "Otp Timeout. Please Re-Try Again!"
        //             : "ओटीपी टाइमआउट। कृपया पुन: प्रयास करें!",
        //       ),
        //     ),
        //   );
        // }
      },
    );
  }

  void signInWithPhoneAuthCred(
    BuildContext context,
    PhoneAuthCredential phoneAuthCredential,
  ) async {
    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        print('authentication completed!');

        if (Provider.of<SwasthyaMitraAuthDetails>(context, listen: false).checkEntryType == true) {
          // Sign - In
          print("Singing In");
          setState(() {
            _userVerified = true;
            _submitOtpClicked = false;
            // isOtpButtonPressed = false;
          });
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
              .setSwasthyaMitraUserInfo(context);
          // Navigator.of(context).pushNamedAndRemoveUntil(TabsScreenSwasthyaMitra.routeName, (route) => false);
        } else {
          // // Sign - Up
          print("Signing Up");
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
        setState(() {
          isOtpButtonPressed = false;
        });

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
