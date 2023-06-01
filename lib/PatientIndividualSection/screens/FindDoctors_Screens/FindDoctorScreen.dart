// ignore_for_file: prefer_final_fields, prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable, unused_import, duplicate_import

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
import './PatientSearchForDoctor_Screen.dart';
import './DoctorDetails_Screen.dart';

class FindDoctorScreenPatient extends StatefulWidget {
  static const routeName = '/patient-find-doctor-screen';

  @override
  State<FindDoctorScreenPatient> createState() =>
      _FindDoctorScreenPatientState();
}

class _FindDoctorScreenPatientState extends State<FindDoctorScreenPatient> {
  TextEditingController _search = TextEditingController();
  bool isLangEnglish = true;
  bool ispressed = false;
  String dropValueLeft = "General Medicine";
  String dropValueRight = "Medicine Type";
  List<String> departments = [
    'Neuro-interventional Radiology',
    'Psychiatry',
    'Cosmetology',
    'Neurology',
    'Endocrinology',
    'Neuro Surgery',
    'General Medicine',
    'Ophthalmology',
    'Cardiology',
    'Nephrology',
    'Paediatrics',
    'ENT',
    'Oncology',
    'Gastroenterology',
    'Gynaecology',
    'Urology',
  ];
  String dept_selected = " ";
  List<String> doctors = [
    'Neuro-interventional Radiology',
    'Psychiatry',
    'Cosmetology',
    'Neurology',
    'Endocrinology',
    'Neuro Surgery',
    'General Medicine',
    'Ophthalmology',
    'Cardiology',
    'Nephrology',
    'Paediatrics',
    'ENT',
    'Oncology',
    'Gastroenterology',
    'Gynaecology',
    'Urology',
  ];
  var MedicineTypeList = [
    'Medicine Type',
    'Ayurvedic',
    'Homeopathy',
    'Yogic',
    'Siddha',
    'Unani',
    'Allopathy',
  ];
  String doc_selected = " ";

  List<String> recent_search = [
    'Neuro-interventional Radiology',
    'Psychiatry',
    'Cosmetology',
    'Neurology',
    'Endocrinology',
    'Neuro Surgery',
  ];

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<PatientAvailableDoctorDetails>(context, listen: false)
        .fetchDoctorsForAppointment(context, {});
  }

  Future<void> _refreshAvailableDoctors(
      BuildContext context, Map<String, String> filteredOptions) async {
    Provider.of<PatientAvailableDoctorDetails>(context, listen: false)
        .fetchDoctorsForAppointment(context, {});
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
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        MediaQuery.of(context).size.height - _padding.top - _padding.bottom;

    var doctorUserInfoDetails =
        Provider.of<PatientAvailableDoctorDetails>(context);

    return Scaffold(
      backgroundColor: Color(0xFFfbfcff),
      body: ListView(
        children: [
          Card(
            elevation: 0.5,
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: maxDimension * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: screenWidth * 0.925,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.025,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          isLangEnglish
                              ? "Book an Appointment with Doctor"
                              : "डॉक्टर के साथ अपॉइंटमेंट बुक करें",
                          style: TextStyle(
                            fontSize: minDimension * 0.0625,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: maxDimension * 0.013,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: screenWidth * 0.925,
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                          hintText: isLangEnglish ? "Search" : "खोज",
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffebebeb)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff6c757d),
                          ),
                          suffixIcon: IconButton(
                            icon: Image.asset('assets/images/Search.png'),
                            iconSize: minDimension * 0.125,
                            onPressed: () {
                              TextEditingController searchedText =
                                  TextEditingController();
                              searchedText.text = _search.text;

                              Provider.of<PatientAvailableDoctorDetails>(
                                      context,
                                      listen: false)
                                  .fetchFilteredDoctorsForAppointment(
                                      context, searchedText)
                                  .then((value) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PatientSearchForDoctorScreen(
                                      searchedText,
                                    ),
                                  ),
                                );
                                _search.text = "";
                                FocusScope.of(context).unfocus();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: maxDimension * 0.015,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: screenWidth * 0.925,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            // width: screenWidth * 0.445,
                            width: screenWidth * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color.fromRGBO(66, 204, 195, 1),
                                width: 1,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(66, 204, 195, 1)),
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(66, 204, 195, 1)),
                                  prefixStyle: TextStyle(
                                      color: Color.fromRGBO(66, 204, 195, 1)),
                                  floatingLabelStyle: TextStyle(
                                      color: Color.fromRGBO(66, 204, 195, 1)),
                                  counterStyle: TextStyle(
                                      color: Color.fromRGBO(66, 204, 195, 1)),
                                ),
                                value: '$dropValueRight',
                                focusColor: Color.fromRGBO(66, 204, 195, 1),
                                items: MedicineTypeList.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _search.text = newValue!;
                                  });

                                  ///////////////////////////////////////////////////////////
                                  TextEditingController searchedText =
                                      TextEditingController();
                                  searchedText.text = _search.text;

                                  Provider.of<PatientAvailableDoctorDetails>(
                                          context,
                                          listen: false)
                                      .fetchFilteredDoctorsForAppointment(
                                          context, searchedText)
                                      .then((value) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PatientSearchForDoctorScreen(
                                          searchedText,
                                        ),
                                      ),
                                    );
                                    _search.text = "";
                                    searchedText.text = _search.text;
                                    setState(() {
                                      dropValueRight = "Medicine Type";
                                    });
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            // width: screenWidth * 0.445,
                            width: screenWidth * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color.fromRGBO(66, 204, 195, 1),
                                width: 1,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Color.fromRGBO(66, 204, 195, 1),
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(66, 204, 195, 1),
                                  ),
                                  prefixStyle: TextStyle(
                                    color: Color.fromRGBO(66, 204, 195, 1),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    color: Color.fromRGBO(66, 204, 195, 1),
                                  ),
                                  counterStyle: TextStyle(
                                    color: Color.fromRGBO(66, 204, 195, 1),
                                  ),
                                ),
                                value: '$dropValueLeft',
                                focusColor: Color.fromRGBO(66, 204, 195, 1),
                                items: doctors.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _search.text = newValue!;
                                  });

                                  ///////////////////////////////////////////////////////////
                                  TextEditingController searchedText =
                                      TextEditingController();
                                  searchedText.text = _search.text;

                                  Provider.of<PatientAvailableDoctorDetails>(
                                          context,
                                          listen: false)
                                      .fetchFilteredDoctorsForAppointment(
                                          context, searchedText)
                                      .then((value) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PatientSearchForDoctorScreen(
                                          searchedText,
                                        ),
                                      ),
                                    );
                                    _search.text = "";
                                    searchedText.text = _search.text;
                                    setState(() {
                                      dropValueLeft = "General Medicine";
                                    });
                                    FocusScope.of(context).unfocus();
                                  });
                                },
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     TextEditingController searchText = TextEditingController();
                          //     searchText.text = "Diabetologist";

                          //     Provider.of<PatientAvailableDoctorDetails>(
                          //             context,
                          //             listen: false)
                          //         .fetchFilteredDoctorsForAppointment(
                          //             context, searchText)
                          //         .then((value) {
                          //       Navigator.of(context).push(
                          //         MaterialPageRoute(
                          //           builder: (context) =>
                          //               PatientSearchForDoctorScreen(
                          //             searchText,
                          //           ),
                          //         ),
                          //       );
                          //       _search.text = "";
                          //       FocusScope.of(context).unfocus();
                          //     });
                          //   },
                          //   child: Container(
                          //     width: screenWidth * 0.425,
                          //     padding: EdgeInsets.symmetric(
                          //       horizontal: minDimension * 0.02125,
                          //       // vertical: maxDimension * 0.01,
                          //       vertical: 20,
                          //     ),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(7.5),
                          //       border: Border.all(
                          //         color: Color.fromRGBO(66, 204, 195, 1),
                          //         width: 2,
                          //       ),
                          //     ),
                          //     child: Text(
                          //       isLangEnglish
                          //           ? "Diabetologist"
                          //           : "मधुमेह चिकित्सक",
                          //       style: TextStyle(
                          //         // color: Color.fromRGBO(66, 204, 195, 1),
                          //         fontSize: minDimension * 0.0415,
                          //       ),
                          //       textAlign: TextAlign.center,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: maxDimension * 0.03,
                  ),
                  Container(
                    child: doctorUserInfoDetails.itemsDoctorDetails.isEmpty
                        ? RefreshIndicator(
                            onRefresh: () {
                              return _refreshAvailableDoctors(context, {});
                            },
                            child: Container(
                              child: Text(
                                isLangEnglish
                                    ? "Loading..."
                                    : "लोड हो रहा है...",
                                style: TextStyle(
                                  fontSize: minDimension * 0.065,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(66, 204, 195, 1),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: maxDimension * 0.65,
                            width: screenWidth * 0.95,
                            child: ListView.builder(
                              itemCount: doctorUserInfoDetails
                                      .itemsDoctorDetails.length +
                                  1,
                              itemBuilder: (ctx, index) {
                                if (index <
                                    doctorUserInfoDetails
                                        .itemsDoctorDetails.length) {
                                  return doctorDetailInfoWidget(
                                    context,
                                    doctorUserInfoDetails
                                        .itemsDoctorDetails[index],
                                  );
                                } else {
                                  return SizedBox(
                                    height: maxDimension * 0.05,
                                  );
                                }
                              },
                            ),
                          ),
                  ),
                  SizedBox(
                    height: maxDimension * 0.15,
                  ),
                ],
              ),
            ),
          ),
        ],
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
                  width: screenWidth * 0.525,
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
                width: minDimension * 0.0815,
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

  Widget searchBarOnTapScreen(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        MediaQuery.of(context).size.height - _padding.top - _padding.bottom;

    var doctorUserInfoDetails =
        Provider.of<PatientAvailableDoctorDetails>(context);

    return Scaffold(
      backgroundColor: Color(0xFFfbfcff),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: _padding.top),
            child: Stack(
              children: [
                Positioned(
                  width: _width,
                  top: 0.718670 * _height,
                  child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/Appointemnt_pg_vector.svg',
                    ),
                    // Image.asset('assets/images/Appointemnt_pg_vector.png'),
                  ),
                ),
                Positioned(
                  left: 0.05555555 * _width,
                  top: 0.025575 * _height,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      isLangEnglish
                          ? "Book an appointment with Doctor"
                          : "डॉक्टर के साथ अपॉइंटमेंट बुक करें",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff2c2c2c),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.05555555 * _width,
                  top: 0.08695652 * _height,
                  width: 0.888888 * _width,
                  height: 0.06393861 * _height,
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      hintText: isLangEnglish ? "Search" : "खोज",
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffebebeb),
                        ),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff6c757d),
                      ),
                      suffixIcon: IconButton(
                        icon: Image.asset('assets/images/Search.png'),
                        onPressed: () {
                          setState(() {
                            recent_search.insert(0, _search.text);
                          });
                          print("serchpressed $ispressed");
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.05555555 * _width,
                  top: 0.162404 * _height,
                  width: 0.4111111 * _width,
                  height: 0.0447570 * _height,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffebebeb),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        _display_dept_Dialog(context);
                      },
                      child: Text(
                        isLangEnglish ? "Department" : "विभाग",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff6c757d),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.533333333 * _width,
                  top: 0.162404 * _height,
                  width: 0.4111111 * _width,
                  height: 0.0447570 * _height,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffebebeb),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        _display_doc_Dialog(context);
                      },
                      child: Text(
                        isLangEnglish ? "Doctor type" : "डॉक्टर का प्रकार",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff6c757d),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.62222 * _width,
                  top: 0.23785 * _height,
                  child: Text(
                    isLangEnglish ? "Recent Search" : "हाल की खोज",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: Color(0xffc4c4c4),
                    ),
                  ),
                ),
                Positioned(
                    left: 0.0694444 * _width,
                    top: 0.273657 * _height,
                    child: Container(
                      padding: EdgeInsets.zero,
                      width: _width,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: recent_search.length >= 5
                            ? 5
                            : recent_search.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            leading: Transform.rotate(
                              angle: 45 * pi / 180,
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Color(0xffc4c4c4),
                                ),
                                onPressed: () {
                                  setState(() {
                                    print("${recent_search[index]}removed");
                                    recent_search.remove(recent_search[index]);
                                  });
                                },
                              ),
                            ),
                            title: Text(
                              recent_search[index],
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                color: Color(0xffc4c4c4),
                              ),
                            ),
                          );
                        },
                      ),
                    ))
                /*To check selected item
                Positioned(
                    left: 0.05555555 * _width,
                    top: 0.21355 * _height,
                    width: 0.4111111 * _width,
                    height: 0.0447570 * _height,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffebebeb),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          _display_dept_Dialog(context);
                        },
                        child: Text(
                          dept_selected,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff6c757d),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    left: 0.533333333 * _width,
                    top: 0.21355 * _height,
                    width: 0.4111111 * _width,
                    height: 0.0447570 * _height,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffebebeb),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          doc_selected,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff6c757d),
                          ),
                        ),
                      ),
                    )
                ),
      
                 */
              ],
            ),
          ),
        ],
      ),
    );
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
                    style: TextStyle(color: Colors.black),
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

  _display_dept_Dialog(BuildContext context) async {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    dept_selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        print(MediaQuery.of(context).size.width);
        return SimpleDialog(
          title: Text(
              isLangEnglish ? 'Select the Department' : 'विभाग का चयन करें'),
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            color: Color(0xff2c2c2c),
          ),
          titlePadding: EdgeInsets.only(
            left: 0.05833333 * _width,
            top: 2 * 0.011508951 * _height,
          ),
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                width: 0.79444444 * _width,
                height: 0.80434782 * _height,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: departments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      dense: true,
                      title: Text(
                        departments[index],
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff2c2c2c),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          dept_selected = departments[index];
                        });
                        print("serchpressed ${doctors[index]}");
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _display_doc_Dialog(BuildContext context) async {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    dept_selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        print(MediaQuery.of(context).size.width);
        return SimpleDialog(
          title: Text(isLangEnglish
              ? 'Select the Doctor Type'
              : 'डॉक्टर प्रकार का चयन करें'),
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            color: Color(0xff2c2c2c),
          ),
          titlePadding: EdgeInsets.only(
            left: 0.05833333 * _width,
            top: 2 * 0.011508951 * _height,
          ),
          children: [
            Container(
              width: 0.79444444 * _width,
              height: 0.80434782 * _height,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: doctors.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    dense: true,
                    title: Text(
                      doctors[index],
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff2c2c2c),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        doc_selected = doctors[index];
                      });
                      print("serchpressed ${doctors[index]}");
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
