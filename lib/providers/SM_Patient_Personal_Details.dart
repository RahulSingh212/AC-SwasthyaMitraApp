// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, await_only_futures, unnecessary_brace_in_string_interps, duplicate_import, unused_import, avoid_print, unnecessary_new, avoid_function_literals_in_foreach_calls, unrelated_type_equality_checks, unused_field

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

import '../models/appointment_info.dart';

class SwasthyaMitraPatientPersonalDetails with ChangeNotifier {
  Map<String, String> paitentUserMapping = {};

  Future<void> fetchPatientPersonalUserDetails(
    BuildContext context,
    AppointmentDetailsInformation tokenInfo,
  ) async {
    var response = await FirebaseFirestore.instance
          .collection('PatientUsersPersonalInformation')
          .doc(tokenInfo.patient_personalUniqueIdentificationId)
          .get()
          .then(
        (DocumentSnapshot ds) {
          String patient_LanguageType = "";
          String patient_uniqueDatabaseId = "";
          String patient_personalUniqueIdentificationId = "";
          String patient_ProfilePermission = "";

          String patient_FullName = "";
          String patient_FirstName = "";
          String patient_LastName = "";
          String patient_Gender = "";
          String patient_PhoneNumber = "";

          String patient_Age = "0";
          String patient_Weight = "0";
          String patient_Height = "0";
          String patient_BloodGroup = "";
          String patient_Medication = "";
          String patient_Injuries = "";
          String patient_Surgeries = "";
          String patient_Allergies = "";

          String patient_CurrentCity = "";
          String patient_CurrentCityPinCode = "";
          String patient_RegistrationDetails = "";

          String patient_ProfilePicUrl = "";
          String patient_ProfileCreationTime = "";
          String patient_SwasthyaMitraCenter_personalUniqueIdentificationId = "";

          patient_LanguageType = ds.get('patient_LanguageType').toString();
          patient_uniqueDatabaseId = ds.get('patient_uniqueDatabaseId').toString();
          patient_personalUniqueIdentificationId = ds.get('patient_personalUniqueIdentificationId').toString();

          patient_FullName = ds.get('patient_FullName').toString();
          patient_FirstName = ds.get('patient_FirstName').toString();
          patient_LastName = ds.get('patient_LastName').toString();
          patient_Gender = ds.get('patient_Gender').toString();
          patient_PhoneNumber = ds.get('patient_PhoneNumber').toString();

          patient_Age = ds.get('patient_Age').toString();
          patient_Weight = ds.get('patient_Weight').toString();
          patient_Height = ds.get('patient_Height').toString();
          patient_BloodGroup = ds.get('patient_BloodGroup').toString();
          patient_Medication = ds.get('patient_Medication').toString();
          patient_Injuries = ds.get('patient_Injuries').toString();
          patient_Surgeries = ds.get('patient_Surgeries').toString();
          patient_Allergies = ds.get('patient_Allergies').toString();

          patient_CurrentCity = ds.get('patient_CurrentCity').toString();
          patient_CurrentCityPinCode = ds.get('patient_CurrentCityPinCode').toString();
          patient_RegistrationDetails = ds.get('patient_RegistrationDetails').toString();

          patient_ProfilePicUrl = ds.get('patient_ProfilePicUrl').toString();
          patient_ProfileCreationTime = ds.get('patient_ProfileCreationTime').toString();
          patient_ProfilePermission = ds.get('patient_ProfilePermission').toString();
          patient_SwasthyaMitraCenter_personalUniqueIdentificationId = ds.get('patient_SwasthyaMitraCenter_personalUniqueIdentificationId').toString();

          paitentUserMapping["patient_uniqueDatabaseId"] = patient_uniqueDatabaseId;
          paitentUserMapping["patient_personalUniqueIdentificationId"] = patient_personalUniqueIdentificationId;
          paitentUserMapping['patient_ProfilePermission'] = patient_ProfilePermission;

          paitentUserMapping["patient_FullName"] = patient_FullName;
          paitentUserMapping["patient_FirstName"] = patient_FirstName;
          paitentUserMapping["patient_LastName"] = patient_LastName;
          paitentUserMapping["patient_Gender"] = patient_Gender;
          paitentUserMapping["patient_PhoneNumber"] = patient_PhoneNumber;

          paitentUserMapping["patient_Age"] = patient_Age;
          paitentUserMapping["patient_Weight"] = patient_Weight;
          paitentUserMapping["patient_Height"] = patient_Height;
          paitentUserMapping["patient_BloodGroup"] = patient_BloodGroup;
          paitentUserMapping["patient_Medication"] = patient_Medication;
          paitentUserMapping["patient_Injuries"] = patient_Injuries;
          paitentUserMapping["patient_Surgeries"] = patient_Surgeries;
          paitentUserMapping["patient_Allergies"] = patient_Allergies;

          paitentUserMapping["patient_CurrentCity"] = patient_CurrentCity;
          paitentUserMapping["patient_CurrentCityPinCode"] = patient_CurrentCityPinCode;
          paitentUserMapping["patient_RegistrationDetails"] = patient_RegistrationDetails;

          paitentUserMapping["patient_ProfilePicUrl"] = patient_ProfilePicUrl;
          paitentUserMapping["patient_ProfileCreationTime"] = patient_ProfileCreationTime;
          paitentUserMapping["patient_SwasthyaMitraCenter_personalUniqueIdentificationId"] = patient_SwasthyaMitraCenter_personalUniqueIdentificationId;
        },
      ).then((value) {
        notifyListeners();
      });
  }

  bool checkTokenExpiryDateForToday(
    DateTime bookedTokenDate,
    TimeOfDay bookedTokenTime,
  ) {
    DateTime today = DateTime.now();

    if (bookedTokenDate.add(Duration(days: 1)).isBefore(today) == false) {
      if (bookedTokenDate.day == today.day &&
          bookedTokenDate.month == today.month &&
          bookedTokenDate.year == today.year) {
        if (checkTokenSlotTimeValidity(bookedTokenTime)) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  bool checkTokenSlotTimeValidity(TimeOfDay bookedTimeSlot) {
    int currMin = DateTime.now().hour * 60 + DateTime.now().minute;
    int slotMin = bookedTimeSlot.hour * 60 + bookedTimeSlot.minute + 45;

    if (currMin <= slotMin) {
      return true;
    } else {
      return false;
    }
  }

  TimeOfDay convertStringToTimeOfDay(String givenTime) {
    int hrVal = int.parse(givenTime.split(":")[0].substring(10));
    int minVal = int.parse(givenTime.split(":")[1].substring(0, 2));
    TimeOfDay time = TimeOfDay(hour: hrVal, minute: minVal);

    return time;
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
