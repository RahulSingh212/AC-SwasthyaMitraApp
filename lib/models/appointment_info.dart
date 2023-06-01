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

class AppointmentDetailsInformation {
  final String registeredTokenId;
  final double appointmentFees;
  final DateTime appointmentDate;
  final TimeOfDay appointmentTime;
  final String swasthyamitra_personalUniqueIdentificationId;
  final bool isClinicAppointmentType;
  final bool isVideoAppointmentType;
  final bool isTokenActive;

  final String doctor_personalUniqueIdentificationId;
  final String doctor_AppointmentUniqueId;
  final String doctorFullName;
  final String doctorGender;
  final String doctorImageUrl;
  final String doctorPhoneNumber;

  final String patient_personalUniqueIdentificationId;
  final String patientFullName;
  final String patientGender;
  final String patientImageUrl;
  final String patientPhoneNumber;
  final String patientAilmentDescription;

  AppointmentDetailsInformation({
    required this.registeredTokenId,
    required this.appointmentFees,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.swasthyamitra_personalUniqueIdentificationId,
    required this.isClinicAppointmentType,
    required this.isVideoAppointmentType,
    required this.isTokenActive,
    required this.doctor_personalUniqueIdentificationId,
    required this.doctor_AppointmentUniqueId,
    required this.doctorFullName,
    required this.doctorGender,
    required this.doctorImageUrl,
    required this.doctorPhoneNumber,
    required this.patient_personalUniqueIdentificationId,
    required this.patientFullName,
    required this.patientGender,
    required this.patientImageUrl,
    required this.patientPhoneNumber,
    required this.patientAilmentDescription,
  });
}
