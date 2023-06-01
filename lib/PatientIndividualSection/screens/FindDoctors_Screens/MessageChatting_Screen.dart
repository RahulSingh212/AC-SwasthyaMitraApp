// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, duplicate_import, must_be_immutable

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
import '../../models/token_info.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';

import '../../myWidgets/LinearFlowWidget.dart';
import '../../myWidgets/chat/message.dart';
import '../../myWidgets/chat/new_message.dart';
import '../../providers/patientUser_details.dart';

class MessageChattingScreen extends StatefulWidget {
  static const routeName = '/patient-chat-message-screen';

  int pageIndex;
  BookedTokenSlotInformation tokenInfo;

  MessageChattingScreen(
    this.pageIndex,
    this.tokenInfo,
  );

  @override
  State<MessageChattingScreen> createState() => _MessageChattingScreenState();
}

class _MessageChattingScreenState extends State<MessageChattingScreen> {
  // var loggedInUserId = Provider.of<PatientUserDetails>(context);

  // FirebaseFirestore db = FirebaseFirestore.instance;
  // CollectionReference usersRef = db.collection("PatientChatMessages/${loggedInUserId}");

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var avlScreenHeight = screenHeight - topInsets - bottomInsets;

    String link = "ChatTextMessages/${Provider.of<PatientUserDetails>(context, listen: false).getPatientUserPersonalInformation()["patient_personalUniqueIdentificationId"]}/${widget.tokenInfo.doctor_personalUniqueIdentificationId}";
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 229, 229, 1),
      body: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: Column(
          children: <Widget>[
            Expanded(
              child: MessageBox(
                link,
                widget.tokenInfo,
              ),
            ),
            NewMessage(
              link,
              widget.tokenInfo,
            ),
          ],
        ),
      ),
    );
  }
}
