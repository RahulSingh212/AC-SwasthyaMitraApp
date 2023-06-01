// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, unused_import, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unused_element, duplicate_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
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
import 'package:swasthyamitra/providers/SM_DashBoard_Details.dart';

import '../../Helper/constants.dart';
import '../../models/appointment_info.dart';
import '../../providers/SM_Patient_Personal_Details.dart';
import '../../providers/SM_User_Details.dart';
import './SwasthyaMitraAppointmentDescription_Screen.dart';

class AppointmentSectionSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-appointment-section-screen';

  @override
  State<AppointmentSectionSwasthyaMitra> createState() =>
      _AppointmentSectionSwasthyaMitraState();
}

class _AppointmentSectionSwasthyaMitraState
    extends State<AppointmentSectionSwasthyaMitra> {
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

    Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
        .fetchPatientAppointmentList(context);
  }

  Future<void> _refreshTheStatusOfBookedTokens(BuildContext context) async {
    Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
        .fetchPatientAppointmentList(context);
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

    return Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
            .getPatientActiveAppointmentList
            .isEmpty
        ? RefreshIndicator(
            onRefresh: () {
              return _refreshTheStatusOfBookedTokens(context);
            },
            child: Align(
              child: Container(
                alignment: Alignment.center,
                height: screenHeight * 0.2,
                width: screenWidth * 0.8,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.005,
                ),
                child: Text(
                  isLangEnglish
                      ? "No upcoming appointments available"
                      : "कोई आगामी अपॉइंटमेंट उपलब्ध नहीं है",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.075,
                    color: Color.fromRGBO(66, 204, 195, 1),
                  ),
                  textAlign: ui.TextAlign.center,
                ),
              ),
            ),
          )
        : ListView.builder(
            physics: ScrollPhysics(),
            itemCount: Provider.of<SwasthyaMitraDashBoardDetails>(context,
                        listen: false)
                    .itemsPatientActiveAppointmentList
                    .length +
                1,
            itemBuilder: (ctx, index) {
              if (index <
                  Provider.of<SwasthyaMitraDashBoardDetails>(context)
                      .itemsPatientActiveAppointmentList
                      .length) {
                return bookedAppointmentTokenWidget(
                  context,
                  Provider.of<SwasthyaMitraDashBoardDetails>(context)
                      .itemsPatientActiveAppointmentList[index],
                );
              } else {
                return SizedBox(
                  height: screenHeight * 0.05,
                );
              }
            },
          );
  }

  Widget bookedAppointmentTokenWidget(
    BuildContext context,
    AppointmentDetailsInformation tokenInfo,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    return InkWell(
      onTap: () {
        Provider.of<SwasthyaMitraPatientPersonalDetails>(context, listen: false).fetchPatientPersonalUserDetails(context, tokenInfo).then((value) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PatientAppointmentDescriptionScreen(
                1,
                tokenInfo,
              ),
            ),
          );
        });
      },
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            width: screenWidth * 0.95,
            height: maxDimension * 0.125,
            padding: EdgeInsets.symmetric(
              horizontal: minDimension * 0.01,
              vertical: minDimension * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.fill,
                  child: Container(
                    width: minDimension * 0.1125,
                    margin: EdgeInsets.only(
                      right: minDimension * 0.01,
                    ),
                    child: Icon(
                      Icons.watch_later_outlined,
                      size: 50,
                      color: AppColors.AppmainColor,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Container(
                    width: screenWidth * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            child: Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        isLangEnglish ? 'Patient: ' : "मरीज़: ",
                                    style: TextStyle(
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${tokenInfo.patientFullName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            child: Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        isLangEnglish ? 'Doctor: ' : "डाक्टर: ",
                                    style: TextStyle(
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${tokenInfo.doctorFullName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            child: Text(
                              "${tokenInfo.appointmentTime.format(context)}",
                              style: TextStyle(
                                fontSize: screenWidth * 0.0525,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(114, 114, 114, 1),
                              ),
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: screenWidth * 0.15,
                      padding: EdgeInsets.symmetric(
                        // horizontal: screenWidth * 0.025,
                        vertical: screenWidth * 0.015,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.5),
                        color: Color.fromRGBO(66, 204, 195, 1),
                      ),
                      child: Text(
                        "${DateFormat.MMMd().format(tokenInfo.appointmentDate).toString()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
