// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, unused_import, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unused_element, duplicate_import, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/models/slot_info.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../../models/appointment_info.dart';
import '../../providers/SM_DashBoard_Details.dart';
import '../../providers/SM_User_Details.dart';

import '../../models/slot_info.dart';

class EditSwasthyaMitraAppointmentSlotScreen extends StatefulWidget {
  static const routeName = 'swasthya-mitra-edit-schedule-test-screen';

  late SwasthyaMitrSlotInformation scheduleSlotInfo;

  EditSwasthyaMitraAppointmentSlotScreen({required this.scheduleSlotInfo});

  @override
  State<EditSwasthyaMitraAppointmentSlotScreen> createState() => _EditSwasthyaMitraAppointmentSlotScreenState();
}

class _EditSwasthyaMitraAppointmentSlotScreenState extends State<EditSwasthyaMitraAppointmentSlotScreen> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish = isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


  }
  
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    var _padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height) -
        _padding.top -
        _padding.bottom -
        kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: Color(0xFFf2f3f4),
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          enableFeedback: false,
          onPressed: () {
            // Navigator.of(context).pushReplacementNamed(MyProfileScreen.routeName);
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Color(0xff42ccc3),
            size: 35,
          ),
        ),
        title: Text(
          isLangEnglish ? "Edit Schedule" : "अनुसूची संपादित करें",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(),
    );
  }
}