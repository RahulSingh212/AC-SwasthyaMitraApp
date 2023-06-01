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
import '../models/doctor_Info.dart';
import '../models/slot_info.dart';

class DoctorCalendarDetails with ChangeNotifier {
  List<DoctorSlotInformation> _itemsDoctorAppointmentsList = [];

  List<DoctorSlotInformation> get items {
    return [..._itemsDoctorAppointmentsList];
  }

  Future<void> clearDoctorAvailableSlotDetails(BuildContext context) async {
    this._itemsDoctorAppointmentsList = [];
  }

  Future<void> fetchSelectedDoctorAvailableSlots(
    BuildContext context,
    DoctorDetailsInformation doctorDetails,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    String doctorUserId = doctorDetails.doctor_personalUniqueIdentificationId;
    
    Uri urlLink = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorAvailableSlots/${doctorUserId}.json');

    List<bool> lt = [true, false, true, true, false, true, false];

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null") {
        final List<DoctorSlotInformation> loadedAvailableDoctorSlots = [];

        extractedClass.forEach(
          (slotId, slotInfo) async {
            DoctorSlotInformation availableSlot = new DoctorSlotInformation(
              slotUniqueId: slotId,
              isClinic:
                  slotInfo['isClinicAvailable'].toString().toLowerCase() ==
                      'true',
              isVideo: slotInfo['isVideoAvailable'].toString().toLowerCase() ==
                  'true',
              registeredDate:
                  DateTime.parse(slotInfo['slotRegistrationDate'].toString()),
              expiredDate:
                  DateTime.parse(slotInfo['slotExpiryDate'].toString()),
              startTime: convertStringToTimeOfDay(
                  slotInfo['slotStartTime'].toString()),
              endTime:
                  convertStringToTimeOfDay(slotInfo['slotEndTime'].toString()),
              isRepeat:
                  slotInfo['isSlotRepeated'].toString().toLowerCase() == 'true',
              repeatWeekDaysList: convertStringToListOfBoolWeekDays(
                  slotInfo['repeatDaysOfTheWeek'].toString()),
              isSlotActive:
                  slotInfo['isDoctorSlotActive'].toString().toLowerCase() ==
                      'true',
              patientSlotIntervalDuration: Duration(
                  hours:
                      int.parse(slotInfo['patientSlotDuration'].split(":")[0]),
                  minutes:
                      int.parse(slotInfo['patientSlotDuration'].split(":")[1])),
              maximumNumberOfSlots:
                  checkIfInteger(slotInfo['maximumNumberOfSlots'].toString()),
              appointmentFeesPerPatient:
                  checkIfDouble(slotInfo['appointFeePerPatient'].toString()),
              givenPatientExperienceRating: 0.0,
            );
            // print(availableSlot);
            if (slotInfo['isSlotRepeated'].toString().toLowerCase() == 'true' ||
                checkAppointmentSlotValidity(availableSlot.expiredDate)) {
              loadedAvailableDoctorSlots.add(availableSlot);
            }
          },
        );

        loadedAvailableDoctorSlots.sort((a, b) {
          return a.registeredDate.compareTo(b.registeredDate);
        });
        _itemsDoctorAppointmentsList = loadedAvailableDoctorSlots;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  bool checkAppointmentSlotValidity(DateTime expiredDateTime) {
    DateTime presentDateTime = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);

    bool chk =
        presentDateTime.isBefore(expiredDateTime.add(new Duration(days: 1)));

    if (chk) {
      return true;
    } else {
      return false;
    }
  }

  List<bool> convertStringToListOfBoolWeekDays(String bitVal) {
    List<bool> weekDaySelected = List.filled(7, false);

    for (var i = 0; i < 7; i++) {
      if (bitVal[i] == '1') {
        weekDaySelected[i] = true;
      }
    }

    return weekDaySelected;
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
