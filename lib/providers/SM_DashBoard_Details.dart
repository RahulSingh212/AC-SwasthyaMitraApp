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
import '../models/patient_Info.dart';
import '../models/testSlot_into.dart';
import 'SM_FirebaseLinks_Details.dart';

class SwasthyaMitraDashBoardDetails with ChangeNotifier {
  List<AppointmentDetailsInformation> itemsPatientActiveAppointmentList = [];
  List<AppointmentDetailsInformation> itemsPatientInActiveAppointmentList = [];
  List<SwasthyaMitrTestSlotInformation> patientActiveTestRequestList = [];
  List<SwasthyaMitrTestSlotInformation> patientInActiveTestRequestList = [];

  List<AppointmentDetailsInformation> get getPatientActiveAppointmentList {
    return [...itemsPatientActiveAppointmentList];
  }

  List<AppointmentDetailsInformation> get getPatientInActiveAppointmentList {
    return [...itemsPatientInActiveAppointmentList];
  }

  List<SwasthyaMitrTestSlotInformation> get getPatientActiveTestAppointmentList {
    return [...patientActiveTestRequestList];
  }

  List<SwasthyaMitrTestSlotInformation> get getPatientInActiveTestAppointmentList {
    return [...patientInActiveTestRequestList];
  }

  Future<void> fetchPatientAppointmentList(BuildContext context) async {
    // FirebaseFirestore db = FirebaseFirestore.instance;
    // CollectionReference usersRef = db.collection("PatientUsersPersonalInformation");
    // var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    // var loggedInUserId = currLoggedInUser?.uid as String;

    var loggedInUserId = Provider.of<SwasthyaMitraUserDetails>(context, listen: false).mp["SwasthyaMitra_personalUniqueIdentificationId"];
    
    Uri urlLink = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebasePathUrl('/SwasthyaMitraBookedAppointList/${loggedInUserId}.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      Map<String, dynamic> extractedClass = {};

      if (dataBaseResponse.body.toString() != "null")
        extractedClass = json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.isNotEmpty && extractedClass.toString() != "null") {
        final List<AppointmentDetailsInformation> activeTokenList = [];
        final List<AppointmentDetailsInformation> inActiveTokenList = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            AppointmentDetailsInformation availableToken = new AppointmentDetailsInformation(
              registeredTokenId: tokenId,
              appointmentFees: checkIfDouble(tokenInfo['appointmentFees']),
              appointmentDate: DateTime.parse(tokenInfo['appointmentDate']),
              appointmentTime: convertStringToTimeOfDay(tokenInfo['appointmentTime']),
              swasthyamitra_personalUniqueIdentificationId: tokenInfo['swasthyamitra_personalUniqueIdentificationId'],
              isClinicAppointmentType: tokenInfo['isClinicAppointmentType'] == 'true',
              isVideoAppointmentType: tokenInfo['isVideoAppointmentType'] == 'true',
              isTokenActive: tokenInfo['isTokenActive'] == 'true',
              doctor_personalUniqueIdentificationId: tokenInfo['doctor_personalUniqueIdentificationId'],
              doctor_AppointmentUniqueId: tokenInfo['doctor_AppointmentUniqueId'],
              doctorFullName: tokenInfo['doctorFullName'],
              doctorGender: tokenInfo['doctorGender'],
              doctorImageUrl: tokenInfo['doctorImageUrl'],
              doctorPhoneNumber: tokenInfo['doctorPhoneNumber'],
              patient_personalUniqueIdentificationId: tokenInfo['patient_personalUniqueIdentificationId'],
              patientFullName: tokenInfo['patientFullName'],
              patientGender: tokenInfo['patient_Gender'],
              patientImageUrl: tokenInfo['patientImageUrl'],
              patientPhoneNumber: tokenInfo['patient_PhoneNumber'],
              patientAilmentDescription: tokenInfo['patientAilmentDescription'],
            );

            if (availableToken.isTokenActive &&
                checkTokenExpiryDateForToday(
                  availableToken.appointmentDate,
                  availableToken.appointmentTime,
                )) {
              activeTokenList.add(availableToken);
            } else {
              inActiveTokenList.add(availableToken);
            }
          },
        );
        activeTokenList.sort((a, b) {
          if (a.appointmentDate == b.appointmentDate) {
            int t1 = a.appointmentTime.hour * 60 + a.appointmentTime.minute;
            int t2 = b.appointmentTime.hour * 60 + b.appointmentTime.minute;

            return t1.compareTo(t2);
          } else {
            return a.appointmentDate.compareTo(b.appointmentDate);
          }
        });
        inActiveTokenList.sort((a, b) {
          if (a.appointmentDate == b.appointmentDate) {
            int t1 = a.appointmentTime.hour * 60 + a.appointmentTime.minute;
            int t2 = b.appointmentTime.hour * 60 + b.appointmentTime.minute;

            return t2.compareTo(t1);
          } else {
            return b.appointmentDate.compareTo(a.appointmentDate);
          }
        });

        this.itemsPatientActiveAppointmentList = activeTokenList;
        this.itemsPatientInActiveAppointmentList = inActiveTokenList;
      }
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> fetchPatientBookedTests(
    BuildContext context,
  ) async {
    String smUniqueId =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .mp["SwasthyaMitra_personalUniqueIdentificationId"]
            .toString();

    Uri urlLink = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebasePathUrl('/SwasthyaMitraBookedTestsList/${smUniqueId}.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
        final List<SwasthyaMitrTestSlotInformation> patientActTestsList = [];
        final List<SwasthyaMitrTestSlotInformation> patientInActTestsList = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            SwasthyaMitrTestSlotInformation bookedTest =
                new SwasthyaMitrTestSlotInformation(
              registeredTokenId: tokenInfo['registeredTokenId'].toString(),
              appointmentDate:
                  DateTime.parse(tokenInfo['appointmentDate'].toString()),
              appointmentTime: convertStringToTimeOfDay(
                  tokenInfo['appointmentTime'].toString()),
              SwasthyaMitra_TestAppointmentUniqueId:
                  tokenInfo['SwasthyaMitra_TestAppointmentUniqueId'].toString(),
              isHomeAppointmentType:
                  tokenInfo['isHomeAppointmentType'].toString() == 'true',
              isCenterAppointmentType:
                  tokenInfo['isCenterAppointmentType'].toString() == 'true',
              isTokenActive: tokenInfo['isTokenActive'].toString() == 'true',
              patientAilmentDescription:
                  tokenInfo['patientAilmentDescription'].toString(),
              patient_personalUniqueIdentificationId:
                  tokenInfo['patient_personalUniqueIdentificationId']
                      .toString(),
              patientFullName: tokenInfo['patientFullName'].toString(),
              patientAddress: tokenInfo['patientAddress'].toString(),
              registrationTiming:
                  DateTime.parse(tokenInfo['registrationTiming'].toString()),
              testType: tokenInfo['testType'].toString(),
              testReportUrl: tokenInfo['testReportUrl'].toString(),
              tokenTestFees:
                  checkIfDouble(tokenInfo['tokenTestFees'].toString()),
            );

            if (bookedTest.isTokenActive &&
                checkTokenExpiryDateForToday(
                  bookedTest.appointmentDate,
                  bookedTest.appointmentTime,
                )) {
              patientActTestsList.add(bookedTest);
            } else {
              patientInActTestsList.add(bookedTest);
            }
          },
        );

        // _itemsPatientBookedSlots = loadedPatientUpcomingBookedTokens;
        patientActTestsList.sort((a, b) {
          if (a.appointmentDate == b.appointmentDate) {
            int t1 = a.appointmentTime.hour * 60 + a.appointmentTime.minute;
            int t2 = b.appointmentTime.hour * 60 + b.appointmentTime.minute;

            return t1.compareTo(t2);
          } else {
            return a.appointmentDate.compareTo(b.appointmentDate);
          }
        });
        patientInActTestsList.sort((a, b) {
          if (a.appointmentDate == b.appointmentDate) {
            int t1 = a.appointmentTime.hour * 60 + a.appointmentTime.minute;
            int t2 = b.appointmentTime.hour * 60 + b.appointmentTime.minute;

            return t2.compareTo(t1);
          } else {
            return b.appointmentDate.compareTo(a.appointmentDate);
          }
        });

        patientActiveTestRequestList = patientActTestsList;
        patientInActiveTestRequestList = patientInActTestsList;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
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
