// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, unused_import, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unused_element, duplicate_import, must_be_immutable

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
import '../../providers/doctorCalendar_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';

class ViewPatientPrescription extends StatefulWidget {
  static const routeName = '/patient-view-booked-token-detail-screen';

  int pageIndex;
  BookedTokenSlotInformation tokenInfo;

  ViewPatientPrescription(
    this.pageIndex,
    this.tokenInfo,
  );

  @override
  State<ViewPatientPrescription> createState() =>
      _ViewPatientPrescriptionState();
}

class _ViewPatientPrescriptionState extends State<ViewPatientPrescription> {
  bool isLangEnglish = true;

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
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: screenWidth * 0.9,
            height: screenHeight * 0.9,
            child: Text( isLangEnglish ?
              'No prescription uploaded by the doctor':
              'डॉक्टर ने कोई प्रिस्क्रिप्शन अपलोड नहीं किया',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
