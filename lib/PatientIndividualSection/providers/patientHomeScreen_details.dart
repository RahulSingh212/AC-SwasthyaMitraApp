// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, await_only_futures, unnecessary_brace_in_string_interps, unnecessary_new, prefer_const_constructors, unused_import, duplicate_import

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

import '../../models/patient_Info.dart';
import '../../providers/SM_FirebaseLinks_Details.dart';
import '../models/slot_info.dart';
import '../models/token_info.dart';

class PatientHomeScreenrDetails with ChangeNotifier {
  List<BookedTokenSlotInformation> _itemsPatientTodaysBookedSlots = [];

  List<BookedTokenSlotInformation> get items {
    return [..._itemsPatientTodaysBookedSlots];
  }

  Future<void> fetchPatientActiveTodaysTokens(
    BuildContext context,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("PatientUsersPersonalInformation");

    Uri urlLink = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebasePathUrl('/PatientBookedAppointList/${patientDetails.patient_personalUniqueIdentificationId.toString()}.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass = json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
        final List<BookedTokenSlotInformation> loadedPatientBookedTokens = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            BookedTokenSlotInformation availableToken = new BookedTokenSlotInformation(
              bookedTokenDate:
                  DateTime.parse(tokenInfo["appointmentDate"].toString()),
              bookedTokenTime: convertStringToTimeOfDay(
                  tokenInfo["appointmentTime"].toString()),
              doctor_AppointmentUniqueId:
                  tokenInfo["doctor_AppointmentUniqueId"],
              doctor_personalUniqueIdentificationId:
                  tokenInfo["doctor_personalUniqueIdentificationId"].toString(),
              isClinicAppointmentType:
                  tokenInfo["isClinicAppointmentType"].toString() == "true",
              isVideoAppointmentType:
                  tokenInfo["isVideoAppointmentType"].toString() == "true",
              isTokenActive: tokenInfo["isTokenActive"].toString() == "true",
              patientAilmentDescription:
                  tokenInfo["patientAilmentDescription"].toString(),
              prescriptionUrl: tokenInfo["prescriptionUrl"].toString(),
              registeredTokenId: tokenId,
              slotType: tokenInfo["slotType"].toString(),
              registrationTiming:
                  DateTime.parse(tokenInfo["registrationTiming"].toString()),
              doctorFullName: tokenInfo["doctorFullName"].toString(),
              doctorSpeciality: tokenInfo["doctorSpeciality"].toString(),
              doctorImageUrl: tokenInfo["doctorImageUrl"].toString(),
              doctorTotalRatings:
                  checkIfInteger(tokenInfo["doctorTotalRatings"].toString()),
              testType: tokenInfo["testType"].toString(),
              aurigaCareTestCenter:
                  tokenInfo["aurigaCareTestCenter"].toString(),
              testReportUrl: tokenInfo["testReportUrl"].toString(),
              tokenFees: checkIfDouble(tokenInfo["tokenFees"]),
              patientGivenRatings:
                  checkIfInteger(tokenInfo['givenPatientExperienceRating']),
            );

            if (availableToken.isTokenActive &&
                checkTokenExpiryDateForToday(
                  availableToken.bookedTokenDate,
                  availableToken.bookedTokenTime,
                )) {
              loadedPatientBookedTokens.add(availableToken);
            }
          },
        );

        loadedPatientBookedTokens.sort((a, b) {
          if (a.bookedTokenDate == b.bookedTokenDate) {
            int t1 = a.bookedTokenTime.hour * 60 + a.bookedTokenTime.minute;
            int t2 = b.bookedTokenTime.hour * 60 + b.bookedTokenTime.minute;

            return t1.compareTo(t2);
          } else {
            return a.bookedTokenDate.compareTo(b.bookedTokenDate);
          }
        });

        _itemsPatientTodaysBookedSlots = loadedPatientBookedTokens;
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
        return false;
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

  // bool checkTokenExpiryDate(
  //   DateTime expiredDateTime,
  //   TimeOfDay bookedTimeSlot,
  // ) {
  //   var currTime = DateTime.now();
  //   if (expiredDateTime.day == currTime.day &&
  //       expiredDateTime.month == currTime.month &&
  //       expiredDateTime.year == currTime.year) {
  //     int currMin = DateTime.now().hour * 60 + DateTime.now().minute;
  //     int slotMin = bookedTimeSlot.hour * 60 + bookedTimeSlot.minute + 10;

  //     if (currMin <= slotMin) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     DateTime presentDateTime = DateTime.utc(
  //         DateTime.now().year, DateTime.now().month, DateTime.now().day);

  //     bool chk =
  //         presentDateTime.isBefore(expiredDateTime.add(Duration(days: 1)));

  //     if (chk) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  // bool checkTokenSlotDateValidity(DateTime expiredDateTime) {
  //   DateTime presentDateTime = DateTime.utc(
  //       DateTime.now().year, DateTime.now().month, DateTime.now().day);

  //   bool chk =
  //       presentDateTime.isBefore(expiredDateTime.add(new Duration(days: 1)));

  //   if (chk) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

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
