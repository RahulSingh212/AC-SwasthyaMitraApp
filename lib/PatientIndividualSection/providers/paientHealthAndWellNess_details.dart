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
import '../models/blood_pressure.dart';
import '../models/blood_sugar_level.dart';
import '../models/body_temperature_info.dart';
import '../models/calorie_info.dart';
import '../models/haemoglobin_info.dart';
import '../models/oxygen_level_info.dart';
import '../models/slot_info.dart';
import '../models/steps_distance_info.dart';

class PatientHealthAndWellNessDetails with ChangeNotifier {
  List<Blood_pressure> bloodPressureList = [];
  List<steps_distance> stepsDistanceList = [];
  List<blood_sugar_lvl> bloodSugarLevelList = [];
  List<oxygen_lvl> oxygenLevelList = [];
  List<calorie> calorieLevelList = [];
  List<haemoglobin> haemoglobinLevelList = [];
  List<body_temp> bodyTemperatureList = [];

  // String firebaseUrlInUse = "aurigacarehealthapplication-default-rtdb.firebaseio.com";
  String firebaseUrlInUse = "aurigacare-dpapplication-default-rtdb.firebaseio.com";

  Uri getFirebasePathUrl(String pathLocation) {
    Uri url = Uri.https(
      '${firebaseUrlInUse}',
      '${pathLocation}',
    );

    return url;
  }

  List<Blood_pressure> getBloodPressureList() {
    return this.bloodPressureList;
  }

  List<steps_distance> getStepsDistanceList() {
    return this.stepsDistanceList;
  }

  List<blood_sugar_lvl> getBloodSugarLevelList() {
    return this.bloodSugarLevelList;
  }

  List<oxygen_lvl> getOxygenLevelList() {
    return this.oxygenLevelList;
  }

  List<calorie> getCalorieLevelList() {
    return this.calorieLevelList;
  }

  List<haemoglobin> getHaemoglobinLevelList() {
    return this.haemoglobinLevelList;
  }

  List<body_temp> getBodyTemperatureList() {
    return this.bodyTemperatureList;
  }

  Future<void> fetchPreviousBloodPressureList(
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/BloodPressureList.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
        final List<Blood_pressure> completeBloodPressureList = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            Blood_pressure availableToken = new Blood_pressure(
              Systolic: checkIfInteger(
                  tokenInfo["systolic_blood_pressure"].toString()),
              Diastolic: checkIfInteger(
                  tokenInfo["diastolic_blood_pressure"].toString()),
              Date_time: DateTime.parse(
                  tokenInfo["patient_mentioned_time"].toString()),
            );

            completeBloodPressureList.add(availableToken);
          },
        );

        this.bloodPressureList = completeBloodPressureList;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<void> addPatientBloodPressure(
    BuildContext context,
    Blood_pressure bp,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();


    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/BloodPressureList.json');

    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    var responseForPatientApt = await http.post(
      urlLink,
      body: json.encode(
        {
          'systolic_blood_pressure': bp.Systolic.toString(),
          'diastolic_blood_pressure': bp.Diastolic.toString(),
          'patient_mentioned_time': bp.Date_time.toString(),
          'registering_time': currTime.toString(),
        },
      ),
    );
  }

  Future<void> fetchPreviousStepsDistanceList(
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/DistanceTraveledList.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
        final List<steps_distance> completeStepsDistanceList = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            steps_distance availableToken = new steps_distance(
              Steps: checkIfInteger(tokenInfo['steps_travelled']),
              Distance: checkIfDouble(tokenInfo['distance_travelled']),
              Date_time: DateTime.parse(tokenInfo['patient_mentioned_time']),
            );

            completeStepsDistanceList.add(availableToken);
          },
        );

        this.stepsDistanceList = completeStepsDistanceList;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<void> addPatientDistanceTravelled(
    BuildContext context,
    steps_distance sd,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/DistanceTraveledList.json');

    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    var responseForPatientApt = await http.post(
      urlLink,
      body: json.encode(
        {
          'steps_travelled': sd.Steps.toString(),
          'distance_travelled': sd.Distance.toString(),
          'patient_mentioned_time': sd.Date_time.toString(),
          'registering_time': currTime.toString(),
        },
      ),
    );
  }

  Future<void> fetchPreviousBloodSugarLevelList(
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/BloodSugarLevelList.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
        final List<blood_sugar_lvl> completeBloodSugarLevelList = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            blood_sugar_lvl availableToken = new blood_sugar_lvl(
              checkIfInteger(tokenInfo['fasting_blood_sugar_level']),
              checkIfInteger(tokenInfo['random_blood_sugar_level']),
              checkIfInteger(tokenInfo['post_prandial_blood_sugar_level']),
              DateTime.parse(
                tokenInfo['patient_mentioned_time'],
              ),
            );

            completeBloodSugarLevelList.add(availableToken);
          },
        );

        this.bloodSugarLevelList = completeBloodSugarLevelList;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<void> addPatientBloodSugarLevel(
    BuildContext context,
    blood_sugar_lvl bsl,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/BloodSugarLevelList.json');

    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    var responseForPatientApt = await http.post(
      urlLink,
      body: json.encode(
        {
          'fasting_blood_sugar_level': bsl.Fasting.toString(),
          'random_blood_sugar_level': bsl.Random.toString(),
          'post_prandial_blood_sugar_level': bsl.Post_Prandial.toString(),
          'reading_status': bsl.Status.toString(),
          'status_color': bsl.color.toString(),
          'patient_mentioned_time': bsl.Date_time.toString(),
          'registering_time': currTime.toString(),
        },
      ),
    );
  }

  Future<void> fetchPreviousOxygenLevelList(
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/OxygenLevelList.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
        final List<oxygen_lvl> completeOxygenLevelList = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            oxygen_lvl availableToken = new oxygen_lvl(
              Oxy_lvl: checkIfDouble(tokenInfo['oxygen_level']),
              Date_time: DateTime.parse(tokenInfo['patient_mentioned_time']),
            );

            completeOxygenLevelList.add(availableToken);
          },
        );

        this.oxygenLevelList = completeOxygenLevelList;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<void> addPatientOxygenLevel(
    BuildContext context,
    oxygen_lvl ol,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/OxygenLevelList.json');

    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    var responseForPatientApt = await http.post(
      urlLink,
      body: json.encode(
        {
          'oxygen_level': ol.Oxy_lvl.toString(),
          'oxygen_level_status': ol.Status.toString(),
          'status_color': ol.color.toString(),
          'patient_mentioned_time': ol.Date_time.toString(),
          'registering_time': currTime.toString(),
        },
      ),
    );
  }

  Future<void> fetchPreviousCalorieIntakeLevelList(
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/CalorieIntakeLevelList.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
        final List<calorie> completeCalorieIntakeLevelList = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            calorie availableToken = new calorie(
              Calorie: checkIfInteger(tokenInfo['calorie_level']),
              Date_time: DateTime.parse(
                tokenInfo['patient_mentioned_time'],
              ),
            );

            completeCalorieIntakeLevelList.add(availableToken);
          },
        );

        this.calorieLevelList = completeCalorieIntakeLevelList;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<void> addPatientCalorieIntakeLevel(
    BuildContext context,
    calorie cil,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/CalorieIntakeLevelList.json');

    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    var responseForPatientApt = await http.post(
      urlLink,
      body: json.encode(
        {
          'calorie_level': cil.Calorie.toString(),
          'status_color': cil.color.toString(),
          'patient_mentioned_time': cil.Date_time.toString(),
          'registering_time': currTime.toString(),
        },
      ),
    );
  }

  Future<void> fetchPreviousHaemoglobinLevelList(
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/HaemoglobinLevel.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
        final List<haemoglobin> completeHaemoglobinLevelList = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            haemoglobin availableToken = new haemoglobin(
              Hemoglobin_lvl: checkIfDouble(tokenInfo['haemoglobin_level']),
              Date_time: DateTime.parse(
                tokenInfo['patient_mentioned_time'],
              ),
            );

            completeHaemoglobinLevelList.add(availableToken);
          },
        );

        this.haemoglobinLevelList = completeHaemoglobinLevelList;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<void> addPatientHaemoglobinLevel(
    BuildContext context,
    haemoglobin hl,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/HaemoglobinLevel.json');

    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    var responseForPatientApt = await http.post(
      urlLink,
      body: json.encode(
        {
          'haemoglobin_level': hl.Hemoglobin_lvl.toString(),
          'status_color': hl.color.toString(),
          'patient_mentioned_time': hl.Date_time.toString(),
          'registering_time': currTime.toString(),
        },
      ),
    );
  }

  Future<void> fetchPreviousTemperatureLevelList(
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/TemperatureLevel.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass.toString() != "null" && extractedClass.isNotEmpty) {
        final List<body_temp> completeTemperatureLevelList = [];

        extractedClass.forEach(
          (tokenId, tokenInfo) async {
            body_temp availableToken = new body_temp(
              Body_Temp: checkIfDouble(tokenInfo['temperature_level']),
              Date_time: DateTime.parse(tokenInfo['patient_mentioned_time']),
            );

            completeTemperatureLevelList.add(availableToken);
          },
        );

        this.bodyTemperatureList = completeTemperatureLevelList;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<void> addPatientTemperatureLevel(
    BuildContext context,
    body_temp bt,
    PatientDetailsInformation patientDetails,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    DateTime currTime = DateTime.now();

    Uri urlLink = getFirebasePathUrl('/PatientHealthAndWellNessDetails/${patientDetails.patient_personalUniqueIdentificationId.toString()}/TemperatureLevel.json');

    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    var responseForPatientApt = await http.post(
      urlLink,
      body: json.encode(
        {
          'temperature_level': bt.Body_Temp.toString(),
          'patient_mentioned_time': bt.Date_time.toString(),
          'registering_time': currTime.toString(),
        },
      ),
    );
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
