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

class SwasthyaMitraBookingTestDetails with ChangeNotifier {

  Future<void> fetchPatientInActivePreviousTokens(
    BuildContext context,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef =
        db.collection("PatientUsersPersonalInformation");

    Uri urlLink = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebasePathUrl('/PatientBookedAppointList/${patientDetails.patient_personalUniqueIdentificationId.toString()}.json');

    // try {
    //   final dataBaseResponse = await http.get(urlLink);
    //   final extractedClass =
    //       json.decode(dataBaseResponse.body) as Map<String, dynamic>;

    //   if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
    //     final List<BookedTokenSlotInformation>
    //         loadedPatientUpcomingBookedTokens = [];
    //     final List<BookedTokenSlotInformation>
    //         loadedPatientExpiredBookedTokens = [];

    //     extractedClass.forEach(
    //       (tokenId, tokenInfo) async {
    //         BookedTokenSlotInformation availableToken =
    //             new BookedTokenSlotInformation(
    //           bookedTokenDate: DateTime.parse(tokenInfo["appointmentDate"]),
    //           bookedTokenTime:
    //               convertStringToTimeOfDay(tokenInfo["appointmentTime"]),
    //           doctor_AppointmentUniqueId:
    //               tokenInfo["doctor_AppointmentUniqueId"],
    //           doctor_personalUniqueIdentificationId:
    //               tokenInfo["doctor_personalUniqueIdentificationId"],
    //           isClinicAppointmentType:
    //               tokenInfo["isClinicAppointmentType"] == "true",
    //           isVideoAppointmentType:
    //               tokenInfo["isVideoAppointmentType"] == "true",
    //           isTokenActive: tokenInfo["isTokenActive"] == "true",
    //           patientAilmentDescription: tokenInfo["patientAilmentDescription"],
    //           prescriptionUrl: tokenInfo["prescriptionUrl"],
    //           registeredTokenId: tokenId,
    //           slotType: tokenInfo["slotType"],
    //           registrationTiming:
    //               DateTime.parse(tokenInfo["registrationTiming"]),
    //           doctorFullName: tokenInfo["doctorFullName"],
    //           doctorSpeciality: tokenInfo["doctorSpeciality"],
    //           doctorImageUrl: tokenInfo["doctorImageUrl"],
    //           doctorTotalRatings:
    //               checkIfInteger(tokenInfo["doctorTotalRatings"]),
    //           testType: tokenInfo["testType"],
    //           aurigaCareTestCenter: tokenInfo["aurigaCareTestCenter"],
    //           testReportUrl: tokenInfo["testReportUrl"],
    //           tokenFees: checkIfDouble(tokenInfo["tokenFees"]),
    //           patientGivenRatings:
    //               checkIfInteger(tokenInfo['givenPatientExperienceRating']),
    //         );

    //         if (!availableToken.isTokenActive ||
    //             !checkTokenExpiryDateForToday(
    //               availableToken.bookedTokenDate,
    //               availableToken.bookedTokenTime,
    //             )) {
    //           loadedPatientExpiredBookedTokens.add(availableToken);
    //         } else {
    //           loadedPatientUpcomingBookedTokens.add(availableToken);
    //         }
    //       },
    //     );

    //     // _itemsPatientBookedSlots = loadedPatientUpcomingBookedTokens;
    //     loadedPatientUpcomingBookedTokens.sort((a, b) {
    //       if (a.bookedTokenDate == b.bookedTokenDate) {
    //         int t1 = a.bookedTokenTime.hour * 60 + a.bookedTokenTime.minute;
    //         int t2 = b.bookedTokenTime.hour * 60 + b.bookedTokenTime.minute;

    //         return t1.compareTo(t2);
    //       } else {
    //         return a.bookedTokenDate.compareTo(b.bookedTokenDate);
    //       }
    //     });
    //     loadedPatientExpiredBookedTokens.sort((a, b) {
    //       if (a.bookedTokenDate == b.bookedTokenDate) {
    //         int t1 = a.bookedTokenTime.hour * 60 + a.bookedTokenTime.minute;
    //         int t2 = b.bookedTokenTime.hour * 60 + b.bookedTokenTime.minute;

    //         return t2.compareTo(t1);
    //       } else {
    //         return b.bookedTokenDate.compareTo(a.bookedTokenDate);
    //       }
    //     });

    //     _itemsPatientBookedSlotsExpired = loadedPatientExpiredBookedTokens;
    //     _itemsPatientBookedSlotsUpcoming = loadedPatientUpcomingBookedTokens;

    //     _itemsPatientBookedSlots = [
    //       _itemsPatientBookedSlotsUpcoming,
    //       _itemsPatientBookedSlotsExpired
    //     ].expand((element) => element).toList();
    //     _itemsPatientBookedSlots.sort((a, b) {
    //       if (a.bookedTokenDate == b.bookedTokenDate) {
    //         int t1 = a.bookedTokenTime.hour * 60 + a.bookedTokenTime.minute;
    //         int t2 = b.bookedTokenTime.hour * 60 + b.bookedTokenTime.minute;

    //         return t2.compareTo(t1);
    //       } else {
    //         return b.bookedTokenDate.compareTo(a.bookedTokenDate);
    //       }
    //     });
    //     notifyListeners();
    //   }
    // } catch (errorVal) {
    //   print("Error Value");
    //   print(errorVal);
    // }
  }

  Future<void> bookPatientTests(BuildContext context) async {}

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
