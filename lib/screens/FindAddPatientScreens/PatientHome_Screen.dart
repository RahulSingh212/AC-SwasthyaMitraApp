// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, unused_field, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_import, avoid_unnecessary_containers, unused_local_variable, import_of_legacy_library_into_null_safe, prefer_final_fields, use_key_in_widget_constructors, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/patient_Info.dart';
import '../../providers/SM_User_Details.dart';

class PatientHomeScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-patient-home-screen';

  int pageIndex;
  PatientDetailsInformation patientDetails;

  PatientHomeScreenSwasthyaMitra(
    this.pageIndex,
    this.patientDetails,
  );

  @override
  State<PatientHomeScreenSwasthyaMitra> createState() =>
      _PatientHomeScreenSwasthyaMitraState();
}

class _PatientHomeScreenSwasthyaMitraState extends State<PatientHomeScreenSwasthyaMitra> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<SwasthyaMitraUserDetails>(context, listen: false).isReadingLangEnglish;
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

    return ListView(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: screenHeight * 0.05,
          width: screenWidth * 0.95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(
                    Icons.notifications_none,
                    size: 0.095 * screenWidth,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(MyProfileScreen.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  height: screenWidth * 0.1125,
                  width: screenWidth * 0.1125,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: screenWidth,
                    child: CircleAvatar(
                      radius: screenWidth,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          screenWidth,
                        ),
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: widget
                                        .patientDetails.patient_ProfilePicUrl ==
                                    ""
                                ? Image.asset(
                                    "assets/images/uProfile.png",
                                  )
                                : Image.network(
                                    widget.patientDetails.patient_ProfilePicUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
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
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Align(
            child: Container(
              width: screenWidth * 0.75,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => PatientViewPrescriptionScreen(
                  //       2,
                  //       Provider.of<PatientUserDetails>(context, listen: false).mp['patient_personalUniqueIdentificationId'] ?? "",
                  //       widget.tokenInfo,
                  //     ),
                  //   ),
                  // );
                },
                icon: Icon(
                  Icons.contact_page,
                  size: screenWidth * 0.075,
                ),
                label: Text(
                  isLangEnglish ? "VIEW PRESCRIPTION" : "प्रिस्क्रिप्शन देखें",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(66, 204, 195, 1),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.0125,
                    horizontal: screenWidth * 0.075,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(75),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
