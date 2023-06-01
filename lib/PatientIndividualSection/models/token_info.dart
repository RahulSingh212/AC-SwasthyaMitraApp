// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class BookedTokenSlotInformation {
  final DateTime bookedTokenDate;
  final TimeOfDay bookedTokenTime;
  final String doctor_AppointmentUniqueId;
  final String doctor_personalUniqueIdentificationId;
  final bool isClinicAppointmentType;
  final bool isVideoAppointmentType;
  final bool isTokenActive;
  final String patientAilmentDescription;
  final String prescriptionUrl;
  final String registeredTokenId;
  final DateTime registrationTiming;
  final String doctorFullName;
  final String doctorSpeciality;
  final String doctorImageUrl;
  final int doctorTotalRatings;
  final int patientGivenRatings;
  final String slotType;

  final String testType;
  final String aurigaCareTestCenter;
  final String testReportUrl;
  final double tokenFees;

  
  BookedTokenSlotInformation({
    required this.bookedTokenDate,
    required this.bookedTokenTime,
    required this.doctor_AppointmentUniqueId,
    required this.doctor_personalUniqueIdentificationId,
    required this.isClinicAppointmentType,
    required this.isVideoAppointmentType,
    required this.isTokenActive,
    required this.patientAilmentDescription,
    required this.prescriptionUrl,
    required this.registeredTokenId,
    required this.slotType,
    required this.registrationTiming,
    required this.doctorFullName,
    required this.doctorSpeciality,
    required this.doctorImageUrl,

    required this.doctorTotalRatings,
    required this.patientGivenRatings,
    required this.testType,
    required this.aurigaCareTestCenter,
    required this.testReportUrl,
    required this.tokenFees,
  });
}