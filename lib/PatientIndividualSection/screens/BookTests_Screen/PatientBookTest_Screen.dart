// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, unused_import, duplicate_import, unused_local_variable, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../providers/SM_User_Details.dart';
import 'PatientScheduleTest_Screen.dart';

class BookTestScreenPatient extends StatefulWidget {
  static const routeName = '/patient-book-your-test-screen';

  @override
  State<BookTestScreenPatient> createState() => _BookTestScreenPatientState();
}

class _BookTestScreenPatientState extends State<BookTestScreenPatient> {
  bool isLangEnglish = true;
  String selectedTest = "";

  @override
  void initState() {
    super.initState();

    isLangEnglish = isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  Map<String, bool> selectedTestsMapping = {
    "Type1_Blood_Tests": false,
    "Type1_Complete_Blood_Count": false,
    "Type1_Liver_Function_Tests": false,
    "Type2_Kidney_Function_Tests": false,
    "Type2_Lipid_Profile": false,
    "Type2_Blood_Sugar_Test": false,
    "Type2_Urine_Test": false,
    "Type2_Cardiac_Blood_Text": false,
    "Type2_Thyroid_Function_Test": false,
    "Type3_Blood_Tests_For_Infertility": false,
    "Type3_Semen_Analysis_Test": false,
    "Type3_Blood_Tests_For_Arthritis": false,
    "Type3_Dengu_Serology": false,
    "Type3_Chikungunya_Test": false,
    "Type3_HIV_Test": false,
    "Type3_Pregnancy_Test": false,
    "Type3_Stool_Microscopy_Test": false,
    "Type3_ESR_Test": false,
  };

  Map<String, String> selectedTestsHeadingMapping = {
    "Type1_Blood_Tests": "Blood Tests",
    "Type1_Complete_Blood_Count": "Complete Blood Count",
    "Type1_Liver_Function_Tests": "Liver Function Tests",
    "Type2_Kidney_Function_Tests": "Kidney Function Tests",
    "Type2_Lipid_Profile": "Lipid Profile",
    "Type2_Blood_Sugar_Test": "Blood Sugar Test",
    "Type2_Urine_Test": "Urine Test",
    "Type2_Cardiac_Blood_Text": "Cardiac Blood Text",
    "Type2_Thyroid_Function_Test": "Thyroid Function Test",
    "Type3_Blood_Tests_For_Infertility": "Blood Tests For Infertility",
    "Type3_Semen_Analysis_Test": "Semen Analysis Test",
    "Type3_Blood_Tests_For_Arthritis": "Blood Tests For Arthritis",
    "Type3_Dengu_Serology": "Dengu Serology",
    "Type3_Chikungunya_Test": "Chikungunya Test",
    "Type3_HIV_Test": "HIV Test",
    "Type3_Pregnancy_Test": "Pregnancy Test",
    "Type3_Stool_Microscopy_Test": "Stool Microscopy Test",
    "Type3_ESR_Test": "ESR Test",
  };

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
        elevation: 5,
        leading: IconButton(
          enableFeedback: false,
          onPressed: () {
            // Navigator.of(context).pushReplacementNamed(MyProfileScreen.routeName);
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Color(0xff42ccc3),
            size: 35,
          ),
        ),
        title: Text(
          isLangEnglish ? "Book Test" : "जांच बुक करें",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: minDimension * 0.035,
          ),
          // SizedBox(
          //   height: minDimension * 0.0175,
          // ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type1_Blood_Tests'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type1_Blood_Tests',
                  isLangEnglish ? "Blood Tests" : "रक्त परीक्षण",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type1_Complete_Blood_Count'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type1_Complete_Blood_Count',
                  isLangEnglish ? "Complete Blood Count" : "पूर्ण रक्त गणना",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type1_Liver_Function_Tests'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type1_Liver_Function_Tests',
                  isLangEnglish
                      ? "Liver Function Tests(LFT)"
                      : "लिवर फंक्शन टेस्ट(एलएफटी)",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type2_Kidney_Function_Tests'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type2_Kidney_Function_Tests',
                  isLangEnglish
                      ? "Kidney Function Tests"
                      : "किडनी फंक्शन टेस्ट",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type2_Lipid_Profile'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type2_Lipid_Profile',
                  isLangEnglish ? "Lipid Profile" : "लिपिड प्रोफाइल",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type2_Blood_Sugar_Test'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type2_Blood_Sugar_Test',
                  isLangEnglish ? "Blood Sugar Test" : "ब्लड शुगर टेस्ट",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                      .swasthyaMitraAvailableTestsMapping['Type2_Urine_Test'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type2_Urine_Test',
                  isLangEnglish ? "Urine Test" : "मूत्र परीक्षण",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type2_Cardiac_Blood_Text'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type2_Cardiac_Blood_Text',
                  isLangEnglish ? "Cardiac Blood Text" : "हृदय रक्त पाठ",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type2_Thyroid_Function_Test'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type2_Thyroid_Function_Test',
                  isLangEnglish
                      ? "Thyroid Function Test"
                      : "थायराइड फंक्शन टेस्ट",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type3_Blood_Tests_For_Infertility'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type3_Blood_Tests_For_Infertility',
                  isLangEnglish
                      ? "Blood Tests For Infertility"
                      : "बांझपन के लिए रक्त परीक्षण",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type3_Semen_Analysis_Test'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type3_Semen_Analysis_Test',
                  isLangEnglish
                      ? "Semen Analysis Test"
                      : "वीर्य विश्लेषण परीक्षण",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type3_Blood_Tests_For_Arthritis'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type3_Blood_Tests_For_Arthritis',
                  isLangEnglish
                      ? "Blood Tests For Arthritis"
                      : "गठिया रक्त परीक्षण",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type3_Dengu_Serology'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type3_Dengu_Serology',
                  isLangEnglish ? "Dengu Serology" : "डेंगू सीरोलॉजी",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type3_Chikungunya_Test'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type3_Chikungunya_Test',
                  isLangEnglish ? "Chikungunya Test" : "चिकनगुनिया टेस्ट",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                      .swasthyaMitraAvailableTestsMapping['Type3_HIV_Test'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type3_HIV_Test',
                  isLangEnglish
                      ? "HIV-1 & HIV-2 Test"
                      : "एचआईवी-1 और एचआईवी-2 परीक्षण",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type3_Pregnancy_Test'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type3_Pregnancy_Test',
                  isLangEnglish ? "Pregnancy Test" : "गर्भावस्था परीक्षण",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                          .swasthyaMitraAvailableTestsMapping[
                      'Type3_Stool_Microscopy_Test'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type3_Stool_Microscopy_Test',
                  isLangEnglish
                      ? "Stool Microscopy Test"
                      : "स्टूल माइक्रोस्कोपी टेस्ट",
                )
              : SizedBox(
                  height: 0,
                ),
          Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                      .swasthyaMitraAvailableTestsMapping['Type3_ESR_Test'] ==
                  true
              ? checkboxAvailableTestWidget(
                  context,
                  'Type3_ESR_Test',
                  isLangEnglish ? "ESR Test" : "ईएसआर टेस्ट",
                )
              : SizedBox(
                  height: 0,
                ),
          SizedBox(
            height: minDimension * 0.05,
          ),
          InkWell(
            onTap: () {
              if (selectedTest == "") {
                String titleText =
                    isLangEnglish ? "Test not selected" : "टेस्ट चयनित नहीं";
                String contextText = isLangEnglish
                    ? "Please select an available test"
                    : "कृपया एक उपलब्ध टेस्ट का चयन करें";
                _checkForError(context, titleText, contextText);
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PatientScheduleTestScreen(
                      selectedTest: selectedTest,
                    ),
                  ),
                );
              }
            },
            child: Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: width * 0.025,
                ),
                height: height * 0.08,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: const Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
                    left: BorderSide(width: 1.0, color: Colors.grey),
                    right: BorderSide(width: 1.0, color: Colors.grey),
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                child: Text(
                  // isLangEnglish ? "Confirm Test Appointment" : "जांच की पुष्टि करें",
                  isLangEnglish ? "Schedule Appointment" : "जांच अनुसूची करें",
                  style: TextStyle(
                    color: Color(0xff42ccc3),
                    fontWeight: FontWeight.w500,
                    fontSize: 17.5,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: minDimension * 0.065,
          ),
        ],
      ),
    );
  }

  // Provider.of<SwasthyaMitraUserDetails>(context,listen: false).swasthyaMitraAvailableTestsMapping

  Widget checkboxAvailableTestWidget(
    BuildContext context,
    String uniqueText,
    String headerText,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    return Container(
      child: Material(
        child: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Color.fromRGBO(120, 158, 156, 1),
          ),
          child: Align(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: CheckboxListTile(
                title: Text(headerText),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Color.fromRGBO(120, 158, 156, 1),
                checkColor: Colors.white,
                // value: editCheckBoxMapping[uniqueText],
                value: selectedTestsMapping[uniqueText],
                onChanged: (bool? value) {
                  setState(() {
                    selectedTestsMapping.forEach((key, value) {
                      // print("$key <-> $value");
                      selectedTestsMapping[key] = false;
                    });
                    selectedTestsMapping[uniqueText] = !selectedTestsMapping[uniqueText]!;
                    selectedTest = selectedTestsHeadingMapping[uniqueText]!;
                  });
                  // if (isEditBtnPressed) {
                  //   setState(() {
                  //     Provider.of<SwasthyaMitraUserDetails>(context,
                  //                 listen: false)
                  //             .swasthyaMitraAvailableTestsMapping[uniqueText] =
                  //         !Provider.of<SwasthyaMitraUserDetails>(context,
                  //                 listen: false)
                  //             .swasthyaMitraAvailableTestsMapping[uniqueText]!;

                  //     Provider.of<SwasthyaMitraUserDetails>(context,
                  //             listen: false)
                  //         .updateSwasthyaMitraUserPersonalInformation(
                  //             context,
                  //             uniqueText,
                  //             Provider.of<SwasthyaMitraUserDetails>(context,
                  //                     listen: false)
                  //                 .swasthyaMitraAvailableTestsMapping[
                  //                     uniqueText]
                  //                 .toString());
                  //   });
                  // }
                },
              ),
            ),
          ),
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
