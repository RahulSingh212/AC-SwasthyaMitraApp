// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, await_only_futures, unnecessary_brace_in_string_interps, unnecessary_new, unused_import

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
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
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/doctor_Info.dart';
import '../models/slot_info.dart';

class PatientAvailableDoctorDetails with ChangeNotifier {
  List<DoctorDetailsInformation> _itemsDoctorDetails = [];
  List<DoctorDetailsInformation> _itemsCompleteDoctorDetails = [];
  List<DoctorDetailsInformation> _itemsFilteredDoctorDetails = [];

  List<DoctorDetailsInformation> get itemsDoctorDetails {
    return [..._itemsDoctorDetails];
  }

  List<DoctorDetailsInformation> get itemsCompleteDoctorDetails {
    return [..._itemsCompleteDoctorDetails];
  }

  List<DoctorDetailsInformation> get itemsSearchedDoctorDetails {
    return [..._itemsFilteredDoctorDetails];
  }

  Future<void> clearAvailableDoctorForAppointment(BuildContext context) async {
    this._itemsDoctorDetails = [];
  }

  Future<void> fetchDoctorsForAppointment(
    BuildContext context,
    Map<String, String> filteredList,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference dbRefDoctorInfo =
        db.collection("DoctorUsersPersonalInformation");

    // var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    // var loggedInUserId = currLoggedInUser?.uid as String;

    try {
      List<DoctorDetailsInformation> loadedDoctorsForAppointment = [];
      db.collection('DoctorUsersPersonalInformation').get().then(
        (ds) {
          ds.docs.forEach(
            (doctorDetails) {
              var docMap = HashMap.from(doctorDetails.data());

              DoctorDetailsInformation doctorInfo =
                  new DoctorDetailsInformation(
                doctor_personalUniqueIdentificationId: docMap['doctor_personalUniqueIdentificationId'].toString(),
                doctor_AutherizationStatus: docMap['doctor_AutherizationStatus'].toString(),
                doctor_EnglishSpeaking: true,
                doctor_HindiSpeaking: true,
                doctor_FullName: docMap['doctor_FullName'].toString(),
                doctor_Gender: docMap['doctor_Gender'].toString(),
                doctor_CurrentCity: docMap['doctor_CurrentCity'].toString(),
                doctor_CurrentCityPinCode: docMap['doctor_CurrentCityPinCode'].toString(),
                doctor_RegistrationDetails: docMap['doctor_RegistrationDetails'].toString(),
                doctor_EducationQualification: docMap['doctor_EducationQualification'].toString(),
                doctor_MedicineType: docMap['doctor_MedicineType'].toString(),
                doctor_Speciality: docMap['doctor_Speciality'].toString(),
                doctor_MobileMessagingTokenId: docMap['doctor_MobileMessagingTokenId'].toString(),
                doctor_YearsOfExperience: checkIfInteger(docMap["doctor_YearsOfExperience"]),
                doctor_NumberOfPatientsTreated: checkIfInteger(docMap['doctor_NumberOfPatientsTreated'].toString()),
                doctor_TotalExperience: checkIfInteger(docMap['doctor_TotalExperience']),
                doctor_ExperienceRating: checkIfDouble(docMap['doctor_ExperienceRating'].toString()),
                doctor_PhoneNumber: docMap['doctor_PhoneNumber'].toString(),
                doctor_ProfilePicUrl: docMap['doctor_ProfilePicUrl'].toString(),
                doctor_AuthenticationCertificateUrl: docMap['doctor_AuthenticationCertificateUrl'].toString(),
                doctor_ProfileCreationTime: DateTime.parse(docMap['doctor_ProfileCreationTime'].toString()),
              );

              if (doctorInfo.doctor_AutherizationStatus.toLowerCase() ==
                  'authorized') {
                loadedDoctorsForAppointment.add(doctorInfo);
              }

              // print(docMap["doctor_YearsOfExperience"]);
            },
          );
        },
      ).then((value) {
        this._itemsDoctorDetails = loadedDoctorsForAppointment;
        this._itemsCompleteDoctorDetails = loadedDoctorsForAppointment;

        notifyListeners();
      });
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> fetchFilteredDoctorsForAppointment(
    BuildContext context,
    TextEditingController searchedText,
  ) async {
    if (searchedText == "") {
      return;
    }
    searchedText.text = searchedText.text.trim().toLowerCase();
    List<DoctorDetailsInformation> loadedDoctorsForAppointment = [];
    _itemsCompleteDoctorDetails.forEach((docInfo) {
      if (docInfo.doctor_FullName
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          docInfo.doctor_CurrentCity
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          docInfo.doctor_EducationQualification
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          docInfo.doctor_MedicineType
              .trim()
              .toLowerCase()
              .contains(searchedText.text) ||
          docInfo.doctor_Speciality
              .trim()
              .toLowerCase()
              .contains(searchedText.text)) {
        loadedDoctorsForAppointment.add(docInfo);
      }
    });

    this._itemsFilteredDoctorDetails = loadedDoctorsForAppointment;
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
