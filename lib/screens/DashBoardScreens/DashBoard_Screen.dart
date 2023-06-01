// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, unused_import, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/screens/PatientPrescriptionScreens/PatientPrescriptionScreen.dart';

import '../../models/appointment_info.dart';
import '../../providers/SM_DashBoard_Details.dart';
import '../../providers/SM_User_Details.dart';
import './AppointmentSection.dart';
import './TestSection.dart';

class DashBoardScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-dash-board-screen';

  @override
  State<DashBoardScreenSwasthyaMitra> createState() =>
      _DashBoardScreenSwasthyaMitraState();
}

class _DashBoardScreenSwasthyaMitraState
    extends State<DashBoardScreenSwasthyaMitra> {
  bool isLangEnglish = true;
  bool isAppointmentBtnClicked = true;
  bool isTestBtnClicked = false;
  int New_request = 02;
  int Happy_feekbacks = 1730;
  int? Response_rate = 2;

  // List<Book_Tests> test_list = [
  //   Book_Tests("Khushi Sharma 1", DateTime.now(), "assets/images/DoctorBac.png",
  //       "Blood_test", true),
  //   Book_Tests("Khushi Sharma 2", DateTime.now(), "assets/images/DoctorBac.png",
  //       "Blood_test", true),
  //   Book_Tests("Khushi Sharma 3", DateTime.now(), "assets/images/DoctorBac.png",
  //       "Blood_test", true),
  //   Book_Tests("Khushi Sharma 4", DateTime.now(), "assets/images/DoctorBac.png",
  //       "Blood_test", true),
  //   Book_Tests("Khushi Sharma 5", DateTime.now(), "assets/images/DoctorBac.png",
  //       "Blood_test", true),
  //   Book_Tests("Khushi Sharma 6", DateTime.now(), "assets/images/DoctorBac.png",
  //       "Blood_test", true),
  //   Book_Tests("Khushi Sharma 7", DateTime.now(), "assets/images/DoctorBac.png",
  //       "Blood_test", true),
  // ];

  @override
  void initState() {
    super.initState();

    isLangEnglish = isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
        .fetchPatientAppointmentList(context);
    Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
        .fetchPatientBookedTests(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    var _padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height) -
        _padding.top -
        _padding.bottom -
        kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: Color(0xFFf2f3f4),
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        automaticallyImplyLeading: false,
        toolbarHeight: maxDimension * 0.1075,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                right: 0.45 * width,
                bottom: 0.02 * width,
              ),
              child: Text(
                isLangEnglish ? "Dashboard" : "डैशबोर्ड",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: minDimension * 0.065,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 0.01 * width,
                bottom: 0.02 * width,
              ),
              child: Text(
                isLangEnglish
                    ? "Accept and Reject all the tests requests here"
                    : "जांच अनुरोधों को स्वीकार और अस्वीकार करें",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.22 * (0.035 / 15) * width,
                ),
              ),
            ),
            // SizedBox(
            //   height: screenHeight * 0.2,
            // ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: minDimension * 0.035,
          ),
          // Align(
          //   child: Container(
          //     width: screenWidth * 0.95,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           width: screenWidth * 0.285,
          //           height: maxDimension * 0.15,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: Colors.white,
          //           ),
          //           padding: EdgeInsets.symmetric(
          //             vertical: 0.01 * height,
          //             horizontal: 0.01 * height,
          //           ),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Container(
          //                 alignment: Alignment.center,
          //                 child: Text(
          //                   New_request.toString(),
          //                   style: TextStyle(
          //                     fontSize: 35 * (0.035 / 15) * width,
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.red,
          //                   ),
          //                 ),
          //               ),
          //               Container(
          //                 alignment: Alignment.topLeft,
          //                 padding: EdgeInsets.symmetric(
          //                   horizontal: minDimension * 0.015,
          //                 ),
          //                 child: Text(
          //                   "New Requests",
          //                   textAlign: TextAlign.left,
          //                   style: TextStyle(
          //                     fontSize: 15 * (0.035 / 15) * width,
          //                     fontWeight: FontWeight.w500,
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           width: screenWidth * 0.285,
          //           height: maxDimension * 0.15,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: Colors.white,
          //           ),
          //           padding: EdgeInsets.symmetric(
          //             vertical: 0.01 * height,
          //             horizontal: 0.01 * height,
          //           ),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Container(
          //                 alignment: Alignment.center,
          //                 child: RichText(
          //                   text: TextSpan(
          //                     text: Response_rate.toString(),
          //                     style: TextStyle(
          //                         fontSize: 35 * (0.035 / 15) * width,
          //                         fontWeight: FontWeight.w600,
          //                         color: Colors.black),
          //                     children: <TextSpan>[
          //                       TextSpan(
          //                         text: ' hrs',
          //                         style: TextStyle(
          //                           fontSize: 20 * (0.035 / 15) * width,
          //                           fontWeight: FontWeight.w600,
          //                           color: Colors.black,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //               Container(
          //                 alignment: Alignment.topLeft,
          //                 padding: EdgeInsets.symmetric(
          //                   horizontal: minDimension * 0.015,
          //                 ),
          //                 child: Text(
          //                   "Response Rate",
          //                   textAlign: TextAlign.left,
          //                   style: TextStyle(
          //                     fontSize: 15 * (0.035 / 15) * width,
          //                     fontWeight: FontWeight.w500,
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           width: screenWidth * 0.285,
          //           height: maxDimension * 0.15,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: Colors.white,
          //           ),
          //           padding: EdgeInsets.symmetric(
          //             vertical: 0.01 * height,
          //             horizontal: 0.01 * height,
          //           ),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               // Container(
          //               //   alignment: Alignment.topRight,
          //               //   child: Image(
          //               //     image: check_incre_decre()
          //               //         ? AssetImage(
          //               //             'assets/images/redarrow.png',
          //               //           )
          //               //         : AssetImage(
          //               //             'assets/images/greenarrow.png',
          //               //           ),
          //               //     width: 0.025 * width,
          //               //     height: 0.03 * height,
          //               //   ),
          //               // ),
          //               Container(
          //                 alignment: Alignment.center,
          //                 child: Text(
          //                   Happy_feekbacks.toString(),
          //                   style: TextStyle(
          //                     fontSize: 35 * (0.035 / 15) * width,
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.red,
          //                   ),
          //                 ),
          //               ),
          //               Container(
          //                 alignment: Alignment.topLeft,
          //                 padding: EdgeInsets.symmetric(
          //                   horizontal: minDimension * 0.015,
          //                 ),
          //                 child: Text(
          //                   "Happy Feedbacks",
          //                   textAlign: TextAlign.left,
          //                   style: TextStyle(
          //                     fontSize: 15 * (0.035 / 15) * width,
          //                     fontWeight: FontWeight.w500,
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // Align(
          //   child: Container(
          //     width: screenWidth * 0.95,
          //     padding: EdgeInsets.symmetric(
          //       vertical: minDimension * 0.05,
          //     ),
          //     child: Text(
          //       "New Requests",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: width * 0.055,
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: minDimension * 0.025,
          // ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAppointmentBtnClicked = true;
                      isTestBtnClicked = false;
                    });
                  },
                  child: Container(
                    child: Text(
                      isLangEnglish ? "Appointments" : "नियुक्ति",
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: isAppointmentBtnClicked
                                ? Color.fromRGBO(66, 204, 195, 1)
                                : Color.fromRGBO(184, 184, 184, 1),
                            offset: Offset(0, -5),
                          )
                        ],
                        color: Colors.transparent,
                        decoration: isAppointmentBtnClicked
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: isAppointmentBtnClicked
                            ? Color.fromRGBO(66, 204, 195, 1)
                            : Color.fromRGBO(184, 184, 184, 1),
                        decorationThickness: 2.5,
                        decorationStyle: TextDecorationStyle.solid,
                        fontSize: screenWidth * 0.055,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTestBtnClicked = true;
                      isAppointmentBtnClicked = false;
                    });
                  },
                  child: Container(
                    child: Text(
                      isLangEnglish ? "Tests" : "जांच",
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: isTestBtnClicked
                                ? Color.fromRGBO(66, 204, 195, 1)
                                : Color.fromRGBO(184, 184, 184, 1),
                            offset: Offset(0, -5),
                          ),
                        ],
                        color: Colors.transparent,
                        decoration: isTestBtnClicked
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: isTestBtnClicked
                            ? Color.fromRGBO(66, 204, 195, 1)
                            : Color.fromRGBO(184, 184, 184, 1),
                        decorationThickness: 2.5,
                        decorationStyle: TextDecorationStyle.solid,
                        fontSize: screenWidth * 0.055,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            child: Center(
              child: Container(
                width: screenWidth * 0.95,
                child: Divider(
                  color: Colors.black,
                  thickness: 0.5,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.0005,
          ),
          isAppointmentBtnClicked
              ? Align(
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.775,
                    child: AppointmentSectionSwasthyaMitra(),
                  ),
                )
              : Align(
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.775,
                    child: TestSectionSwasthyaMitra(),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff42ccc3),
        onPressed: () {
          Navigator.pushNamed(
            context,
            PatientPrescriptionScreenSwasthyaMitra.routeName,
          );
        },
        label: Text(isLangEnglish ? "Prescriptions" : "पर्चे"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
