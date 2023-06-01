// ignore_for_file: prefer_final_fields, prefer_const_constructors, avoid_unnecessary_containers, unused_field, unused_import, duplicate_import, must_be_immutable, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/doctor_Info.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAvailableDoctor_details.dart';
import '../../providers/patientUser_details.dart';
import './DoctorDetails_Screen.dart';

class PatientSearchForDoctorScreen extends StatefulWidget {
  static const routeName = '/patient-search-for-doctor-screen';

  TextEditingController _searchedText;

  PatientSearchForDoctorScreen(this._searchedText);

  @override
  State<PatientSearchForDoctorScreen> createState() =>
      _PatientSearchForDoctorScreenState();
}

class _PatientSearchForDoctorScreenState
    extends State<PatientSearchForDoctorScreen> {
  TextEditingController _search = TextEditingController();
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();
    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenHeight, screenWidth);
    var maxDimension = max(screenHeight, screenWidth);

    var doctorUserInfoDetails = Provider.of<PatientAvailableDoctorDetails>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        title: Text(
          isLangEnglish ? "Searched Resluts" : "खोजे गए परिणाम",
        ),
        centerTitle: true,
      ),
      body: doctorUserInfoDetails.itemsSearchedDoctorDetails.isEmpty
          ? Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                ),
                alignment: Alignment.center,
                height: screenHeight * 0.5,
                width: screenWidth * 0.85,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.0125,
                ),
                child: Text(
                  isLangEnglish
                      ? "No results found for your search : \n' ${widget._searchedText.text} ' "
                      : "आपकी खोज के लिए कोई परिणाम नहीं मिला : \n' ${widget._searchedText.text} ' ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: minDimension * 0.075,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(66, 204, 195, 1),
                  ),
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              // height: maxDimension * 0.85,
              child: ListView.builder(
                itemCount:
                    doctorUserInfoDetails.itemsSearchedDoctorDetails.length + 1,
                itemBuilder: (ctx, index) {
                  if (index <
                      doctorUserInfoDetails.itemsSearchedDoctorDetails.length) {
                    return doctorDetailInfoWidget(
                      context,
                      doctorUserInfoDetails.itemsSearchedDoctorDetails[index],
                    );
                  } else {
                    return SizedBox(
                      height: screenHeight * 0.1,
                    );
                  }
                },
              ),
            ),
    );
  }

  Widget doctorDetailInfoWidget(
    BuildContext context,
    DoctorDetailsInformation doctorDetails,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(
              2,
              doctorDetails,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.5),
          // side: BorderSide(
          //   width: 5,
          //   color: Colors.green,
          // ),
        ),
        child: Container(
          height: maxDimension * 0.15,
          padding: EdgeInsets.symmetric(
            horizontal: minDimension * 0.0125,
            vertical: maxDimension * 0.00625,
          ),
          margin: EdgeInsets.only(
            bottom: maxDimension * 0.0025,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white70,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: minDimension * 0.25,
                decoration: BoxDecoration(
                  image: doctorDetails.doctor_ProfilePicUrl == ""
                      ? DecorationImage(
                          image: AssetImage(
                            'assets/images/surgeon.png',
                          ),
                          fit: BoxFit.fill,
                        )
                      : DecorationImage(
                          image:
                              NetworkImage(doctorDetails.doctor_ProfilePicUrl),
                          fit: BoxFit.fill,
                        ),
                  // border: Border.all(
                  //   color: Color.fromARGB(255, 233, 218, 218),
                  //   width: 1,
                  // ),
                  borderRadius: BorderRadius.circular(5),
                ),
                // child: Center(
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: doctorDetails.doctor_ProfilePicUrl == ""
                //         ? Image.asset(
                //             'assets/images/surgeon.png',
                //             fit: BoxFit.fill,
                //             width: minDimension * 0.25,
                //           )
                //         : Image.network(
                //             doctorDetails.doctor_ProfilePicUrl,
                //             fit: BoxFit.fill,
                //             width: minDimension * 0.25,
                //           ),
                //   ),
                // ),
              ),
              SizedBox(
                width: minDimension * 0.01,
              ),
              Align(
                // fit: BoxFit.fitHeight,
                child: Container(
                  width: screenWidth * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          doctorDetails.doctor_FullName
                                      .toLowerCase()
                                      .contains("dr") ||
                                  doctorDetails.doctor_FullName.contains("डॉ ")
                              ? doctorDetails.doctor_FullName
                              : isLangEnglish
                                  ? "Dr. ${doctorDetails.doctor_FullName}"
                                  : "डॉ. ${doctorDetails.doctor_FullName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: minDimension * 0.039,
                            color: Colors.black,
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        child: Text(
                          doctorDetails.doctor_Speciality,
                          style: TextStyle(
                            fontSize: minDimension * 0.0375,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(114, 114, 114, 1),
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        child: Text(
                          isLangEnglish
                              ? "${doctorDetails.doctor_YearsOfExperience.toString()}+ Years Experience"
                              : "${doctorDetails.doctor_YearsOfExperience.toString()}+ वर्षों अनुभव",
                          style: TextStyle(
                            fontSize: minDimension * 0.03,
                            color: Color.fromRGBO(114, 114, 114, 1),
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        child: Text(
                          isLangEnglish ? "English/Hindi" : "अंग्रेजी/हिंदी",
                          style: TextStyle(
                            fontSize: minDimension * 0.034,
                            color: Color.fromRGBO(114, 114, 114, 1),
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        child: Text(
                          isLangEnglish
                              ? "${doctorDetails.doctor_NumberOfPatientsTreated} Patients Treated"
                              : "${doctorDetails.doctor_NumberOfPatientsTreated} मरीजों का इलाज",
                          style: TextStyle(
                            fontSize: minDimension * 0.034,
                            color: Color.fromRGBO(114, 114, 114, 1),
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: minDimension * 0.065,
                alignment: Alignment.topCenter,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                      vertical: screenHeight * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(66, 204, 195, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${doctorDetails.doctor_ExperienceRating}",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
