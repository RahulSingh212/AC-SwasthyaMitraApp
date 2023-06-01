// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, unused_field, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_import, avoid_unnecessary_containers, unused_local_variable, import_of_legacy_library_into_null_safe, prefer_final_fields, use_key_in_widget_constructors, must_be_immutable, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../../Helper/constants.dart';
import '../Helper/circle_painter.dart';
import '../Helper/rounded_rectangle.dart';
import '../Navigation_Page/mainPage.dart';

class LoginPage3 extends StatefulWidget {
  int phoneno;

  LoginPage3({Key? key, required this.phoneno}) : super(key: key);

  @override
  State<LoginPage3> createState() => _LoginPage3State();
}

class _LoginPage3State extends State<LoginPage3> {
  String? name;
  User user = FirebaseAuth.instance.currentUser!;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    int code = 91;
    int number = 9876745645;
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);
    return Scaffold(
      backgroundColor: const Color(0xFFfbfcff),
      body: Stack(
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: CirclePainter(),
          ),
          Container(
            width: width,
            padding: EdgeInsets.only(top: 0.088235 * height),
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
            width: width,
            padding: EdgeInsets.only(top: 0.159846 * height),
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
              size: Size(0.7805 * width, 0.476982 * height),
              painter: RoundedRectangle(),
            ),
          ),
          Container(
            width: width,
            padding:
                EdgeInsets.only(left: 0.1916666 * width, top: 0.30690 * height),
            child: const Text(
              "Sign Up",
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
            width: width,
            padding:
                EdgeInsets.only(left: 0.1916666 * width, top: 0.34782 * height),
            child: Text(
              "+$code ${widget.phoneno}",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 17.0132,
                fontStyle: FontStyle.normal,
                color: Color(0xff6c757d),
              ),
            ),
          ),
          Container(
            width: width,
            padding: EdgeInsets.only(
                top: 0.400255 * height, left: 0.1916666 * width),
            child: const Text(
              "Please enter your name so we\nget to know you better!",
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
            padding: EdgeInsets.only(top: 0.5664961 * height),
            alignment: Alignment.topCenter,
            child: TextButton(
              onPressed: () {
                if (name == null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: DefaultTextStyle(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: AppColors.AppmainColor),
                                child: Text(
                                  "Give Your Name",
                                )),
                          ),
                        );
                      });
                } else {
                  user.updateDisplayName(name!);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                              name: name!,
                            )),
                    (route) => false,
                  );
                }
              },
              style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff42ccc3),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(27.5))),
                  side: const BorderSide(color: Color(0xffebebeb), width: 1),
                  padding: EdgeInsets.fromLTRB(0.208333 * width,
                      0.016624 * height, 0.205555 * width, 0.016624 * height),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center),
              child: const Text(
                "CONTINUE",
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
                left: 0.1916666 * width, top: 0.496163 * height),
            child: TextFormField(
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
              decoration: InputDecoration(
                hintText: "Name",
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff42ccc3))),
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
        ],
      ),
    );
  }
}
