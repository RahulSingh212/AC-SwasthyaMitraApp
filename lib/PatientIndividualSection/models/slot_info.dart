// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../HelperStuff/circle_painter.dart';
// import '../../HelperStuff/rounded_rectangle.dart';
// import '../../StarterScreens/qualifications.dart';

// import '../../providers/doctorAuth_details.dart';
// import '../../providers/doctorUser_details.dart';

class DoctorSlotInformation {
  final String slotUniqueId;
  final bool isClinic;
  final bool isVideo;
  final DateTime registeredDate;
  final DateTime expiredDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isRepeat;
  final List<bool> repeatWeekDaysList;
  final bool isSlotActive;
  final Duration patientSlotIntervalDuration;
  final int maximumNumberOfSlots;
  final double appointmentFeesPerPatient;
  final double givenPatientExperienceRating;
  
  DoctorSlotInformation({
    required this.slotUniqueId,
    required this.isClinic,
    required this.isVideo,
    required this.registeredDate,
    required this.expiredDate,
    required this.startTime,
    required this.endTime,
    required this.isRepeat,
    required this.repeatWeekDaysList,
    required this.isSlotActive,
    required this.patientSlotIntervalDuration,
    required this.maximumNumberOfSlots,
    required this.appointmentFeesPerPatient,
    required this.givenPatientExperienceRating,
  });
}