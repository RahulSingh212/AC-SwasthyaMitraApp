// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, await_only_futures, unnecessary_brace_in_string_interps, unnecessary_new, unnecessary_string_interpolations, duplicate_import, unused_import, prefer_const_constructors

import 'dart:async';
import 'dart:collection';
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
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:swasthyamitra/providers/SM_User_Details.dart';

import '../../models/patient_Info.dart';
import '../../providers/SM_FirebaseLinks_Details.dart';
import '../models/doctor_Info.dart';
import '../models/slot_info.dart';

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay add_15Minutes({int hour = 0, int minute = 15}) {
    if (this.minute + minute >= 60 && this.hour + hour >= 24) {
      return this.replacing(
          hour: (this.hour + hour) % 24, minute: (this.hour + hour) % 60);
    } else {
      return this.replacing(
          hour: this.minute + minute >= 60
              ? this.hour + hour + 1
              : this.hour + hour,
          minute: this.minute + minute >= 60
              ? (this.minute + minute) % 60
              : this.minute + minute);
    }
  }
}

class AppointmentUpdationDetails with ChangeNotifier {
  List<TimeOfDay> _itemsAvailableDuration = [];

  List<TimeOfDay> get items {
    return [..._itemsAvailableDuration];
  }

  Future<void> checkAppointmentDetails(
    BuildContext context,
    DoctorSlotInformation slotInfoDetails,
    DateTime choosenAppointmentDate,
  ) async {
    bool checker = true;
    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    String aptDate =
        "${choosenAppointmentDate.day}-${choosenAppointmentDate.month}-${choosenAppointmentDate.year}";
    String statusUrl =
        "AppointmentStatusDetails/${slotInfoDetails.slotUniqueId}/${aptDate}";

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference aptStatusRef = db.collection("${statusUrl}");

    Uri appointmentStatusLink =
        Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false)
            .getFirebasePathUrl('/${statusUrl}.json');

    try {
      List<TimeOfDay> availableSlots = [];
      final dataBaseResponse = await http.get(appointmentStatusLink);
      Map<String, dynamic> aptStatusMap = {};

      print("Response : " + dataBaseResponse.body.toString());

      if(dataBaseResponse.body.toString() != "null")
        aptStatusMap = json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      DateTime presentDate = DateTime.now();
      TimeOfDay presentTime = TimeOfDay.now();

      if (presentDate.day == choosenAppointmentDate.day &&
          presentDate.month == choosenAppointmentDate.month &&
          presentDate.year == choosenAppointmentDate.year &&
          (presentTime.hour * 60 + presentTime.minute) >=
              (slotInfoDetails.endTime.hour * 60 +
                  slotInfoDetails.endTime.minute)) {
        return;
      }

      if (aptStatusMap.toString() == "null" || aptStatusMap.isEmpty) {
        TimeOfDay startSlotTime = slotInfoDetails.startTime;
        TimeOfDay endSlotTime = slotInfoDetails.endTime;
        TimeOfDay temp = startSlotTime;

        // print("inside");
        while ((temp.hour * 60 + temp.minute) <
            (endSlotTime.hour * 60 + endSlotTime.minute)) {
          if (presentDate.day == choosenAppointmentDate.day &&
              presentDate.month == choosenAppointmentDate.month &&
              presentDate.year == choosenAppointmentDate.year) {
            if ((temp.hour * 60 + temp.minute) >
                (presentTime.hour * 60 + presentTime.minute)) {
              availableSlots.add(temp);
            }
          } else {
            availableSlots.add(temp);
          }
          temp = temp.add_15Minutes();
        }

        this._itemsAvailableDuration = availableSlots;
        notifyListeners();
      } else {
        TimeOfDay startSlotTime = slotInfoDetails.startTime;
        TimeOfDay endSlotTime = slotInfoDetails.endTime;
        TimeOfDay temp = startSlotTime;
        // print(aptStatusMap);

        while ((temp.hour * 60 + temp.minute) <
            (endSlotTime.hour * 60 + endSlotTime.minute)) {
          if (aptStatusMap.containsKey("${temp.toString()}") == false) {
            if (presentDate.day == choosenAppointmentDate.day &&
                presentDate.month == choosenAppointmentDate.month &&
                presentDate.year == choosenAppointmentDate.year) {
              if ((temp.hour * 60 + temp.minute) >
                  (presentTime.hour * 60 + presentTime.minute)) {
                availableSlots.add(temp);
              }
            } else {
              availableSlots.add(temp);
            }
          }
          temp = temp.add_15Minutes();
        }

        this._itemsAvailableDuration = availableSlots;
        notifyListeners();
      }
    } catch (errorVal) {
      print("ErrorVal: ");
      print(errorVal);
    }
  }

  Future<void> savePatientAppointmentSlot(
    BuildContext context,
    bool isClinicApt,
    bool isVideoApt,
    TimeOfDay selectedSlotTime,
    DateTime choosenAppointmentDate,
    String patientAilmentDescription,
    DoctorSlotInformation slotInfo,
    DoctorDetailsInformation doctorDetails,
    PatientDetailsInformation patientDetails,
  ) async {
    String smUniqueId =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .mp["SwasthyaMitra_personalUniqueIdentificationId"]
            .toString();

    String patientSideUrl =
        "PatientBookedAppointList/${patientDetails.patient_personalUniqueIdentificationId}";
    String doctorSideUrl =
        "DoctorBookedAppointList/${doctorDetails.doctor_personalUniqueIdentificationId}";
    // String swasthyaMitraSideUrl =
    //     "SwasthyaMitraBookedAppointList/${smUniqueId}";
    String swasthyaMitraSideUrl = "SwasthyaMitraBookedAppointList";

    String patientSideAppointmentUniqueId = "";
    String doctorSideAppointmentUniqueId = "";

    Uri patientUrlLink =
        Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false)
            .getFirebasePathUrl('/${patientSideUrl}.json');

    Uri doctorUrlLink =
        Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false)
            .getFirebasePathUrl('/${doctorSideUrl}.json');

    String aptDate =
        "${choosenAppointmentDate.day}-${choosenAppointmentDate.month}-${choosenAppointmentDate.year}";
    String statusUrl =
        "AppointmentStatusDetails/${slotInfo.slotUniqueId}/${aptDate}";

    // // used in creating our own value of the "key"
    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    bool isAppointmentCreated = false;

    try {
      mDatabase
          .child("AppointmentStatusDetails")
          .child("${slotInfo.slotUniqueId}")
          .child("${aptDate}")
          .update({
        selectedSlotTime.toString():
            patientDetails.patient_personalUniqueIdentificationId
      }).then(
        (value) async {
          final responseForPatientApt = await http
              .post(
            patientUrlLink,
            body: json.encode(
              {
                'registeredTokenId': DateTime.now().toString(),
                'appointmentDate': choosenAppointmentDate.toString(),
                'appointmentTime': selectedSlotTime.toString(),
                'doctor_AppointmentUniqueId': slotInfo.slotUniqueId.toString(),
                'doctor_personalUniqueIdentificationId': doctorDetails
                    .doctor_personalUniqueIdentificationId
                    .toString(),
                'isClinicAppointmentType': isClinicApt.toString(),
                'isVideoAppointmentType': isVideoApt.toString(),
                'isTokenActive': "true",
                'patientAilmentDescription':
                    patientAilmentDescription.toString(),
                'prescriptionUrl': "",
                'slotType': "appointment",
                'registrationTiming': DateTime.now().toString(),
                'doctorFullName': doctorDetails.doctor_FullName.toString(),
                'doctorSpeciality': doctorDetails.doctor_Speciality.toString(),
                'doctorImageUrl': doctorDetails.doctor_ProfilePicUrl.toString(),
                'doctorTotalRatings':
                    doctorDetails.doctor_TotalExperience.toString(),
                'givenPatientExperienceRating': '0'.toString(),
                'testType': "",
                'aurigaCareTestCenter': "",
                'testReportUrl': "",
                'tokenFees': slotInfo.appointmentFeesPerPatient.toString(),
              },
            ),
          )
              .then(
            (savedResponsePatient) async {
              Uri urlLinkForUpdate = Provider.of<SwasthyaMitraFirebaseDetails>(
                      context,
                      listen: false)
                  .getFirebasePathUrl(
                      '/PatientBookedAppointList/${patientDetails.patient_personalUniqueIdentificationId}/${json.decode(savedResponsePatient.body)["name"]}.json');

              patientSideAppointmentUniqueId =
                  json.decode(savedResponsePatient.body)["name"];
              final responseForPatientTokenDetails = await http
                  .patch(
                urlLinkForUpdate,
                body: json.encode(
                  {
                    'registeredTokenId': json
                        .decode(savedResponsePatient.body)["name"]
                        .toString(),
                  },
                ),
              )
                  .then(
                (value) {
                  mDatabase
                      .child("DoctorBookedAppointList")
                      .child(
                          "${doctorDetails.doctor_personalUniqueIdentificationId}")
                      .child("${patientSideAppointmentUniqueId}")
                      .update(
                    {
                      'registeredTokenId': json
                          .decode(savedResponsePatient.body)["name"]
                          .toString(),
                      'appointmentDate': choosenAppointmentDate.toString(),
                      'appointmentTime': selectedSlotTime.toString(),
                      'doctor_AppointmentUniqueId':
                          slotInfo.slotUniqueId.toString(),
                      'doctor_personalUniqueIdentificationId': doctorDetails
                          .doctor_personalUniqueIdentificationId
                          .toString(),
                      'isClinicAppointmentType': isClinicApt.toString(),
                      'isVideoAppointmentType': isVideoApt.toString(),
                      'isTokenActive': "true",
                      'patientAilmentDescription':
                          patientAilmentDescription.toString(),
                      'prescriptionUrl': "",
                      'slotType': "appointment",
                      'registrationTiming': DateTime.now().toString(),
                      'doctorFullName':
                          doctorDetails.doctor_FullName.toString(),
                      'doctorSpeciality':
                          doctorDetails.doctor_Speciality.toString(),
                      'doctorImageUrl':
                          doctorDetails.doctor_ProfilePicUrl.toString(),
                      'doctorTotalRatings':
                          doctorDetails.doctor_TotalExperience.toString(),
                      'testType': "",
                      'aurigaCareTestCenter': "",
                      'testReportUrl': "",
                      'tokenFees':
                          slotInfo.appointmentFeesPerPatient.toString(),
                      'givenPatientExperienceRating': '0',
                      'patient_personalUniqueIdentificationId': patientDetails
                          .patient_personalUniqueIdentificationId
                          .toString(),
                      'patientFullName':
                          patientDetails.patient_FullName.toString(),
                      'patientImageUrl':
                          patientDetails.patient_ProfilePicUrl.toString(),
                      'patient_Gender':
                          patientDetails.patient_Gender.toString(),
                      'patient_Age': patientDetails.patient_Age.toString(),
                      'patient_Height':
                          patientDetails.patient_Height.toString(),
                      'patient_Weight':
                          patientDetails.patient_Weight.toString(),
                      'patient_BloodGroup':
                          patientDetails.patient_BloodGroup.toString(),
                      'patient_PhoneNumber':
                          patientDetails.patient_PhoneNumber.toString(),
                      'patient_Injuries':
                          patientDetails.patient_Injuries.toString(),
                      'patient_Allergies':
                          patientDetails.patient_Allergies.toString(),
                      'patient_Medication':
                          patientDetails.patient_Medication.toString(),
                      'patient_Surgeries':
                          patientDetails.patient_Surgeries.toLowerCase(),
                    },
                  ).then((value) {
                    mDatabase
                        .child("SwasthyaMitraBookedAppointList")
                        .child("${smUniqueId}")
                        .child("${patientSideAppointmentUniqueId}")
                        .update(
                      {
                        'registeredTokenId': json
                            .decode(savedResponsePatient.body)["name"]
                            .toString(),
                        'appointmentFees':
                            slotInfo.appointmentFeesPerPatient.toString(),
                        'appointmentDate': choosenAppointmentDate.toString(),
                        'appointmentTime': selectedSlotTime.toString(),
                        'swasthyamitra_personalUniqueIdentificationId':
                            smUniqueId.toString(),
                        'isClinicAppointmentType': isClinicApt.toString(),
                        'isVideoAppointmentType': isVideoApt.toString(),
                        'isTokenActive': "true",
                        'doctor_personalUniqueIdentificationId': doctorDetails
                            .doctor_personalUniqueIdentificationId
                            .toString(),
                        'doctor_AppointmentUniqueId':
                            slotInfo.slotUniqueId.toString(),
                        'doctorFullName':
                            doctorDetails.doctor_FullName.toString(),
                        'doctorGender': doctorDetails.doctor_Gender.toString(),
                        'doctorImageUrl':
                            doctorDetails.doctor_ProfilePicUrl.toString(),
                        'doctorPhoneNumber':
                            doctorDetails.doctor_PhoneNumber.toString(),
                        'patient_personalUniqueIdentificationId': patientDetails
                            .patient_personalUniqueIdentificationId
                            .toString(),
                        'patientFullName':
                            patientDetails.patient_FullName.toString(),
                        'patient_Gender':
                            patientDetails.patient_Gender.toString(),
                        'patientImageUrl':
                            patientDetails.patient_ProfilePicUrl.toString(),
                        'patient_PhoneNumber':
                            patientDetails.patient_PhoneNumber.toString(),
                        'patientAilmentDescription':
                            patientAilmentDescription.toString(),
                      },
                    );
                  });
                },
              );
            },
          );
        },
      ).then((value) async {
        var responseVal = await mDatabase
            .child("DoctorPatientDetails")
            .child(doctorDetails.doctor_personalUniqueIdentificationId)
            .child(
                "${patientDetails.patient_personalUniqueIdentificationId.toString()}")
            .update({
          'patient_personalUniqueIdentificationId':
              patientDetails.patient_personalUniqueIdentificationId.toString(),
          'patient_LastBookedAppointmentDate':
              choosenAppointmentDate.toString(),
          'patient_LastBookedAppointmentTime': selectedSlotTime.toString(),
          // 'patient_FullName': mp['patient_FullName'],
          // 'patient_ProfilePicUrl': mp['patient_ProfilePicUrl'],
          // 'patient_Age': mp['patient_Age'],
          // 'patient_Gender': mp['patient_Gender'],
          // 'patient_BloodGroup': mp['patient_BloodGroup'],
          // 'patient_Height': mp['patient_Height'],
          // 'patient_Weight': mp['patient_Weight'],
          // 'patient_PhoneNumber': mp['patient_PhoneNumber'],
        }).then((value) async {
          isAppointmentCreated = true;

          notifyListeners();
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     TabsScreenPatient.routeName, (route) => false);
        });
      });
    } catch (errorVal) {
      print("Error while saving the status of appointment");
      print(errorVal);
    }
  }

  TimeOfDay convertStringToTimeOfDay(String givenTime) {
    int hrVal = int.parse(givenTime.split(":")[0].substring(10));
    int minVal = int.parse(givenTime.split(":")[1].substring(0, 2));
    TimeOfDay time = TimeOfDay(hour: hrVal, minute: minVal);

    return time;
  }
}
