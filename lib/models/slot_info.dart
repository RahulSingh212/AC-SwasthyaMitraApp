// ignore_for_file: unused_import

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwasthyaMitrSlotInformation {
  final String slotUniqueId;
  final bool isClinic;
  final bool isHome;
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

  final String Type1_Blood_Tests;
  final String Type1_Complete_Blood_Count;
  final String Type1_Liver_Function_Tests;
  final String Type2_Kidney_Function_Tests;
  final String Type2_Lipid_Profile;
  final String Type2_Blood_Sugar_Test;
  final String Type2_Urine_Test;
  final String Type2_Cardiac_Blood_Text;
  final String Type2_Thyroid_Function_Test;
  final String Type3_Blood_Tests_For_Infertility;
  final String Type3_Semen_Analysis_Test;
  final String Type3_Blood_Tests_For_Arthritis;
  final String Type3_Dengu_Serology;
  final String Type3_Chikungunya_Test;
  final String Type3_HIV_Test;
  final String Type3_Pregnancy_Test;
  final String Type3_Stool_Microscopy_Test;
  final String Type3_ESR_Test;

  SwasthyaMitrSlotInformation({
    required this.slotUniqueId,
    required this.isClinic,
    required this.isHome,
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
    
    required this.Type1_Blood_Tests,
    required this.Type1_Complete_Blood_Count,
    required this.Type1_Liver_Function_Tests,
    required this.Type2_Kidney_Function_Tests,
    required this.Type2_Lipid_Profile,
    required this.Type2_Blood_Sugar_Test,
    required this.Type2_Urine_Test,
    required this.Type2_Cardiac_Blood_Text,
    required this.Type2_Thyroid_Function_Test,
    required this.Type3_Blood_Tests_For_Infertility,
    required this.Type3_Semen_Analysis_Test,
    required this.Type3_Blood_Tests_For_Arthritis,
    required this.Type3_Dengu_Serology,
    required this.Type3_Chikungunya_Test,
    required this.Type3_HIV_Test,
    required this.Type3_Pregnancy_Test,
    required this.Type3_Stool_Microscopy_Test,
    required this.Type3_ESR_Test,
  });
}
