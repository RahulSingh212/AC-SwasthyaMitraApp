// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, duplicate_import, unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_list.dart';
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

import '../../Jitsi_meet.dart';
import '../../models/token_info.dart';
import '../../providers/patientUser_details.dart';
import './message_bubble.dart';

class MessageBox extends StatefulWidget {
  String link;
  BookedTokenSlotInformation tokenInfo;

  MessageBox(this.link, this.tokenInfo);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  bool isLangEnglish = true;
  String puid = "";
  String pName = "";

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
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    // final loggedInUserId = await FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('${widget.link}').add(
      {
        'text':
            isLangEnglish ? 'Joined the meet' : 'बैठक में शामिल हो गया हूं।',
        // 'text': "https://meet.jit.si/${puid}-${widget.tokenInfo.doctor_personalUniqueIdentificationId}-${widget.tokenInfo.registeredTokenId}",
        'createdAt': Timestamp.now(),
        'patientUserId': Provider.of<PatientUserDetails>(context, listen: false)
                .getPatientUserPersonalInformation()[
            "patient_personalUniqueIdentificationId"],
        'doctorUserId': '',
      },
    );
  }

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
          String patientName =
              Provider.of<PatientUserDetails>(context, listen: false)
                  .mp["patient_FullName"]
                  .toString();
          String notificationTitle = "Patient: $patientName joined the meet";
          String notificationBody =
              "Appointment is scheduled for ${widget.tokenInfo.bookedTokenTime.format(context).toString()}";

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
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var avlScreenHeight = screenHeight - topInsets - bottomInsets;

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;

    String patientFullName =
        Provider.of<PatientUserDetails>(context, listen: false)
                .getPatientUserPersonalInformation()["patient_FullName"] ??
            "";
    String doctorFullName = widget.tokenInfo.doctorFullName;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        centerTitle: false,
        title: Row(
          children: <Widget>[
            Container(
              height: screenWidth * 0.085,
              width: screenWidth * 0.085,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
              ),
              child: CircleAvatar(
                radius: screenWidth * 0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    screenWidth * 0.6,
                  ),
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: widget.tokenInfo.doctorImageUrl == ""
                          ? Image.asset(
                              "assets/images/uProfile.png",
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
            SizedBox(
              width: screenWidth * 0.03,
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                width: screenWidth * 0.35,
                child: Text(
                  widget.tokenInfo.doctorFullName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              Container(
                child: IconButton(
                  onPressed: () {
                    String roomText =
                        "${puid}-${widget.tokenInfo.doctor_personalUniqueIdentificationId}";
                    String subjectText = isLangEnglish
                        ? "Appointment with patient"
                        : "रोगी के साथ नियुक्ति";
                    String userDisplayNameText = pName;
                    String userEmailText = "user@gmail.com";

                    getDoctorMobileToken(
                        widget.tokenInfo.doctor_personalUniqueIdentificationId);
                    joinMeeting(
                      roomText,
                      subjectText,
                      userDisplayNameText,
                      userEmailText,
                    );
                    // _sendMessage();
                  },
                  icon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.01,
              ),
              Container(
                child: IconButton(
                  onPressed: () {
                    String roomText =
                        "${puid}-${widget.tokenInfo.doctor_personalUniqueIdentificationId}";
                    String subjectText = isLangEnglish
                        ? "Appointment with patient"
                        : "रोगी के साथ नियुक्ति";
                    String userDisplayNameText = pName;
                    String userEmailText = "user@gmail.com";

                    getDoctorMobileToken(
                        widget.tokenInfo.doctor_personalUniqueIdentificationId);

                    joinMeeting(
                      roomText,
                      subjectText,
                      userDisplayNameText,
                      userEmailText,
                    );
                    // _sendMessage();
                  },
                  icon: Icon(
                    Icons.video_call,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.01,
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('${widget.link}')
            .orderBy(
              'createdAt',
              descending: true,
            )
            .snapshots(),
        builder: (BuildContext ctx, AsyncSnapshot streamSnapShot) {
          if (streamSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final chatDocs = streamSnapShot.data.docs;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) {
                // return Container(
                //   child: Text(
                //     chatDocs[index]['text'],
                //   ),
                // );
                return MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['patientUserId'] ==
                      Provider.of<PatientUserDetails>(context, listen: false)
                              .getPatientUserPersonalInformation()[
                          "patient_personalUniqueIdentificationId"],
                  ValueKey(
                    chatDocs[index],
                  ),
                  chatDocs[index]['createdAt'],
                  patientFullName,
                  doctorFullName,
                );
              },
            );
          }
        },
      ),
    );
  }
}
