// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_element, dead_code, void_checks, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/patientUser_details.dart';

class PatientCustomerCareScreen extends StatefulWidget {
  static const routeName = '/patient-customer-care-screen';

  int pageIndex;

  PatientCustomerCareScreen(
    this.pageIndex,
  );

  @override
  State<PatientCustomerCareScreen> createState() =>
      _PatientCustomerCareScreenState();
}

class _PatientCustomerCareScreenState extends State<PatientCustomerCareScreen> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();
    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        title: Text(
          isLangEnglish ? "Customer Care" : "ग्राहक देखभाल",
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
