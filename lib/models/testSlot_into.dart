// ignore_for_file: unused_import

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SwasthyaMitrTestSlotInformation {
  final String registeredTokenId;
  final DateTime appointmentDate;
  final TimeOfDay appointmentTime;
  final String SwasthyaMitra_TestAppointmentUniqueId;
  final bool isHomeAppointmentType;
  final bool isCenterAppointmentType;
  final bool isTokenActive;
  final String patientAilmentDescription;
  final String patient_personalUniqueIdentificationId;
  final String patientFullName;
  final String patientAddress;
  final DateTime registrationTiming;
  final String testType;
  final String testReportUrl;
  final double tokenTestFees;

  SwasthyaMitrTestSlotInformation({
    required this.registeredTokenId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.SwasthyaMitra_TestAppointmentUniqueId,
    required this.isHomeAppointmentType,
    required this.isCenterAppointmentType,
    required this.isTokenActive,
    required this.patientAilmentDescription,
    required this.patient_personalUniqueIdentificationId,
    required this.patientFullName,
    required this.patientAddress,
    required this.registrationTiming,
    required this.testType,
    required this.testReportUrl,
    required this.tokenTestFees,
  });
}
