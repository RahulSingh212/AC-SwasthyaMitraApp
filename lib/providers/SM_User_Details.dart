// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, await_only_futures, unnecessary_brace_in_string_interps, duplicate_import, unused_import, avoid_print

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
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../PatientIndividualSection/models/token_info.dart';
import '../models/patient_Info.dart';
import '../screens/Tab_Screen.dart';
import 'SM_FirebaseLinks_Details.dart';

class SwasthyaMitraUserDetails with ChangeNotifier {
  bool isReadingLangEnglish = true;
  Map<String, String> mp = {};
  String loggedInSwasthyaMitraUserUniqueCred = "";
  bool SwasthyaMitra_LanguageType = true; // English: true, Hindi: false
  String mobileMessagingToken = "";

  Map<String, bool> swasthyaMitraAvailableTestsMapping = {
    "Type1_Blood_Tests": false,
    "Type1_Complete_Blood_Count": false,
    "Type1_Liver_Function_Tests": false,
    "Type2_Kidney_Function_Tests": false,
    "Type2_Lipid_Profile": false,
    "Type2_Blood_Sugar_Test": false,
    "Type2_Urine_Test": false,
    "Type2_Cardiac_Blood_Text": false,
    "Type2_Thyroid_Function_Test": false,
    "Type3_Blood_Tests_For_Infertility": false,
    "Type3_Semen_Analysis_Test": false,
    "Type3_Blood_Tests_For_Arthritis": false,
    "Type3_Dengu_Serology": false,
    "Type3_Chikungunya_Test": false,
    "Type3_HIV_Test": false,
    "Type3_Pregnancy_Test": false,
    "Type3_Stool_Microscopy_Test": false,
    "Type3_ESR_Test": false,
  };

  setSwasthyaMitraLanguageType(bool isEnglish) {
    this.SwasthyaMitra_LanguageType = isEnglish;
  }

  bool getSwasthyaMitraLanguageType() {
    return this.SwasthyaMitra_LanguageType;
  }

  setSwasthyaMitraUserPersonalInformation(
      Map<String, String> SwasthyaMitraMap) {
    this.mp = SwasthyaMitraMap;
  }

  Map<String, String> getSwasthyaMitraUserPersonalInformation() {
    return mp;
  }

  String getLoggedInUserUniqueId() {
    return this.loggedInSwasthyaMitraUserUniqueCred;
  }

  late TextEditingController SwasthyaMitraMobileNumber;
  setSwasthyaMitraMobileNumber(TextEditingController mobileNumber) {
    this.SwasthyaMitraMobileNumber = mobileNumber;
  }

  TextEditingController getSwasthyaMitraMobileNumber() {
    return this.SwasthyaMitraMobileNumber;
  }

  late TextEditingController SwasthyaMitraCenterName;
  setSwasthyaMitraCenterName(TextEditingController fullName) {
    this.SwasthyaMitraCenterName = fullName;
  }

  TextEditingController getSwasthyaMitraCenterName() {
    return this.SwasthyaMitraCenterName;
  }

  Future<void> upLoadNewSwasthyaMitraPersonalInformation(
    BuildContext context,
    UserCredential authCredential,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef =
        db.collection("SwasthyaMitrasUserPhoneNumberList");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLinkForPhoneNumbers =
        Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false)
            .getFirebasePathUrl('/SwasthyaMitrasUserPhoneNumberList.json');

    final responseForAddingNewDoctorUser = await http.post(
      urlLinkForPhoneNumbers,
      body: json.encode(
        {
          'SwasthyaMitra_personalUniqueIdentificationId':
              loggedInUserId.toString(),
          'SwasthyaMitra_PhoneNumber':
              this.SwasthyaMitraMobileNumber.text.toString(),
        },
      ),
    );

    try {
      final submissionResponse = await FirebaseFirestore.instance
          .collection('SwasthyaMitraUsersPersonalInformation')
          .doc(authCredential.user?.uid)
          .set(
        {
          'SwasthyaMitra_AcceptingRequestStatus': "false",
          'SwasthyaMitra_AuthorizationStatus': "false",
          'SwasthyaMitra_LanguageType': isReadingLangEnglish ? "true" : "false",
          'SwasthyaMitra_personalUniqueIdentificationId':
              loggedInUserId.toString(),
          'SwasthyaMitra_CenterName':
              this.SwasthyaMitraCenterName.text.toString(),
          'SwasthyaMitra_CenterAdminName': "",
          'SwasthyaMitra_PhoneNumber':
              this.SwasthyaMitraMobileNumber.text.toString(),
          'SwasthyaMitra_AddressDetails': "",
          'SwasthyaMitra_CurrentCity': "",
          'SwasthyaMitra_CurrentCityPinCode': "",
          'SwasthyaMitra_MobileMessagingTokenId': "",
          'SwasthyaMitra_ProfilePicUrl': "",
          'SwasthyaMitra_ProfileCreationTime': DateTime.now().toString(),
          'SwasthyaMitra_ProfilePermission': 'true',
          "Type1_Blood_Tests": "false",
          "Type1_Complete_Blood_Count": "false",
          "Type1_Liver_Function_Tests": "false",
          "Type2_Kidney_Function_Tests": "false",
          "Type2_Lipid_Profile": "false",
          "Type2_Blood_Sugar_Test": "false",
          "Type2_Urine_Test": "false",
          "Type2_Cardiac_Blood_Text": "false",
          "Type2_Thyroid_Function_Test": "false",
          "Type3_Blood_Tests_For_Infertility": "false",
          "Type3_Semen_Analysis_Test": "false",
          "Type3_Blood_Tests_For_Arthritis": "false",
          "Type3_Dengu_Serology": "false",
          "Type3_Chikungunya_Test": "false",
          "Type3_HIV_Test": "false",
          "Type3_Pregnancy_Test": "false",
          "Type3_Stool_Microscopy_Test": "false",
          "Type3_ESR_Test": "false",
        },
      ).then((value) {
        setSwasthyaMitraUserInfo(context);
      });

      // Navigator.of(context).pushReplacementNamed(TabsScreenSwasthyaMitra.routeName);
      // Navigator.of(context).pop(false);
      // setSwasthyaMitraUserInfo(context);
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> setSwasthyaMitraUserInfo(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef =
        db.collection("SwasthyaMitraUsersPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    if (mp.isEmpty) {
      var currLoggedInUser = await FirebaseAuth.instance.currentUser;
      var loggedInUserId = currLoggedInUser?.uid as String;

      this.loggedInSwasthyaMitraUserUniqueCred = loggedInUserId;

      print(await FirebaseFirestore.instance
          .collection('SwasthyaMitraUsersPersonalInformation')
          .doc(loggedInUserId)
          .get());

      var response = await FirebaseFirestore.instance
          .collection('SwasthyaMitraUsersPersonalInformation')
          .doc(loggedInUserId)
          .get()
          .then(
        (DocumentSnapshot ds) {
          String SwasthyaMitra_AcceptingRequestStatus = "";
          String SwasthyaMitra_LanguageType = "";
          String SwasthyaMitra_personalUniqueIdentificationId = "";
          String SwasthyaMitra_AuthorizationStatus = "";
          String SwasthyaMitra_ProfilePermission = "";

          String SwasthyaMitra_CenterName = "";
          String SwasthyaMitra_CenterAdminName = "";
          String SwasthyaMitra_PhoneNumber = "";

          String SwasthyaMitra_CurrentCity = "";
          String SwasthyaMitra_CurrentCityPinCode = "";
          String SwasthyaMitra_AddressDetails = "";

          String SwasthyaMitra_ProfilePicUrl = "";
          String SwasthyaMitra_ProfileCreationTime = "";

          String Type1_Blood_Tests = "";
          String Type1_Complete_Blood_Count = "";
          String Type1_Liver_Function_Tests = "";

          String Type2_Kidney_Function_Tests = "";
          String Type2_Lipid_Profile = "";
          String Type2_Blood_Sugar_Test = "";
          String Type2_Urine_Test = "";
          String Type2_Cardiac_Blood_Text = "";
          String Type2_Thyroid_Function_Test = "";

          String Type3_Blood_Tests_For_Infertility = "";
          String Type3_Semen_Analysis_Test = "";
          String Type3_Blood_Tests_For_Arthritis = "";
          String Type3_Dengu_Serology = "";
          String Type3_Chikungunya_Test = "";
          String Type3_HIV_Test = "";
          String Type3_Pregnancy_Test = "";
          String Type3_Stool_Microscopy_Test = "";
          String Type3_ESR_Test = "";

          swasthyaMitraAvailableTestsMapping['Type1_Blood_Tests'] =
              ds.get('Type1_Blood_Tests').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type1_Complete_Blood_Count'] =
              ds.get('Type1_Complete_Blood_Count').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type1_Liver_Function_Tests'] =
              ds.get('Type1_Liver_Function_Tests').toString() == 'true';

          swasthyaMitraAvailableTestsMapping['Type2_Kidney_Function_Tests'] =
              ds.get('Type2_Kidney_Function_Tests').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type2_Lipid_Profile'] =
              ds.get('Type2_Lipid_Profile').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type2_Blood_Sugar_Test'] =
              ds.get('Type2_Blood_Sugar_Test').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type2_Urine_Test'] =
              ds.get('Type2_Urine_Test').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type2_Cardiac_Blood_Text'] =
              ds.get('Type2_Cardiac_Blood_Text').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type2_Thyroid_Function_Test'] =
              ds.get('Type2_Thyroid_Function_Test').toString() == 'true';

          swasthyaMitraAvailableTestsMapping[
                  'Type3_Blood_Tests_For_Infertility'] =
              ds.get('Type3_Blood_Tests_For_Infertility').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type3_Semen_Analysis_Test'] =
              ds.get('Type3_Semen_Analysis_Test').toString() == 'true';
          swasthyaMitraAvailableTestsMapping[
                  'Type3_Blood_Tests_For_Arthritis'] =
              ds.get('Type3_Blood_Tests_For_Arthritis').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type3_Dengu_Serology'] =
              ds.get('Type3_Dengu_Serology').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type3_Chikungunya_Test'] =
              ds.get('Type3_Chikungunya_Test').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type3_HIV_Test'] =
              ds.get('Type3_HIV_Test').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type3_Pregnancy_Test'] =
              ds.get('Type3_Pregnancy_Test').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type3_Stool_Microscopy_Test'] =
              ds.get('Type3_Stool_Microscopy_Test').toString() == 'true';
          swasthyaMitraAvailableTestsMapping['Type3_ESR_Test'] =
              ds.get('Type3_ESR_Test').toString() == 'true';

          SwasthyaMitra_AcceptingRequestStatus =
              ds.get('SwasthyaMitra_AcceptingRequestStatus').toString();
          SwasthyaMitra_LanguageType =
              ds.get('SwasthyaMitra_LanguageType').toString();
          SwasthyaMitra_personalUniqueIdentificationId =
              ds.get('SwasthyaMitra_personalUniqueIdentificationId').toString();
          SwasthyaMitra_AuthorizationStatus =
              ds.get('SwasthyaMitra_AuthorizationStatus').toString();
          SwasthyaMitra_ProfilePermission =
              ds.get('SwasthyaMitra_ProfilePermission').toString();

          SwasthyaMitra_CenterName =
              ds.get('SwasthyaMitra_CenterName').toString();
          SwasthyaMitra_CenterAdminName =
              ds.get('SwasthyaMitra_CenterAdminName').toString();
          SwasthyaMitra_PhoneNumber =
              ds.get('SwasthyaMitra_PhoneNumber').toString();

          SwasthyaMitra_CurrentCity =
              ds.get('SwasthyaMitra_CurrentCity').toString();
          SwasthyaMitra_CurrentCityPinCode =
              ds.get('SwasthyaMitra_CurrentCityPinCode').toString();
          SwasthyaMitra_AddressDetails =
              ds.get('SwasthyaMitra_AddressDetails').toString();

          SwasthyaMitra_ProfilePicUrl =
              ds.get('SwasthyaMitra_ProfilePicUrl').toString();
          SwasthyaMitra_ProfileCreationTime =
              ds.get('SwasthyaMitra_ProfileCreationTime').toString();

          isReadingLangEnglish = (SwasthyaMitra_LanguageType == 'true');

          mp['SwasthyaMitra_AcceptingRequestStatus'] =
              SwasthyaMitra_AcceptingRequestStatus;
          mp['SwasthyaMitra_LanguageType'] = SwasthyaMitra_LanguageType;
          mp["SwasthyaMitra_personalUniqueIdentificationId"] =
              SwasthyaMitra_personalUniqueIdentificationId;
          mp['SwasthyaMitra_AuthorizationStatus'] =
              SwasthyaMitra_AuthorizationStatus;
          mp['SwasthyaMitra_ProfilePermission'] =
              SwasthyaMitra_ProfilePermission;

          mp["SwasthyaMitra_CenterName"] = SwasthyaMitra_CenterName;
          mp["SwasthyaMitra_CenterAdminName"] = SwasthyaMitra_CenterAdminName;
          mp["SwasthyaMitra_PhoneNumber"] = SwasthyaMitra_PhoneNumber;

          mp["SwasthyaMitra_AddressDetails"] = SwasthyaMitra_AddressDetails;
          mp["SwasthyaMitra_CurrentCity"] = SwasthyaMitra_CurrentCity;
          mp["SwasthyaMitra_CurrentCityPinCode"] =
              SwasthyaMitra_CurrentCityPinCode;

          mp["SwasthyaMitra_ProfilePicUrl"] = SwasthyaMitra_ProfilePicUrl;
          mp["SwasthyaMitra_ProfileCreationTime"] =
              SwasthyaMitra_ProfileCreationTime;
        },
      ).then((value) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            TabsScreenSwasthyaMitra.routeName, (route) => false);
        notifyListeners();
      });
    }
  }

  Future<void> updateSwasthyaMitraUserPersonalInformation(
    BuildContext context,
    String labelText,
    String updatedText,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef =
        db.collection("SwasthyaMitraUsersPersonalInformation");

    // var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    // var loggedInUserId = currLoggedInUser?.uid as String;

    var loggedInUserId =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .mp["SwasthyaMitra_personalUniqueIdentificationId"];

    db
        .collection("SwasthyaMitraUsersPersonalInformation")
        .doc(loggedInUserId)
        .update({labelText: updatedText}).then((value) {
      mp[labelText] = updatedText;
    });

    // Navigator.of(context).pushNamedAndRemoveUntil(TabsScreenSwasthyaMitra.routeName, (route) => false);
    notifyListeners();
  }

  Future<void> updateSwasthyaMitraProfilePicture(
    BuildContext context,
    File profilePicFile,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef =
        db.collection("SwasthyaMitraUsersPersonalInformation");

    var loggedInUserId =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .mp["SwasthyaMitra_personalUniqueIdentificationId"];

    Uri urlLinkForProfilePic = Provider.of<SwasthyaMitraFirebaseDetails>(
            context,
            listen: false)
        .getFirebasePathUrl(
            '/SwasthyaMitraStorageDetails/$loggedInUserId/SwasthyaMitraProfilePicture.json');

    String imageName = "${loggedInUserId}_profilePic.jpg";
    final profilePicture = FirebaseStorage.instance
        .ref()
        .child(
            'SwasthyaMitraStorageDetails/$loggedInUserId/SwasthyaMitraProfilePicture')
        .child(imageName);

    try {
      if (mp['SwasthyaMitra_ProfilePicUrl'] == '') {
        final imageUploadResponse =
            await profilePicture.putFile(profilePicFile);
        mp['SwasthyaMitra_ProfilePicUrl'] =
            await profilePicture.getDownloadURL();
        db
            .collection("SwasthyaMitraUsersPersonalInformation")
            .doc(loggedInUserId)
            .update({
          "SwasthyaMitra_ProfilePicUrl": mp['SwasthyaMitra_ProfilePicUrl']
        });
      } else {
        final existingImageRef = FirebaseStorage.instance.ref();
        final deletingFileResponse = await existingImageRef
            .child(
                'SwasthyaMitraStorageDetails/$loggedInUserId/SwasthyaMitraProfilePicture/${loggedInUserId}_profilePic.jpg')
            .delete();

        final imageUploadResponse =
            await profilePicture.putFile(profilePicFile);
        mp['SwasthyaMitra_ProfilePicUrl'] =
            await profilePicture.getDownloadURL();
        db
            .collection("SwasthyaMitraUsersPersonalInformation")
            .doc(loggedInUserId)
            .update({
          "SwasthyaMitra_ProfilePicUrl": mp['SwasthyaMitra_ProfilePicUrl']
        });

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     TabsScreenSwasthyaMitra.routeName, (route) => false);
        notifyListeners();
      }
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> uploadPatientPrescription(
    BuildContext context,
    PatientDetailsInformation patientDetails,
    File documentPdfFile,
  ) async {
    print("2");
    print(documentPdfFile.path);
    String refLink =
        "SwasthyaMitraReportsAndPrescriptionsDetails/${patientDetails.patient_personalUniqueIdentificationId}";

    try {
      String documentFileName =
          "P_${DateTime.now().toString()}.pdf";
      final documentFile = FirebaseStorage.instance.ref().child(refLink).child(documentFileName);

      final documentUploadResponse = await documentFile.putFile(documentPdfFile).then((p0) {
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     TabsScreenSwasthyaMitra.routeName, (route) => false);
      });
    } catch (errorVal) {
      print(errorVal);
    }
  }

  // Future<void> updateSwasthyaMitraPrescription(
  //   BuildContext context,
  //   BookedTokenSlotInformation tokenInfo,
  //   File documentPdfFile,
  // ) async {
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   CollectionReference usersRef =
  //       db.collection("SwasthyaMitraUsersPersonalInformation");

  //   var currLoggedInUser = await FirebaseAuth.instance.currentUser;
  //   var loggedInUserId = currLoggedInUser?.uid as String;

  //   String aptDate = "${tokenInfo.bookedTokenDate.day}-${tokenInfo.bookedTokenDate.month}-${tokenInfo.bookedTokenDate.year}";
  //   String aptTime = tokenInfo.bookedTokenTime.toString();
  //   String refLink = "SwasthyaMitraReportsAndPrescriptionsDetails/${loggedInUserId}/${tokenInfo.doctor_personalUniqueIdentificationId}/${tokenInfo.doctor_AppointmentUniqueId}/${aptDate}/${aptTime}/SwasthyaMitraPreviousPrescription";

  //   Future<ListResult> futureFiles = FirebaseStorage.instance.ref('/${refLink}').listAll();

  //   DateTime cT = DateTime.now();
  //   String pth =
  //       "${cT.day}-${cT.month}-${cT.year}-${cT.hour}-${cT.minute}-${cT.second}";
  //   if (futureFiles.toString() == null) {
  //     try {
  //       String documentFileName =
  //           "myPrescription.pdf";
  //       final documentFile = FirebaseStorage.instance
  //           .ref()
  //           .child(refLink)
  //           .child(documentFileName);

  //       final documentUploadResponse =
  //           await documentFile.putFile(documentPdfFile);
  //     } catch (errorVal) {
  //       print(errorVal);
  //     }
  //   } else {
  //     final existingDocumentRef = FirebaseStorage.instance.ref();
  //     final deletingFileResponse = await existingDocumentRef
  //         .child('${refLink}/myPrescription.pdf')
  //         .delete()
  //         .then((value) async {
  //       String documentFileName = "myPrescription.pdf";
  //       final documentFile = FirebaseStorage.instance
  //           .ref()
  //           .child(refLink)
  //           .child(documentFileName);

  //       final documentUploadResponse =
  //           await documentFile.putFile(documentPdfFile);
  //     });
  //   }
  // }

  // Future<void> uploadSwasthyaMitraAppointmentPrescription(
  //   BuildContext context,
  //   BookedTokenSlotInformation tokenInfo,
  //   File documentPdfFile,
  // ) async {
  //   // FirebaseFirestore db = FirebaseFirestore.instance;
  //   // CollectionReference usersRef = db.collection("SwasthyaMitraUsersPersonalInformation");

  //   // var currLoggedInUser = await FirebaseAuth.instance.currentUser;
  //   // var loggedInUserId = currLoggedInUser?.uid as String;

  //   String pid = this.mp['SwasthyaMitra_personalUniqueIdentificationId'] ?? "";

  //   String aptDate = "${tokenInfo.bookedTokenDate.day}-${tokenInfo.bookedTokenDate.month}-${tokenInfo.bookedTokenDate.year}";
  //   String aptTime = tokenInfo.bookedTokenTime.toString();
  //   String refLink = "SwasthyaMitraReportsAndPrescriptionsDetails/${pid}/${tokenInfo.doctor_personalUniqueIdentificationId}/${tokenInfo.registeredTokenId}/${aptDate}/${aptTime}/SwasthyaMitraPreviousPrescription";

  //       try {
  //       String documentFileName = "myPrescriptionFile.pdf";
  //       final documentFile = FirebaseStorage.instance
  //           .ref()
  //           .child(refLink)
  //           .child(documentFileName);

  //       final documentUploadResponse = await documentFile.putFile(documentPdfFile).then((p0) {
  //         Navigator.of(context).pushNamedAndRemoveUntil(TabsScreenSwasthyaMitra.routeName, (route) => false);
  //       });
  //     } catch (errorVal) {
  //       print(errorVal);
  //     }

  //   // Future<ListResult> futureFiles = FirebaseStorage.instance.ref('/${refLink}').listAll();

  //   // DateTime cT = DateTime.now();
  //   // String pth =
  //   //     "${cT.day}-${cT.month}-${cT.year}-${cT.hour}-${cT.minute}-${cT.second}";
  //   // if (futureFiles.toString() == null) {
  //   //   try {
  //   //     String documentFileName = "doctorPrescriptionFile.pdf";
  //   //     final documentFile = FirebaseStorage.instance
  //   //         .ref()
  //   //         .child(refLink)
  //   //         .child(documentFileName);

  //   //     final documentUploadResponse =
  //   //         await documentFile.putFile(documentPdfFile);
  //   //   } catch (errorVal) {
  //   //     print(errorVal);
  //   //   }
  //   // } else {
  //   //   try {
  //   //   final existingDocumentRef = FirebaseStorage.instance.ref();
  //   //   final deletingFileResponse = await existingDocumentRef
  //   //       .child('${refLink}/doctorPrescriptionFile.pdf')
  //   //       .delete()
  //   //       .then((value) async {
  //   //     String documentFileName =
  //   //         "doctorPrescriptionFile.pdf";
  //   //     final documentFile = FirebaseStorage.instance
  //   //         .ref()
  //   //         .child(refLink)
  //   //         .child(documentFileName);

  //   //     final documentUploadResponse = await documentFile.putFile(documentPdfFile).then((p0) {
  //   //       Navigator.of(context).pushNamedAndRemoveUntil(TabsScreenDoctor.routeName, (route) => false);
  //   //     });
  //   //   });
  //   //   }
  //   //   catch (errorVal) {
  //   //     print(errorVal);
  //   //   }
  //   // }
  // }

}
