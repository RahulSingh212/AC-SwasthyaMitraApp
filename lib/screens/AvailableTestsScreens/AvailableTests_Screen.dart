// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, avoid_unnecessary_containers, unused_import, unused_local_variable

import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/SM_User_Details.dart';

class AvailableTestsSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-available-tests-screen';

  @override
  State<AvailableTestsSwasthyaMitra> createState() =>
      _AvailableTestsSwasthyaMitraState();
}

class _AvailableTestsSwasthyaMitraState
    extends State<AvailableTestsSwasthyaMitra> {
  bool isLangEnglish = true;
  bool isEditBtnPressed = false;

  // bool Type1_Blood_Tests = false;
  // bool Type1_Complete_Blood_Count = false;
  // bool Type1_Liver_Function_Tests = false;

  // bool Type2_Kidney_Function_Tests = false;
  // bool Type2_Lipid_Profile = false;
  // bool Type2_Blood_Sugar_Test = false;
  // bool Type2_Urine_Test = false;
  // bool Type2_Cardiac_Blood_Text = false;
  // bool Type2_Thyroid_Function_Test = false;

  // bool Type3_Blood_Tests_For_Infertility = false;
  // bool Type3_Semen_Analysis_Test = false;
  // bool Type3_Blood_Tests_For_Arthritis = false;
  // bool Type3_Dengu_Serology = false;
  // bool Type3_Chikungunya_Test = false;
  // bool Type3_HIV_Test = false;
  // bool Type3_Pregnancy_Test = false;
  // bool Type3_Stool_Microscopy_Test = false;
  // bool Type3_ESR_Test = false;

  @override
  void initState() {
    super.initState();

    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  // Map<String, bool> editCheckBoxMapping = {
  //   "Type1_Blood_Tests": false,
  //   "Type1_Complete_Blood_Count": false,
  //   "Type1_Liver_Function_Tests": false,

  //   "Type2_Kidney_Function_Tests": false,
  //   "Type2_Lipid_Profile": false,
  //   "Type2_Blood_Sugar_Test": false,
  //   "Type2_Urine_Test": false,
  //   "Type2_Cardiac_Blood_Text": false,
  //   "Type2_Thyroid_Function_Test": false,

  //   "Type3_Blood_Tests_For_Infertility": false,
  //   "Type3_Semen_Analysis_Test": false,
  //   "Type3_Blood_Tests_For_Arthritis": false,
  //   "Type3_Dengu_Serology": false,
  //   "Type3_Chikungunya_Test": false,
  //   "Type3_HIV_Test": false,
  //   "Type3_Pregnancy_Test": false,
  //   "Type3_Stool_Microscopy_Test": false,
  //   "Type3_ESR_Test": false,
  // };

  Map<String, bool> copyOfEditCheckBoxMapping = {};

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
      // backgroundColor: Color(0xFFf2f3f4),
      backgroundColor: Colors.white,
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
                isLangEnglish ? "Tests Offered" : "टेस्ट की पेशकश",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: minDimension * 0.065,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: 0.01 * width,
                bottom: 0.02 * width,
              ),
              child: Text(
                isLangEnglish
                    ? "Select the available tests options"
                    : "उपलब्ध जांच विकल्पों का चयन करें",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.22 * (0.035 / 15) * width,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          // SizedBox(
          //   height: minDimension * 0.015,
          // ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.only(
                top: minDimension * 0.015,
                // bottom: minDimension * 0.015,
                left: minDimension * 0.045,
                right: minDimension * 0.025,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    // decoration: BoxDecoration(
                    //   // color: Color.fromRGBO(66, 204, 195, 1),
                    //   borderRadius: BorderRadius.circular(15),
                    // ),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {
                          isEditBtnPressed = !isEditBtnPressed;
                        });
                      },
                      icon: Icon(
                        !isEditBtnPressed
                            ? Icons.edit
                            : Icons.dangerous_rounded,
                        size: screenWidth * 0.07,
                      ),
                      label: Text(
                        !isEditBtnPressed
                            ? isLangEnglish
                                ? "EDIT"
                                : "एडिट"
                            : isLangEnglish
                                ? "CLOSE"
                                : "बंद",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(66, 204, 195, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            child: Container(
              margin: EdgeInsets.only(
                top: minDimension * 0.05,
                bottom: minDimension * 0.025,
              ),
              width: screenWidth * 0.95,
              child: Text(
                isLangEnglish ? "Type - 1" : "टाइप - 1",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: minDimension * 0.055,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          checkboxAvailableTestWidget(
            context,
            'Type1_Blood_Tests',
            isLangEnglish ? "Blood Tests" : "रक्त परीक्षण",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type1_Complete_Blood_Count',
            isLangEnglish ? "Complete Blood Count" : "पूर्ण रक्त गणना",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type1_Liver_Function_Tests',
            isLangEnglish ? "Liver Function Tests(LFT)" : "लिवर फंक्शन टेस्ट(एलएफटी)",
          ),
          Align(
            child: Container(
              margin: EdgeInsets.only(
                top: minDimension * 0.05,
                bottom: minDimension * 0.025,
              ),
              width: screenWidth * 0.95,
              child: Text(
                isLangEnglish ? "Type - 2" : "टाइप - 2",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: minDimension * 0.055,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          checkboxAvailableTestWidget(
            context,
            'Type2_Kidney_Function_Tests',
            isLangEnglish ? "Kidney Function Tests" : "किडनी फंक्शन टेस्ट",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type2_Lipid_Profile',
            isLangEnglish ? "Lipid Profile" : "लिपिड प्रोफाइल",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type2_Blood_Sugar_Test',
            isLangEnglish ? "Blood Sugar Test" : "ब्लड शुगर टेस्ट",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type2_Urine_Test',
            isLangEnglish ? "Urine Test" : "मूत्र परीक्षण",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type2_Cardiac_Blood_Text',
            isLangEnglish ? "Cardiac Blood Text" : "हृदय रक्त पाठ",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type2_Thyroid_Function_Test',
            isLangEnglish ? "Thyroid Function Test" : "थायराइड फंक्शन टेस्ट",
          ),
          Align(
            child: Container(
              margin: EdgeInsets.only(
                top: minDimension * 0.05,
                bottom: minDimension * 0.025,
              ),
              width: screenWidth * 0.95,
              child: Text(
                isLangEnglish ? "Type - 3" : "टाइप - 3",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: minDimension * 0.055,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          checkboxAvailableTestWidget(
            context,
            'Type3_Blood_Tests_For_Infertility',
            isLangEnglish ? "Blood Tests For Infertility" : "बांझपन के लिए रक्त परीक्षण",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type3_Semen_Analysis_Test',
            isLangEnglish ? "Semen Analysis Test" : "वीर्य विश्लेषण परीक्षण",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type3_Blood_Tests_For_Arthritis',
            isLangEnglish ? "Blood Tests For Arthritis" : "गठिया रक्त परीक्षण",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type3_Dengu_Serology',
            isLangEnglish ? "Dengu Serology" : "डेंगू सीरोलॉजी",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type3_Chikungunya_Test',
            isLangEnglish ? "Chikungunya Test" : "चिकनगुनिया टेस्ट",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type3_HIV_Test',
            isLangEnglish ? "HIV-1 & HIV-2 Test" : "एचआईवी-1 और एचआईवी-2 परीक्षण",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type3_Pregnancy_Test',
            isLangEnglish ? "Pregnancy Test" : "गर्भावस्था परीक्षण",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type3_Stool_Microscopy_Test',
            isLangEnglish ? "Stool Microscopy Test" : "स्टूल माइक्रोस्कोपी टेस्ट",
          ),
          checkboxAvailableTestWidget(
            context,
            'Type3_ESR_Test',
            isLangEnglish ? "ESR Test" : "ईएसआर टेस्ट",
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          // isEditBtnPressed
          //     ? InkWell(
          //         onTap: () {
          //           setState(() {
          //             isEditBtnPressed = false;
          //             // editCheckBoxMapping.forEach((key, value) {
          //             //   print("${key}: ${value}");
          //             // });
          //           });
          //         },
          //         child: Align(
          //           child: Container(
          //             alignment: Alignment.center,
          //             height: height * 0.065,
          //             width: width * 0.95,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               color: Color.fromRGBO(66, 204, 195, 1),
          //               border: const Border(
          //                 top: BorderSide(width: 1.0, color: Colors.grey),
          //                 left: BorderSide(width: 1.0, color: Colors.grey),
          //                 right: BorderSide(width: 1.0, color: Colors.grey),
          //                 bottom: BorderSide(width: 1.0, color: Colors.grey),
          //               ),
          //             ),
          //             child: Text(
          //               isLangEnglish ? "SAVE" : "सहेजें",
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 20,
          //               ),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //         ),
          //       )
          //     : SizedBox(
          //         height: 0,
          //       ),
          SizedBox(
            height: isEditBtnPressed ? (maxDimension * 0.03) : 0,
          ),
        ],
      ),
    );
  }

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
                value: Provider.of<SwasthyaMitraUserDetails>(context,
                        listen: false)
                    .swasthyaMitraAvailableTestsMapping[uniqueText],
                onChanged: (bool? value) {
                  if (isEditBtnPressed) {
                    setState(() {
                      Provider.of<SwasthyaMitraUserDetails>(context,
                                  listen: false)
                              .swasthyaMitraAvailableTestsMapping[uniqueText] =
                          !Provider.of<SwasthyaMitraUserDetails>(context,
                                  listen: false)
                              .swasthyaMitraAvailableTestsMapping[uniqueText]!;

                      Provider.of<SwasthyaMitraUserDetails>(context,
                              listen: false)
                          .updateSwasthyaMitraUserPersonalInformation(
                              context,
                              uniqueText,
                              Provider.of<SwasthyaMitraUserDetails>(context,
                                      listen: false)
                                  .swasthyaMitraAvailableTestsMapping[
                                      uniqueText]
                                  .toString());
                    });
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
