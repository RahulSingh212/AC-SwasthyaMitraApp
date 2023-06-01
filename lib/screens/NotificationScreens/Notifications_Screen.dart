// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, unused_field, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_import, avoid_unnecessary_containers, unused_local_variable, import_of_legacy_library_into_null_safe, prefer_final_fields, use_key_in_widget_constructors

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/providers/SM_User_Details.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-notifications-screen';

  @override
  State<NotificationScreenSwasthyaMitra> createState() =>
      _NotificationScreenSwasthyaMitraState();
}

class _NotificationScreenSwasthyaMitraState
    extends State<NotificationScreenSwasthyaMitra> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2f3f4),
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          enableFeedback: false,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Color(0xff42ccc3),
            size: 35,
          ),
        ),
        title: Text(
          isLangEnglish ? "Notifications" : "सूचनाएं",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(),
    );
  }
}
