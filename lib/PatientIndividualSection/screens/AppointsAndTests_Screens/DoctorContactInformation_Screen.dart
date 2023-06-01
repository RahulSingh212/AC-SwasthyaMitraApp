// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_brace_in_string_interps, unused_import, duplicate_import, must_be_immutable, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

import '../../Helper/constants.dart';
import '../../Jitsi_meet.dart';
import '../../models/token_info.dart';

import '../../providers/doctorCalendar_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';
import '../FindDoctors_Screens/MessageChatting_Screen.dart';

class ContactDoctorInformationScreen extends StatefulWidget {
  static const routeName = '/patient-contact-doctor-information-screen';

  int pageIndex;
  BookedTokenSlotInformation tokenInfo;

  ContactDoctorInformationScreen(
    this.pageIndex,
    this.tokenInfo,
  );

  @override
  State<ContactDoctorInformationScreen> createState() =>
      _ContactDoctorInformationScreenState();
}

class _ContactDoctorInformationScreenState
    extends State<ContactDoctorInformationScreen> {
  bool isLangEnglish = true;
  String puid = "";
  String pName = "";
  String link = "";

  void getDoctorMobileToken(String doctorUserId) async {
    String doctorMobileToken = "";

    var response = await FirebaseFirestore.instance
        .collection('DoctorUsersPersonalInformation')
        .doc(doctorUserId)
        .get()
        .then(
      (DocumentSnapshot ds) {
        doctorMobileToken = ds.get('doctor_MobileMessagingTokenId').toString();

        if (doctorMobileToken != "") {
          String patientName = Provider.of<PatientUserDetails>(context, listen: false)
          .mp["patient_FullName"]
          .toString();
          String notificationTitle = "Patient: $patientName joined the meet";
          String notificationBody = "Appointment is scheduled for ${widget.tokenInfo.bookedTokenTime.format(context).toString()}";
          sendPushMessage(
            doctorMobileToken,
            notificationBody,
            notificationTitle,
          );
        }
      },
    );
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAJf9Zzxw:APA91bG2byLOz03IcaNF5kfF9jeEj9hudr-VbWCNfBBuGdi6GYToR_rutgKIynxNfeNjKzSBC2JFMZ1xX_e6wVBgL-5yihEtdxcMWMshW8fggjQRxyBuR5QabafIUBpC3iAA9gpHxzSG',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              'title': title,
              "body": body,
              "android_channel_id": "aurigaCare",
            },
            "to": token,
          },
        ),
      );
    } catch (errorVal) {}
  }

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;

    puid = Provider.of<PatientUserDetails>(context, listen: false)
            .mp['patient_personalUniqueIdentificationId'] ??
        "";
    pName = Provider.of<PatientUserDetails>(context, listen: false)
            .mp['patient_FullName'] ??
        "";

    link =
        "ChatTextMessages/${Provider.of<PatientUserDetails>(context, listen: false).getPatientUserPersonalInformation()["patient_personalUniqueIdentificationId"]}/${widget.tokenInfo.doctor_personalUniqueIdentificationId}";
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    // final loggedInUserId = await FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('${link}').add({
      'text': isLangEnglish ? 'Joined the meet' : 'बैठक में शामिल हो गया हूं।',
      'createdAt': Timestamp.now(),
      'patientUserId': puid,
      'doctorUserId': '',
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(66, 204, 195, 1),
            ),
            padding: EdgeInsets.only(top: screenHeight * 0.0175),
            child: Column(
              children: <Widget>[
                Container(
                  width: screenWidth,
                  child: Align(
                    child: Container(
                      width: screenWidth * 0.925,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 0.08055 * _width / 2,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: AppColors.AppmainColor,
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   child: Icon(
                          //     Icons.library_add_outlined,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.925,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: screenWidth * 0.275,
                          width: screenWidth * 0.275,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.011111 * _width,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: CircleAvatar(
                            radius: screenWidth * 0.6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.2,
                              ),
                              child: ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: widget.tokenInfo.doctorImageUrl == ""
                                      ? Image.asset(
                                          "assets/images/healthy.png",
                                        )
                                      : Image.network(
                                          widget.tokenInfo.doctorImageUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                child: Text(
                                  widget.tokenInfo.doctorFullName
                                          .toLowerCase()
                                          .startsWith("dr")
                                      ? widget.tokenInfo.doctorFullName
                                      : "Dr. ${widget.tokenInfo.doctorFullName}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.05,
                                    color: Colors.white,
                                  ),
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 0.01534 * _height,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(
                                  left: 0.013888 * _width,
                                  top: 0.006393 * _height,
                                  bottom: 0.006393 * _height,
                                  right: 0.013888 * _width,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Container(
                                      width: screenWidth * 0.5,
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.AppmainColor,
                                        ),
                                        child: Text(
                                          "${widget.tokenInfo.doctorSpeciality}",
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0.011508 * _height,
                              ),
                              widget.tokenInfo.doctorTotalRatings == 0.0
                                  ? SizedBox(
                                      height: 0,
                                    )
                                  : DefaultTextStyle(
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        "${widget.tokenInfo.doctorTotalRatings.toString()} ${isLangEnglish ? "Ratings" : "रेटिंग्स"}",
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.0175,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: <TextSpan>[
                    // TextSpan(
                    //   text: widget.tokenInfo.doctorFullName
                    //           .toLowerCase()
                    //           .startsWith("dr")
                    //       ? widget.tokenInfo.doctorFullName
                    //       : "Dr. ${widget.tokenInfo.doctorFullName}",
                    //   style: TextStyle(
                    //     color: Color(0xff929292),
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 17.5,
                    //     decorationThickness: 0,
                    //     decorationStyle: TextDecorationStyle.solid,
                    //     textBaseline: TextBaseline.alphabetic,
                    //     letterSpacing: 1,
                    //     wordSpacing: 0,
                    //     fontStyle: FontStyle.normal,
                    //   ),
                    // ),
                    TextSpan(
                      text: isLangEnglish
                          ? 'A trained and well experienced medical practitioner in the field '
                          : 'क्षेत्र में एक प्रशिक्षित और अच्छी तरह से अनुभवी चिकित्सक ',
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // TextSpan(
                    //   text:
                    //       '${widget.tokenInfo.doctor} years',
                    //   style: TextStyle(
                    //     color: Color(0xff929292),
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: 17.5,
                    //   ),
                    // ),
                    TextSpan(
                      text: isLangEnglish
                          ? ' with major expertise in '
                          : ' में प्रमुख विशेषज्ञता के साथ ',
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '${widget.tokenInfo.doctorSpeciality}.',
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: isLangEnglish
                          ? 'Appointment with '
                          : 'इनके साथ अपॉइंटमेंट ',
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: widget.tokenInfo.doctorFullName
                              .toLowerCase()
                              .startsWith("dr")
                          ? widget.tokenInfo.doctorFullName
                          : "Dr. ${widget.tokenInfo.doctorFullName}",
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        decorationThickness: 0,
                        decorationStyle: TextDecorationStyle.solid,
                        textBaseline: TextBaseline.alphabetic,
                        letterSpacing: 1,
                        wordSpacing: 0,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    TextSpan(
                      text: isLangEnglish
                          ? ' has been booked on: '
                          : ' पर बुक किया गया है: ',
                      style: TextStyle(
                        color: Color(0xff929292),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.035,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.015,
                vertical: screenWidth * 0.045,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Color.fromRGBO(205, 205, 205, 1),
                ),
                borderRadius: BorderRadius.circular(12.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.4,
                    child: Text(
                      "${widget.tokenInfo.bookedTokenTime.format(context)}",
                      style: TextStyle(
                        color: Color.fromRGBO(66, 204, 195, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.075,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.4,
                    child: Text(
                      "${DateFormat.MMMd().format(widget.tokenInfo.bookedTokenDate).toString()}",
                      style: TextStyle(
                        color: Color.fromRGBO(66, 204, 195, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.075,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.25,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: ClipOval(
                            child: Material(
                              color: Color.fromRGBO(
                                  255, 255, 255, 1), // Button color
                              child: InkWell(
                                splashColor: Color.fromRGBO(120, 158, 156, 1),
                                onTap: () {
                                  String roomText =
                                      "${puid}-${widget.tokenInfo.doctor_personalUniqueIdentificationId}";
                                  String subjectText = isLangEnglish
                                      ? "Appointment with patient"
                                      : "रोगी के साथ नियुक्ति";
                                  String userDisplayNameText = pName;
                                  String userEmailText = "user@gmail.com";

                                  getDoctorMobileToken(widget.tokenInfo.doctor_personalUniqueIdentificationId);
                                  joinMeeting(roomText, subjectText,
                                      userDisplayNameText, userEmailText);
                                  // _sendMessage();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 249, 247, 247),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    width: screenWidth * 0.15,
                                    height: screenWidth * 0.15,
                                    child: Icon(
                                      Icons.phone_outlined,
                                      size: screenWidth * 0.1125,
                                      color: Color.fromRGBO(66, 204, 195, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.0125,
                        ),
                        Container(
                          child: Text(
                            isLangEnglish ? "Voice Call" : "आवाज कॉल",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        String roomText =
                            "${puid}-${widget.tokenInfo.doctor_personalUniqueIdentificationId}";
                        String subjectText = isLangEnglish
                            ? "Appointment with patient"
                            : "रोगी के साथ नियुक्ति";
                        String userDisplayNameText = pName;
                        String userEmailText = "user@gmail.com";

                        getDoctorMobileToken(widget.tokenInfo.doctor_personalUniqueIdentificationId);
                        joinMeeting(roomText, subjectText, userDisplayNameText,
                            userEmailText);
                        // _sendMessage();
                      },
                      icon: Icon(
                        Icons.video_call_outlined,
                        // size: screenWidth * 0.075,
                      ),
                      label: Text(
                        isLangEnglish ? "Video Call" : "वीडियो कॉल",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(66, 204, 195, 1),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.025,
                          horizontal: screenWidth * 0.075,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(75),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: ClipOval(
                            child: Material(
                              color: Color.fromRGBO(
                                  255, 255, 255, 1), // Button color
                              child: InkWell(
                                splashColor: Color.fromRGBO(
                                    120, 158, 156, 1), // Splash color
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MessageChattingScreen(
                                        2,
                                        widget.tokenInfo,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 249, 247, 247),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    width: screenWidth * 0.15,
                                    height: screenWidth * 0.15,
                                    child: Icon(
                                      Icons.message_outlined,
                                      size: screenWidth * 0.1125,
                                      color: Color.fromRGBO(66, 204, 195, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.0125,
                        ),
                        Container(
                          child: Text(
                            isLangEnglish ? "Message" : "सूचना",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
