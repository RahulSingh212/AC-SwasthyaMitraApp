// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, await_only_futures, unnecessary_brace_in_string_interps, unused_import, duplicate_import

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
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PatientDetailsInformation {
  late final String patient_personalUniqueIdentificationId;

  final String patient_FullName;
  final int patient_Age;
  final String patient_Gender;
  final double patient_Height;
  final double patient_Weight;
  final String patient_BloodGroup;

  final String patient_PhoneNumber;
  final String patient_EmailId;
  final String patient_RegistrationDetails;
  final String patient_CurrentCity;
  final String patient_CurrentCityPinCode;
  final bool patient_LanguageType;

  final String patient_Allergies;
  final String patient_Injuries;
  final String patient_Surgeries;
  final String patient_Medication;

  final bool patient_ProfilePermission;
  final String patient_ProfilePicUrl;
  final String patient_SwasthyaMitraCenter_personalUniqueIdentificationId;

  final DateTime patient_ProfileCreationTime;

  PatientDetailsInformation({
    required this.patient_personalUniqueIdentificationId,
    required this.patient_FullName,
    required this.patient_Age,
    required this.patient_Gender,
    required this.patient_Height,
    required this.patient_Weight,
    required this.patient_BloodGroup,
    required this.patient_PhoneNumber,
    required this.patient_EmailId,
    required this.patient_RegistrationDetails,
    required this.patient_CurrentCity,
    required this.patient_CurrentCityPinCode,
    required this.patient_LanguageType,
    required this.patient_Allergies,
    required this.patient_Injuries,
    required this.patient_Surgeries,
    required this.patient_Medication,
    required this.patient_ProfilePermission,
    required this.patient_ProfilePicUrl,
    required this.patient_ProfileCreationTime,
    required this.patient_SwasthyaMitraCenter_personalUniqueIdentificationId,
  });
}
