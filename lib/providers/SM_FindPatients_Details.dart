// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, await_only_futures, unnecessary_brace_in_string_interps, duplicate_import, unused_import, avoid_print, unnecessary_new, avoid_function_literals_in_foreach_calls, unrelated_type_equality_checks

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
import 'package:swasthyamitra/providers/SM_User_Details.dart';

import '../models/patient_Info.dart';

class SwasthyaMitraFindPatientDetails with ChangeNotifier {
  List<PatientDetailsInformation> itemsPatientDetails = [];
  List<PatientDetailsInformation> itemsCompletePatientDetails = [];
  List<PatientDetailsInformation> itemsFilteredPatientDetails = [];

  List<PatientDetailsInformation> get getItemsPatientDetails {
    return [...itemsPatientDetails];
  }

  List<PatientDetailsInformation> get getItemsCompletePatientDetails {
    return [...itemsCompletePatientDetails];
  }

  List<PatientDetailsInformation> get getItemsSearchedPatientDetails {
    return [...itemsFilteredPatientDetails];
  }

  Future<void> clearAvailablePatientForAppointment(BuildContext context) async {
    this.itemsPatientDetails = [];
  }

  Future<void> fetchPatientsForSwasthyaMitraCenter(
    BuildContext context,
    Map<String, String> filteredList,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference dbRefPatientInfo = db.collection("PatientUsersPersonalInformation");

    // var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    // var loggedInUserId = currLoggedInUser?.uid as String;
    var loggedInUserId = Provider.of<SwasthyaMitraUserDetails>(context, listen: false).mp["SwasthyaMitra_personalUniqueIdentificationId"];

    try {
      List<PatientDetailsInformation> loadedPatientsForAppointment = [];
      db.collection('PatientUsersPersonalInformation').get().then(
        (ds) {
          ds.docs.forEach(
            (patientDetails) {
              var patientMap = HashMap.from(patientDetails.data());

              PatientDetailsInformation patientInfo = new PatientDetailsInformation(
                patient_personalUniqueIdentificationId: patientMap['patient_personalUniqueIdentificationId'].toString(),
                patient_FullName: patientMap['patient_FullName'].toString(),
                patient_Age: checkIfInteger(patientMap['patient_Age'].toString()),
                patient_Gender: patientMap['patient_Gender'].toString(),
                patient_Height: checkIfDouble(patientMap['patient_Height'].toString()),
                patient_Weight: checkIfDouble(patientMap['patient_Weight'].toString()),
                patient_BloodGroup: patientMap['patient_BloodGroup'].toString(),
                patient_PhoneNumber: patientMap['patient_PhoneNumber'].toString(),
                patient_EmailId: patientMap['patient_EmailId'],
                patient_RegistrationDetails: patientMap['patient_RegistrationDetails'].toString(),
                patient_CurrentCity: patientMap['patient_CurrentCity'].toString(),
                patient_CurrentCityPinCode: patientMap['patient_CurrentCityPinCode'].toString(),
                patient_LanguageType: patientMap['patient_LanguageType'].toString() == 'true',
                patient_Allergies: patientMap['patient_Allergies'].toString(),
                patient_Injuries: patientMap['patient_Injuries'].toString(),
                patient_Surgeries: patientMap['patient_Surgeries'].toString(),
                patient_Medication: patientMap['patient_Medication'].toString(),
                patient_ProfilePermission: patientMap['patient_ProfilePermission'].toString() == 'true',
                patient_ProfilePicUrl: patientMap['patient_ProfilePicUrl'].toString(),
                patient_ProfileCreationTime: DateTime.parse(patientMap['patient_ProfileCreationTime'].toString()),
                patient_SwasthyaMitraCenter_personalUniqueIdentificationId: patientMap['patient_SwasthyaMitraCenter_personalUniqueIdentificationId'].toString(),

              );

              if (patientMap['patient_SwasthyaMitraCenter_personalUniqueIdentificationId'].toString() == loggedInUserId) {
                loadedPatientsForAppointment.add(patientInfo);
              }
            },
          );
        },
      ).then((value) {
        this.itemsPatientDetails = loadedPatientsForAppointment;
        this.itemsCompletePatientDetails = loadedPatientsForAppointment;

        notifyListeners();
      });
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> fetchFilteredPatientsForSwasthyaMitra(
    BuildContext context,
    TextEditingController searchedText,
  ) async {
    if (searchedText == "") {
      return;
    }
    searchedText.text = searchedText.text.trim().toLowerCase();
    List<PatientDetailsInformation> loadedPatientsForAppointment = [];
    itemsCompletePatientDetails.forEach((patientInfo) {
      if (patientInfo.patient_FullName
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          patientInfo.patient_CurrentCity
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          patientInfo.patient_BloodGroup
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          patientInfo.patient_Surgeries
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          patientInfo.patient_Injuries
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          patientInfo.patient_Allergies
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          patientInfo.patient_Medication
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          patientInfo.patient_PhoneNumber
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          patientInfo.patient_CurrentCity
              .trim()
              .toLowerCase()
              .contains(searchedText.text)) {
        loadedPatientsForAppointment.add(patientInfo);
      }
    });

    this.itemsFilteredPatientDetails = loadedPatientsForAppointment;
    print(this.itemsFilteredPatientDetails.length);
    notifyListeners();
  }

  int checkIfInteger(String val) {
    if (val == 'null' || val == '' || int.tryParse(val).toString() == 'null') {
      return 0;
    } else {
      return int.parse(val);
    }
  }

  double checkIfDouble(String val) {
    if (double.tryParse(val).toString() != 'null') {
      return double.parse(val);
    } else if (val == 'null' ||
        val == '' ||
        int.tryParse(val).toString() == 'null' ||
        double.tryParse(val).toString() == 'null') {
      return 0.0;
    } else {
      return double.parse(val);
    }
  }
}
