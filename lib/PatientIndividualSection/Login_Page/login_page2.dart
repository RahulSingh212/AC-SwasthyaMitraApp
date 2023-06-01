// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, unused_field, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_import, avoid_unnecessary_containers, unused_local_variable, import_of_legacy_library_into_null_safe, prefer_final_fields, use_key_in_widget_constructors, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Helper/circle_painter.dart';
import '../Helper/rounded_rectangle.dart';

class LoginPage2 extends StatefulWidget {
  int phoneno;
  LoginPage2({Key? key,required this.phoneno}) : super(key: key);

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  int code = 91;
  int number = 9876745645;
  int? _resendToken;
  final _auth=FirebaseAuth.instance;

  // for verification
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String _userTypedOTP='';
  late String _vericationcode;

  bool showLoading=false;
  bool _isAuthenticationAccepted=false;




  _verifyPhone() async {

    await _auth.verifyPhoneNumber(
        phoneNumber: '+91${widget.phoneno}',
        verificationCompleted: (PhoneAuthCredential credential) {
          setState(() {
            _isAuthenticationAccepted=true;
            showLoading=false;
          });


        },
        verificationFailed:  (FirebaseAuthException e) {

          setState(() {
            _isAuthenticationAccepted=false;
            showLoading = false;
          });


          String contextText = "Unable to generate the OTP.";

          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${contextText}'),
          ),
        );
        },
        codeSent:  (String verficationID, int? resendToken) {
          setState(() {
            showLoading=false;
            _vericationcode = verficationID;
             _resendToken=resendToken;
          });

        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _vericationcode = verificationID;
          });
        },

        timeout: Duration(seconds: 30)
        );

  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if(authCredential.user != null){
        // Navigator.pushAndRemoveUntil(context,
        //   MaterialPageRoute(
        //       builder: (context)=> LoginPage3(phoneno: widget.phoneno,)),
        //       (route)=> false,);
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${e.message}'),
          ),
        );
    }
  }
  onPressed() async {
    signInWithPhoneAuthCredential(PhoneAuthProvider.credential(
        verificationId: _vericationcode, smsCode: _userTypedOTP));


  }













  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();

  _otpfield(bool first, bool last, TextEditingController otp) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    return SizedBox(
      width: 0.092 * _width,
      height: 0.087 * _height,
      child: TextField(
        autofocus: true,
        showCursor: true,
        controller: otp,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontFamily: 'Popins',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          color: Color(0xff42ccc3),
        ),
        maxLength: 1,
        decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffebebeb)),
                borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff42ccc3)),
                borderRadius: BorderRadius.circular(5))),
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
    return showLoading?Center(child: CircularProgressIndicator(),)
        :Scaffold(
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
            child: const Text(
              "AURIGACARE",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 30,
                fontStyle: FontStyle.normal,
                color: Color(0xFFfbfcff),
                // height: ,
              ),
            ),
          ),
          Container(
            width: _width,
            padding: EdgeInsets.only(top: 0.159846 * _height),
            child: const Text(
              "24/7 Video consultations,\n  exclusively on app",
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
              size: Size(0.7805 * _width, 0.506982 * _height),
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
                  child: const Text(
                    "Enter OTP",
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
            )
          ),
          Positioned(
            left: 0.191666 * _width,
            top: 0.379795 * _height,
            child: Container(
              child: const Text(
                "We have sent you SMS with 6 digit\nverification code on",
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
                "+$code ${widget.phoneno}",
                style: const TextStyle(
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
                    onPressed: () {
                      setState(() {
                        _userTypedOTP=otp1.text +otp2.text +otp3.text +otp4.text+otp5.text+otp6.text;
                      });

                      onPressed();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff42ccc3),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(27.5))),
                        side: const BorderSide(
                            color: Color(0xffebebeb), width: 1),
                        padding: EdgeInsets.fromLTRB(
                            0.208333 * _width,
                            0.016624 * _height,
                            0.205555 * _width,
                            0.016624 * _height),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.center),
                    child: const Text(
                      "SUBMIT",
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
          ),
          Positioned(
              top: 0.695683 * _height,
              width: _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Not receiving OTP?',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF323657),
                    ),
                  )
                ],
              )),
          Positioned(
              top: 0.71079 * _height,
              width: _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      _verifyPhone();
                    },
                    style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.center),
                    child: const Text(
                      "Resend OTP",
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
              ))
        ],
      ),
    );
  }











}
