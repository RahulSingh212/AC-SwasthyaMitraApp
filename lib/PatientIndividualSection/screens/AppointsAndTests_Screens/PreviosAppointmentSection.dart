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
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
import 'package:weekday_selector/weekday_selector.dart';

import '../../models/doctor_Info.dart';
import '../../models/token_info.dart';
import '../../providers/bookedAppointmentsAndTests_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';
import 'ViewBookedToken_Screen.dart';

class PreviosAppointmentSection extends StatefulWidget {
  static const routeName = '/patient-previous-appointments-section';

  @override
  State<PreviosAppointmentSection> createState() =>
      _PreviosAppointmentSectionState();
}

class _PreviosAppointmentSectionState extends State<PreviosAppointmentSection> {
  bool isLangEnglish = true;

  @override
  void didChangeDependencies() {
    Provider.of<BookedAppointmentsAndTestDetails>(context)
        .fetchPatientInActivePreviousTokens(context,
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  Future<void> _refreshTheStatusOfBookedTokens(BuildContext context) async {
    Provider.of<BookedAppointmentsAndTestDetails>(context)
        .fetchPatientInActivePreviousTokens(context,
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Provider.of<BookedAppointmentsAndTestDetails>(context)
            .itemsExpiredTokens
            .isEmpty
        ? RefreshIndicator(
            onRefresh: () {
              return _refreshTheStatusOfBookedTokens(context);
            },
            child: Align(
              child: Container(
                alignment: Alignment.center,
                height: screenHeight * 0.25,
                width: screenWidth * 0.8,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.005,
                ),
                child: Text(
                  isLangEnglish
                      ? "No previoius appointments available"
                      : "कोई पिछला अपॉइंटमेंट उपलब्ध नहीं है",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.075,
                    color: Color.fromRGBO(66, 204, 195, 1),
                  ),
                  textAlign: ui.TextAlign.center,
                ),
              ),
            ))
        : ListView.builder(
            itemCount: Provider.of<BookedAppointmentsAndTestDetails>(context)
                    .itemsExpiredTokens
                    .length +
                1,
            itemBuilder: (ctx, index) {
              if (index <
                  Provider.of<BookedAppointmentsAndTestDetails>(context)
                      .itemsExpiredTokens
                      .length) {
                return bookedAppointmentTokenWidget(
                  context,
                  Provider.of<BookedAppointmentsAndTestDetails>(context)
                      .itemsExpiredTokens[index],
                );
              } else {
                return SizedBox(
                  height: screenHeight * 0.1,
                );
              }
            },
          );
  }

  Widget bookedAppointmentTokenWidget(
    BuildContext context,
    BookedTokenSlotInformation tokenInfo,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    int hrs = (tokenInfo.bookedTokenTime.hour % 12);
    if (hrs == 0) {
      hrs = 12;
    }
    int mins = tokenInfo.bookedTokenTime.minute;
    String sig =
        (tokenInfo.bookedTokenTime.hour / 12).ceil() == 0 ? "AM" : "PM";

    String time =
        "${hrs < 10 ? "0" : ""}${hrs}:${mins < 10 ? "0" : ""}${mins} ${sig}";

    return InkWell(
      onTap: () {
        if (tokenInfo.slotType == "appointment") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ViewBookedTokenScreen(
                1,
                tokenInfo,
              ),
            ),
          );
        } else {}
      },
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Container(
          height: tokenInfo.isTokenActive
              ? screenHeight * 0.125
              : screenHeight * 0.135,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.005,
            vertical: screenHeight * 0.0025,
          ),
          margin: EdgeInsets.only(
            bottom: screenHeight * 0.005,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: screenWidth * 0.225,
                margin: EdgeInsets.only(
                  right: screenWidth * 0.005,
                ),
                decoration: BoxDecoration(
                  image: tokenInfo.doctorImageUrl == ""
                      ? DecorationImage(
                          image: AssetImage(
                            'assets/images/surgeon.png',
                          ),
                          fit: BoxFit.fill,
                        )
                      : DecorationImage(
                          image: NetworkImage(tokenInfo.doctorImageUrl),
                          fit: BoxFit.fill,
                        ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Align(
                // fit: BoxFit.fitHeight,
                child: Container(
                  width: screenWidth * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.025,
                          vertical: screenWidth * 0.0025,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.5),
                          color: Color.fromRGBO(66, 204, 195, 1),
                        ),
                        child: Text(
                          "${DateFormat.MMMd().format(tokenInfo.bookedTokenDate).toString()}",
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
                      SizedBox(
                        height: screenHeight * 0.0005,
                      ),
                      Container(
                        child: Text(
                          tokenInfo.doctorFullName
                                      .toLowerCase()
                                      .contains("dr") ||
                                  tokenInfo.doctorFullName.contains("डॉ ")
                              ? tokenInfo.doctorFullName
                              : isLangEnglish
                                  ? "Dr. ${tokenInfo.doctorFullName}"
                                  : "डॉ. ${tokenInfo.doctorFullName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.039,
                            color: Colors.black,
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        child: Text(
                          tokenInfo.slotType == "appointment"
                              ? tokenInfo.doctorSpeciality
                              : tokenInfo.slotType,
                          style: TextStyle(
                            fontSize: screenWidth * 0.0375,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(114, 114, 114, 1),
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.0005,
                      ),
                      Container(
                        child: Text(
                          // "${tokenInfo.bookedTokenTime.format(context)}",
                          "${time}",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(114, 114, 114, 1),
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      !tokenInfo.isTokenActive
                          ? Container(
                              child: Text(
                              isLangEnglish
                                  ? "Appointment Cancelled"
                                  : "अपॉइंटमेंट रद्द",
                              style: TextStyle(
                                fontSize: screenWidth * 0.025,
                                color: Colors.red,
                              ),
                            ))
                          : Container(),
                    ],
                  ),
                ),
              ),
              Container(
                width: minDimension * 0.065,
                alignment: Alignment.topCenter,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.025,
                      vertical: screenHeight * 0.005,
                    ),
                    decoration: BoxDecoration(
                      // color: Color.fromRGBO(66, 204, 195, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        _dateShowerInCalendar(
                          context,
                          tokenInfo.bookedTokenDate,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.0065,
                        ),
                        height: screenHeight * 0.055,
                        width: screenHeight * 0.035,
                        decoration: BoxDecoration(
                            // color: Color.fromRGBO(66, 204, 195, 1),
                            ),
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            "assets/images/Calendar.png",
                          ),
                          color: Color.fromRGBO(108, 117, 125, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _dateShowerInCalendar(BuildContext context, DateTime givenTime) {
    showDatePicker(
      context: context,
      firstDate: givenTime,
      initialDate: givenTime,
      lastDate: givenTime,
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        } else {}
      },
    );
  }
}
