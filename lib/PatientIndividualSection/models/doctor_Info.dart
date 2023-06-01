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

class DoctorDetailsInformation {
  final String doctor_personalUniqueIdentificationId;
  final String doctor_AutherizationStatus;
  final bool doctor_EnglishSpeaking;
  final bool doctor_HindiSpeaking;

  final String doctor_FullName;
  final String doctor_Gender;
  final String doctor_CurrentCity;
  final String doctor_CurrentCityPinCode;
  final String doctor_RegistrationDetails;

  final String doctor_EducationQualification;
  final String doctor_MedicineType;
  final String doctor_Speciality;

  final int doctor_YearsOfExperience;
  final int doctor_NumberOfPatientsTreated;
  final int doctor_TotalExperience;
  final double doctor_ExperienceRating;

  final String doctor_PhoneNumber;
  final String doctor_ProfilePicUrl;
  final String doctor_AuthenticationCertificateUrl;
  final String doctor_MobileMessagingTokenId;
  final DateTime doctor_ProfileCreationTime;

  DoctorDetailsInformation({
    required this.doctor_personalUniqueIdentificationId,
    required this.doctor_AutherizationStatus,
    required this.doctor_EnglishSpeaking,
    required this.doctor_HindiSpeaking,

    required this.doctor_FullName,
    required this.doctor_Gender,
    required this.doctor_CurrentCity,
    required this.doctor_CurrentCityPinCode,
    required this.doctor_RegistrationDetails,

    required this.doctor_EducationQualification,
    required this.doctor_MedicineType,
    required this.doctor_Speciality,

    required this.doctor_YearsOfExperience,
    required this.doctor_NumberOfPatientsTreated,
    required this.doctor_TotalExperience,
    required this.doctor_ExperienceRating,

    required this.doctor_PhoneNumber,
    required this.doctor_ProfilePicUrl,
    required this.doctor_AuthenticationCertificateUrl,
    required this.doctor_MobileMessagingTokenId,
    required this.doctor_ProfileCreationTime,
  });
}