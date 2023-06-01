// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, duplicate_import, unused_local_variable, must_be_immutable

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

class MessageBubble extends StatelessWidget {
  final String textMessage;
  final bool isMe;
  final Key key;
  String patientName;
  String doctorName;
  final Timestamp messageTS;

  MessageBubble(
    this.textMessage,
    this.isMe,
    this.key,
    this.messageTS,
    this.patientName,
    this.doctorName,
  );

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var avlScreenHeight = screenHeight - topInsets - bottomInsets;

    return Column(
      // mainAxisAlignment: !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment:
          !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          width: screenWidth * 0.5,
          decoration: BoxDecoration(
            color: isMe
                ? Color.fromRGBO(66, 204, 171, 1)
                : Color.fromRGBO(66, 197, 204, 1),
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(10),
                  ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            textMessage,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );

    // return Expanded(
    //   child: Column(
    //     mainAxisAlignment:
    //         !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
    //     children: [
    //       // Container(
    //       //   child: Text(
    //       //     doctorName,
    //       //     style: TextStyle(
    //       //       fontWeight: FontWeight.bold,
    //       //       color: Colors.white,
    //       //     ),
    //       //   ),
    //       // ),
    //       Expanded(
    //         child: Container(
    //           width: screenWidth * 0.5,
    //           decoration: BoxDecoration(
    //             color: isMe
    //                 ? Color.fromRGBO(66, 204, 171, 1)
    //                 : Color.fromRGBO(66, 197, 204, 1),
    //             borderRadius: isMe
    //                 ? BorderRadius.only(
    //                     bottomLeft: Radius.circular(10),
    //                     bottomRight: Radius.circular(10),
    //                     topLeft: Radius.circular(10),
    //                     topRight: Radius.circular(0),
    //                   )
    //                 : BorderRadius.only(
    //                     bottomLeft: Radius.circular(10),
    //                     bottomRight: Radius.circular(10),
    //                     topLeft: Radius.circular(0),
    //                     topRight: Radius.circular(10),
    //                   ),
    //           ),
    //           padding: EdgeInsets.symmetric(
    //             vertical: 10,
    //             horizontal: 16,
    //           ),
    //           margin: EdgeInsets.symmetric(
    //             vertical: 4,
    //             horizontal: 8,
    //           ),
    //           child: Text(
    //             textMessage,
    //             style: TextStyle(
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //       ),
    //       // Container(
    //       //   child: Text(
    //       //     DateTime.fromMicrosecondsSinceEpoch(messageTS).toString(),
    //       //   ),
    //       // ),
    //     ],
    //   ),
    // );
  }
}
