// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_element, dead_code, void_checks, unnecessary_brace_in_string_interps, unused_import, must_be_immutable, deprecated_member_use, unused_local_variable, unnecessary_null_comparison

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/providers/SM_Patient_Personal_Details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/appointment_info.dart';
import '../../providers/SM_User_Details.dart';

class PatientAppointmentDescriptionScreen extends StatefulWidget {
  static const routeName =
      'swasthya-mitra-patient-appointment-description-screen';

  int pageIndex;
  AppointmentDetailsInformation tokenInfo;

  PatientAppointmentDescriptionScreen(
    this.pageIndex,
    this.tokenInfo,
  );

  @override
  State<PatientAppointmentDescriptionScreen> createState() =>
      _PatientAppointmentDescriptionScreenState();
}

class _PatientAppointmentDescriptionScreenState
    extends State<PatientAppointmentDescriptionScreen> {
  Map<String, String> userMapping = {};
  bool isLangEnglish = true;
  bool isBookedSlotAvailable = true;
  var currDate = DateTime.now();
  Map<int, double> downloadProgress = {};
  double prescriptionSize = 0;

  late Future<ListResult> futureFiles;
  late Future<ListResult> futureFilesDocPres;

  @override
  void initState() {
    super.initState();

    // setState(() {
    //   Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).fetchPatientPersonalUserDetails(context, widget.tokenInfo).then((value) {
    //     userMapping = Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping;
    //   });
    // });

    String aptDate = "${widget.tokenInfo.appointmentDate.day}-${widget.tokenInfo.appointmentDate.month}-${widget.tokenInfo.appointmentDate.year}";
    String aptTime = widget.tokenInfo.appointmentTime.toString();
    String refLinkForPatientPrescription = "PatientReportsAndPrescriptionsDetails/${widget.tokenInfo.patient_personalUniqueIdentificationId}/${widget.tokenInfo.doctor_personalUniqueIdentificationId}/${widget.tokenInfo.registeredTokenId}/${aptDate}/${aptTime}/PatientPreviousPrescription";

    String refLinkForDoctorPrescription = "PatientReportsAndPrescriptionsDetails/${widget.tokenInfo.patient_personalUniqueIdentificationId}/${widget.tokenInfo.doctor_personalUniqueIdentificationId}/${widget.tokenInfo.registeredTokenId}/${aptDate}/${aptTime}/DoctorGivenPrescription";

    futureFiles = FirebaseStorage.instance
    .ref('/${refLinkForPatientPrescription}').listAll();

    futureFilesDocPres = FirebaseStorage.instance
        .ref('/${refLinkForDoctorPrescription}')
        .listAll();

    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (currDate.isAfter(widget.tokenInfo.bookedTokenDate.add(Duration(days: 2)))) {
    //   isBookedSlotAvailable = false;
    // }

    // setState(() {
    //   userMapping = Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping;
    // });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    prescriptionSize = screenHeight * 0.25;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        title: Text('${Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping['patient_FullName']}'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    width: 1,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.025,
                    horizontal: screenWidth * 0.05,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenWidth * 0.35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              isLangEnglish ? "AGE" : "आयु"),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Container(
                                            child: Text.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: Provider.of<SwasthyaMitraPatientPersonalDetails>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .paitentUserMapping[
                                                                'patient_Age'] ==
                                                            ""
                                                        ? "NA"
                                                        : "${Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping['patient_Age']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' yrs',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: ClipOval(
                                      child: Material(
                                        color: Color.fromRGBO(
                                            220, 229, 228, 1), // Button color
                                        child: InkWell(
                                          splashColor: Color.fromRGBO(
                                              120, 158, 156, 1), // Splash color
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.all(2),
                                            child: SizedBox(
                                              width: screenWidth * 0.075,
                                              height: screenWidth * 0.075,
                                              child: Icon(
                                                Icons.heat_pump_rounded,
                                                color: Color.fromRGBO(
                                                    0, 132, 242, 1),
                                                size: 20,
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
                            // VerticalDivider(
                            //   color: Colors.black,
                            //   thickness: 1,
                            // ),
                            Container(
                              width: screenWidth * 0.35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                              isLangEnglish ? "BLOOD" : "रक्त"),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Container(
                                            child: Text.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: Provider.of<SwasthyaMitraPatientPersonalDetails>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .paitentUserMapping[
                                                                'patient_BloodGroup'] ==
                                                            ""
                                                        ? "NA"
                                                        : "${Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping['patient_BloodGroup']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                  // TextSpan(
                                                  //   text: 'yrs',
                                                  //   style: TextStyle(
                                                  //     fontSize: 20,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: ClipOval(
                                      child: Material(
                                        color: Color.fromRGBO(
                                            220, 229, 228, 1), // Button color
                                        child: InkWell(
                                          splashColor: Color.fromRGBO(
                                              120, 158, 156, 1), // Splash color
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.all(2),
                                            child: SizedBox(
                                              width: screenWidth * 0.075,
                                              height: screenWidth * 0.075,
                                              child: Icon(
                                                Icons.bloodtype,
                                                color: Color.fromRGBO(
                                                    252, 102, 123, 1),
                                                size: 20,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.065,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: screenWidth * 0.35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              isLangEnglish ? "HEIGHT" : "कद"),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Container(
                                            child: Text.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: Provider.of<SwasthyaMitraPatientPersonalDetails>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .paitentUserMapping[
                                                                'patient_Height'] ==
                                                            ""
                                                        ? "NA"
                                                        : "${Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping['patient_Height']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: Provider.of<SwasthyaMitraPatientPersonalDetails>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .paitentUserMapping[
                                                                  'patient_Height'] ==
                                                              ""
                                                          ? 30
                                                          : 20,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' cm',
                                                    style: TextStyle(
                                                      fontSize: 22.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: ClipOval(
                                      child: Material(
                                        color: Color.fromRGBO(
                                            220, 229, 228, 1), // Button color
                                        child: InkWell(
                                          splashColor: Color.fromRGBO(
                                            120,
                                            158,
                                            156,
                                            1,
                                          ), // Splash color
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.all(2),
                                            child: SizedBox(
                                              width: screenWidth * 0.075,
                                              height: screenWidth * 0.075,
                                              child: Icon(
                                                Icons.arrow_upward_rounded,
                                                color: Color.fromRGBO(
                                                  3,
                                                  192,
                                                  137,
                                                  1,
                                                ),
                                                size: 20,
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
                            Container(
                              width: screenWidth * 0.35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                              isLangEnglish ? "WEIGHT" : "वजन"),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Container(
                                            child: Text.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: Provider.of<SwasthyaMitraPatientPersonalDetails>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .paitentUserMapping[
                                                                'patient_Weight'] ==
                                                            ""
                                                        ? "NA"
                                                        : "${Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping['patient_Weight']}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' Kg',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: ClipOval(
                                      child: Material(
                                        color: Color.fromRGBO(
                                          220,
                                          229,
                                          228,
                                          1,
                                        ), // Button color
                                        child: InkWell(
                                          splashColor: Color.fromRGBO(
                                            120,
                                            158,
                                            156,
                                            1,
                                          ), // Splash color
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.all(2),
                                            child: SizedBox(
                                              width: screenWidth * 0.075,
                                              height: screenWidth * 0.075,
                                              child: Icon(
                                                Icons.line_weight,
                                                color: Color.fromRGBO(
                                                  255,
                                                  161,
                                                  106,
                                                  1,
                                                ),
                                                size: 20,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: screenHeight * 0.04,
          // ),
          // Align(
          //   child: Container(
          //     width: screenWidth * 0.9,
          //     child: ElevatedButton.icon(
          //       onPressed: () {
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) => MessageChattingScreen(
          //               3,
          //               widget.tokenInfo,
          //             ),
          //           ),
          //         );
          //       },
          //       icon: Icon(
          //         Icons.message_rounded,
          //         // size: screenWidth * 0.075,
          //       ),
          //       label: Text(
          //         isLangEnglish ? "CHAT" : "बात करना",
          //         style: TextStyle(
          //           color: Colors.white,
          //         ),
          //       ),
          //       style: ElevatedButton.styleFrom(
          //         primary: Color.fromRGBO(66, 204, 195, 1),
          //         padding: EdgeInsets.symmetric(
          //           vertical: screenHeight * 0.015,
          //           horizontal: screenWidth * 0.075,
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(7.5),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // isBookedSlotAvailable
          //     ? Align(
          //         child: Container(
          //           width: screenWidth * 0.9,
          //           child: ElevatedButton.icon(
          //             onPressed: () {
          //               Navigator.of(context).push(
          //                 MaterialPageRoute(
          //                   builder: (context) => MessageChattingScreen(
          //                     3,
          //                     widget.tokenInfo,
          //                   ),
          //                 ),
          //               );
          //             },
          //             icon: Icon(
          //               Icons.message_rounded,
          //               // size: screenWidth * 0.075,
          //             ),
          //             label: Text(
          //               isLangEnglish ? "CHAT" : "बात करना",
          //               style: TextStyle(
          //                 color: Colors.white,
          //               ),
          //             ),
          //             style: ElevatedButton.styleFrom(
          //               primary: Color.fromRGBO(66, 204, 195, 1),
          //               padding: EdgeInsets.symmetric(
          //                 vertical: screenHeight * 0.015,
          //                 horizontal: screenWidth * 0.075,
          //               ),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(7.5),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     : SizedBox(
          //         height: 0,
          //       ),
          // SizedBox(
          //   height: screenHeight * 0.025,
          // ),
          // Align(
          //   child: Container(
          //     width: screenWidth * 0.9,
          //     child: ElevatedButton.icon(
          //       onPressed: () {
          //         Navigator.of(context).push(
          //           MaterialPageRoute(
          //             builder: (context) => DoctorNewPrescriptionScreen(
          //               3,
          //               widget.tokenInfo,
          //             ),
          //           ),
          //         );
          //       },
          //       icon: Icon(
          //         Icons.new_label,
          //         // size: screenWidth * 0.075,
          //       ),
          //       label: Text(
          //         isLangEnglish ? "NEW PRESCRIPTION" : "नया नुस्खा",
          //         style: TextStyle(
          //           color: Colors.white,
          //         ),
          //       ),
          //       style: ElevatedButton.styleFrom(
          //         primary: Color.fromRGBO(
          //           66,
          //           154,
          //           204,
          //           1,
          //         ),
          //         padding: EdgeInsets.symmetric(
          //           vertical: screenHeight * 0.015,
          //           horizontal: screenWidth * 0.075,
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(7.5),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: screenHeight * 0.035,
          ),
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
                horizontal: screenWidth * 0.015,
              ),
              width: screenWidth * 0.9,
              alignment: Alignment.centerLeft,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.file_copy_rounded,
                        size: screenWidth * 0.055,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.035,
                    ),
                    Container(
                      child: Text(
                        isLangEnglish ? "Your Prescription" : "आपका नुस्खा",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          futureFilesDocPres.toString() == null
              ? Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      isLangEnglish
                          ? "No prescription uploaded from the doctor"
                          : "चिकित्सक की ओर से कोई प्रिस्क्रिप्शन अपलोड नहीं किया गया",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                )
              : Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: prescriptionSize * 0.65,
                    child: Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 0.5,
                          color: Color.fromRGBO(242, 242, 242, 1),
                        ),
                      ),
                      child: Container(
                        child: FutureBuilder<ListResult>(
                          future: futureFilesDocPres,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // print("hasData");
                              final files = snapshot.data!.items;

                              if (files.isEmpty) {
                                return Center(
                                  child: Container(
                                    child: Text(
                                      isLangEnglish
                                          ? "No prescription uploaded from the doctor"
                                          : "चिकित्सक की ओर से कोई प्रिस्क्रिप्शन अपलोड नहीं किया गया",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                physics: ScrollPhysics(),
                                itemCount: files.length,
                                itemBuilder: (context, index) {
                                  final file = files[index];
                                  double? progress = downloadProgress[index];

                                  return ListTile(
                                    title: Text(
                                      file.name,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    subtitle: progress != null
                                        ? LinearProgressIndicator(
                                            value: progress,
                                            backgroundColor: Colors.black,
                                          )
                                        : null,
                                    trailing: IconButton(
                                      onPressed: () =>
                                          downloadFiles(file, index),
                                      icon: Icon(
                                        Icons.download,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              // print("hasError");
                              return Container(
                                child: Center(
                                  child: Text(isLangEnglish
                                      ? "Error occoured"
                                      : "त्रुटि हुई"),
                                ),
                              );
                            } else {
                              // print("else");
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
                horizontal: screenWidth * 0.015,
              ),
              width: screenWidth * 0.9,
              alignment: Alignment.centerLeft,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.file_present_outlined,
                        size: screenWidth * 0.065,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.035,
                    ),
                    Container(
                      child: Text(
                        isLangEnglish
                            ? "Prescriptions and Reports"
                            : "नुस्खे और रिपोर्ट",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          futureFiles.toString() == null
              ? Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      isLangEnglish
                          ? "No previous prescription uploaded by the patient"
                          : "मेरीज द्वारा कोई पिछला प्रिस्क्रिप्शन अपलोड नहीं किया गया",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                )
              : Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: prescriptionSize * 0.75,
                    child: Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 0.5,
                          color: Color.fromRGBO(242, 242, 242, 1),
                        ),
                      ),
                      child: Container(
                        child: FutureBuilder<ListResult>(
                          future: futureFiles,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // print("hasData");
                              final files = snapshot.data!.items;

                              if (files.isEmpty) {
                                return Center(
                                  child: Container(
                                    child: Text(
                                      isLangEnglish
                                          ? "No previous prescription uploaded by the patient"
                                          : "मेरीज द्वारा कोई पिछला प्रिस्क्रिप्शन अपलोड नहीं किया गया",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: screenWidth * 0.055,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                physics: ScrollPhysics(),
                                itemCount: files.length,
                                itemBuilder: (context, index) {
                                  final file = files[index];
                                  double? progress = downloadProgress[index];

                                  return ListTile(
                                    title: Text(
                                      file.name,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    subtitle: progress != null
                                        ? LinearProgressIndicator(
                                            value: progress,
                                            backgroundColor: Colors.black,
                                          )
                                        : null,
                                    trailing: IconButton(
                                      onPressed: () =>
                                          downloadFiles(file, index),
                                      icon: Icon(
                                        Icons.download,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              // print("hasError");
                              return Container(
                                child: Center(
                                  child: Text(isLangEnglish
                                      ? "Error occoured"
                                      : "त्रुटि हुई"),
                                ),
                              );
                            } else {
                              // print("else");
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
                horizontal: screenWidth * 0.015,
              ),
              width: screenWidth * 0.9,
              alignment: Alignment.centerLeft,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.medication_outlined,
                        size: screenWidth * 0.055,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.035,
                    ),
                    Container(
                      child: Text(
                        isLangEnglish ? "Previous Medications" : "पिछली दवाएं",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01,
                horizontal: screenWidth * 0.025,
              ),
              width: screenWidth * 0.9,
              child: Text(
                Provider.of<SwasthyaMitraPatientPersonalDetails>(context,
                                listen: false)
                            .paitentUserMapping['patient_Medication'] ==
                        ""
                    ? isLangEnglish
                        ? "▶️ No previous medication available"
                        : "▶️ कोई पिछली दवा उपलब्ध नहीं है"
                    : "▶️ ${Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping['patient_Medication']}",
              ),
            ),
          ),
          Align(
            child: Center(
              child: Container(
                width: screenWidth * 0.85,
                child: Divider(
                  color: Colors.black,
                  thickness: 0.5,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
                horizontal: screenWidth * 0.015,
              ),
              width: screenWidth * 0.9,
              alignment: Alignment.centerLeft,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.personal_injury_rounded,
                        size: screenWidth * 0.055,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.035,
                    ),
                    Container(
                      child: Text(
                        isLangEnglish ? "Previous Injuries" : "पिछली चोटें",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01,
                horizontal: screenWidth * 0.025,
              ),
              width: screenWidth * 0.9,
              child: Text(
                Provider.of<SwasthyaMitraPatientPersonalDetails>(context,
                                listen: false)
                            .paitentUserMapping['patient_Medication'] ==
                        ""
                    ? isLangEnglish
                        ? "▶️ No previous injuries available"
                        : "▶️ कोई पिछली चोट उपलब्ध नहीं है"
                    : "▶️ ${Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping['patient_Injuries']}",
              ),
            ),
          ),
          Align(
            child: Center(
              child: Container(
                width: screenWidth * 0.85,
                child: Divider(
                  color: Colors.black,
                  thickness: 0.5,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
                horizontal: screenWidth * 0.015,
              ),
              width: screenWidth * 0.9,
              alignment: Alignment.centerLeft,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.emergency_rounded,
                        size: screenWidth * 0.055,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.035,
                    ),
                    Container(
                      child: Text(
                        isLangEnglish ? "Previous Surgeries" : "पिछली सर्जरी",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.01,
                horizontal: screenWidth * 0.025,
              ),
              width: screenWidth * 0.9,
              child: Text(
                Provider.of<SwasthyaMitraPatientPersonalDetails>(context,
                                listen: false)
                            .paitentUserMapping['patient_Medication'] ==
                        ""
                    ? isLangEnglish
                        ? "▶️ No previous surgeries available"
                        : "▶️ कोई पिछली सर्जरी उपलब्ध नहीं है"
                    : "▶️ ${Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).paitentUserMapping['patient_Surgeries']}",
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.065,
          ),
        ],
      ),
    );
  }

  Future<void> downloadFiles(Reference ref, int index) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    final url = await ref.getDownloadURL();

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(url, path, onReceiveProgress: (received, total) {
      double progress = received / total;

      setState(() {
        downloadProgress[index] = progress;
      });
    });

    if (url.contains('.mp4')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    } else if (url.contains('.pdf')) {
      openPrescription(context, url.toString());
    } else if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }
  }

  Future<void> openPrescription(
    BuildContext context,
    String url,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            width: screenWidth * 0.9,
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: isLangEnglish ? "Link: " : "लिंक: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "Press to view",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Failed';
                        }
                      },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String convertTimeOfDayToStringTime(TimeOfDay slotTime) {
    String givenTime = slotTime.toString();
    String ans = givenTime.split("(")[1].substring(10, givenTime.length - 1);
    String ansFmt = "${ans.split(":")[0]}-${ans.split(":")[1]}";

    return ansFmt;
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
            tooltip: "OK",
          ),
        ],
      ),
    );
  }

  int checkIfInteger(String val) {
    if (val == 'null' || val == '' || int.tryParse(val).toString() == 'null') {
      return 0;
    } else {
      return int.parse(val);
    }
  }

  double checkIfDouble(String val) {
    if (val == 'null' ||
        val == '' ||
        double.tryParse(val).toString() == 'null') {
      return 0.0;
    } else {
      return double.parse(val);
    }
  }
}
