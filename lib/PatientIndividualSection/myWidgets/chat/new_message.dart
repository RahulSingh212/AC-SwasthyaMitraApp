// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, unused_import, duplicate_import, must_be_immutable

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
import '../../providers/patientUser_details.dart';

class NewMessage extends StatefulWidget {
  String link;
  BookedTokenSlotInformation tokenInfo;

  NewMessage(this.link, this.tokenInfo);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  bool isLangEnglish = true;
  final _controller = new TextEditingController();
  String _enteredMessage = "";

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    // final loggedInUserId = await FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance.collection('${widget.link}').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'patientUserId': Provider.of<PatientUserDetails>(context, listen: false)
              .getPatientUserPersonalInformation()[
          "patient_personalUniqueIdentificationId"],
      'doctorUserId': '',
    });

    setState(() {
      _controller.clear();
      _enteredMessage = "";
    });
  }

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var avlScreenHeight = screenHeight - topInsets - bottomInsets;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(500),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.005,
        ),
        // margin: EdgeInsets.only(
        //   top: screenHeight * 0.01,
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Row(
          children: <Widget>[
            // Container(
            //   width: screenWidth * 0.1,
            //   height: screenWidth * 0.1,
            //   alignment: Alignment.center,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(1000),
            //     // color: Color.fromRGBO(66, 204, 195, 0.25),
            //   ),
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       // Icons.arrow_forward_ios_sharp,
            //       Icons.emoji_emotions_outlined,
            //       color: Color.fromRGBO(66, 204, 195, 1),
            //     ),
            //   ),
            // ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: isLangEnglish
                      ? 'Type your message...'
                      : "अपना संदेश टाइप करें...",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: screenWidth * 0.015,
            ),
            _enteredMessage.trim().isEmpty
                ? SizedBox(
                    width: 0,
                  )
                : Container(
                    width: screenWidth * 0.1,
                    height: screenWidth * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: Color.fromRGBO(66, 204, 195, 0.25),
                    ),
                    child: IconButton(
                      onPressed:
                          _enteredMessage.trim().isEmpty ? null : _sendMessage,
                      // splashColor: Colors.grey,
                      icon: Icon(
                        // Icons.arrow_forward_ios_sharp,
                        Icons.send_rounded,
                        color: Color.fromRGBO(66, 204, 195, 1),
                      ),
                    ),
                  ),
            // _enteredMessage.trim().isEmpty
            //     ? Container(
            //         width: screenWidth * 0.1,
            //         height: screenWidth * 0.1,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(1000),
            //           // color: Color.fromRGBO(66, 204, 195, 0.25),
            //         ),
            //         child: IconButton(
            //           onPressed: () {},
            //           icon: Icon(
            //             Icons.attach_file_outlined,
            //             color: Color.fromRGBO(66, 204, 195, 1),
            //           ),
            //         ),
            //       )
            //     : SizedBox(
            //         width: 0,
            //       ),
            // _enteredMessage.trim().isEmpty
            //     ? Container(
            //         width: screenWidth * 0.1,
            //         height: screenWidth * 0.1,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(1000),
            //           // color: Color.fromRGBO(66, 204, 195, 0.25),
            //         ),
            //         child: IconButton(
            //           onPressed: () {},
            //           icon: Icon(
            //             // Icons.arrow_forward_ios_sharp,
            //             Icons.camera_alt_rounded,
            //             color: Color.fromRGBO(66, 204, 195, 1),
            //           ),
            //         ),
            //       )
            //     : SizedBox(
            //         width: 0,
            //       ),
          ],
        ),
      ),
    );
  }
}
