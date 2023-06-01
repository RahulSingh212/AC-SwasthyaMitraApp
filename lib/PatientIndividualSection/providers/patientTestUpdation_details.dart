// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, await_only_futures, unnecessary_brace_in_string_interps, unnecessary_new, unnecessary_string_interpolations, duplicate_import, unused_import, prefer_const_constructors

import 'dart:async';
import 'dart:collection';
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
import 'package:swasthyamitra/PatientIndividualSection/providers/patientUser_details.dart';
import 'package:swasthyamitra/providers/SM_User_Details.dart';

import '../../models/patient_Info.dart';
import '../../providers/SM_FirebaseLinks_Details.dart';
import '../models/doctor_Info.dart';
import '../models/slot_info.dart';

class PatientTestAppointmentUpdationDetails with ChangeNotifier {
  Future<void> savePatientTestSlot(
    BuildContext context,
    String testType,
    String visitedType,
    DateTime choosenTestDate,
    TimeOfDay choosendSlotTime,
    String patientAilmentDescription,
    String patientAddress,
  ) async {
    String tokenId = "";
    String smUniqueId =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .mp["SwasthyaMitra_personalUniqueIdentificationId"]
            .toString();
    String smCenterName =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .mp["SwasthyaMitra_CenterName"]
            .toString();
    String patientUniqueId =
        Provider.of<PatientUserDetails>(context, listen: false)
            .patientDetails
            .patient_personalUniqueIdentificationId;
    String patientFullName =
        Provider.of<PatientUserDetails>(context, listen: false)
            .patientDetails
            .patient_FullName;

    String swasthyaMitraSideUrl = "SwasthyaMitraBookedTestsList/${smUniqueId}";
    String patientSideUrl = "PatientBookedTestsList/${patientUniqueId}";

    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    Uri swasthyaMitraUrlLink =
        Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false)
            .getFirebasePathUrl('/${swasthyaMitraSideUrl}.json');

    Uri patientUrlLink =
        Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false)
            .getFirebasePathUrl('/${patientSideUrl}.json');

    final responseForSMTestApt = await http
        .post(
      swasthyaMitraUrlLink,
      body: json.encode(
        {
          'registeredTokenId': "",
          'appointmentDate': choosenTestDate.toString(),
          'appointmentTime': choosendSlotTime.toString(),
          'SwasthyaMitra_TestAppointmentUniqueId': "",
          // 'SwasthyaMitra_personalUniqueIdentificationId': smUniqueId.toString(),
          'isHomeAppointmentType':
              visitedType == "Home Visit" ? "true" : "false",
          'isCenterAppointmentType':
              visitedType == "Center Visit" ? "true" : "false",
          'isTokenActive': "true",
          'patientAilmentDescription': patientAilmentDescription.toString(),
          'patient_personalUniqueIdentificationId': patientUniqueId,
          'patientFullName': patientFullName,
          'patientAddress': patientAddress,
          'registrationTiming': DateTime.now().toString(),
          'testType': testType.toString(),
          'testReportUrl': "",
          'tokenTestFees': "",
        },
      ),
    )
        .then((smResponse) async {
      String SM_SideAppointmentUniqueId = json.decode(smResponse.body)["name"];
      tokenId = json.decode(smResponse.body)["name"];

      Uri urlLinkForUpdate = Provider.of<SwasthyaMitraFirebaseDetails>(context,
              listen: false)
          .getFirebasePathUrl(
              '/SwasthyaMitraBookedTestsList/${smUniqueId}/${json.decode(smResponse.body)["name"]}.json');

      final responseForPatientTokenDetails = await http
          .patch(
        urlLinkForUpdate,
        body: json.encode(
          {
            'registeredTokenId':
                json.decode(smResponse.body)["name"].toString(),
          },
        ),
      )
          .then((value) async {
        mDatabase
            .child("PatientBookedTestsList")
            .child("${patientUniqueId}")
            .child("${tokenId}")
            .update({
          'registeredTokenId': tokenId.toString(),
          'appointmentDate': choosenTestDate.toString(),
          'appointmentTime': choosendSlotTime.toString(),
          'SwasthyaMitra_TestAppointmentUniqueId': "",
          'SwasthyaMitra_personalUniqueIdentificationId': smUniqueId.toString(),
          'SwasthyaMitra_CenterName': smCenterName.toString(),
          'isHomeAppointmentType':
              visitedType == "Home Visit" ? "true" : "false",
          'isCenterAppointmentType':
              visitedType == "Center Visit" ? "true" : "false",
          'isTokenActive': "true",
          'patientAilmentDescription': patientAilmentDescription.toString(),
          'patientAddress': patientAddress,
          'registrationTiming': DateTime.now().toString(),
          'testType': testType.toString(),
          'testReportUrl': "",
          'tokenTestFees': "",
        }).then((value) {
          notifyListeners();
        });
      });
    });
  }
}
