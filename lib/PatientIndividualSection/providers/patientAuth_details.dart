// ignore_for_file: unnecessary_this, unused_import, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../providers/SM_FirebaseLinks_Details.dart';

class PatientAuthDetails with ChangeNotifier {
  // checkEntryType == true, sign-in
  // checkEntryType == false, sign-up
  bool checkEntryType = true;

  setEntryType(bool entryType) {
    this.checkEntryType = entryType;
  }
  bool getEntryType() {
    return this.checkEntryType;
  }

  List<String> existingPatientsPhoneNumberList = [];

  List<String> get getPatientsPhoneNumberList {
    return [...this.existingPatientsPhoneNumberList];
  }

  bool get isPatientsPhoneNumberListEmpty {
    if (this.existingPatientsPhoneNumberList.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getExistingPatientsUserPhoneNumbers(BuildContext context) async {

    Uri urlLink = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebasePathUrl('/PatientsUserPhoneNumberList.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedUserPhoneNumbers = json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedUserPhoneNumbers.toString() != "null") {
        List<String> phoneNumberList = [];
        extractedUserPhoneNumbers.forEach(
          (phoneId, phoneData) {
            phoneNumberList.add(phoneData['patient_PhoneNumber'].toString());
          },
        );

        existingPatientsPhoneNumberList = phoneNumberList;
        notifyListeners();
      }
    } 
    catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<bool> checkIfEnteredNumberExists(
    BuildContext context,
    TextEditingController userPhoneNumber,
  ) 
  async {
    String enteredNumber = userPhoneNumber.text.toString();

    if (this.existingPatientsPhoneNumberList.isEmpty) {
      return false;
    }
    else {
      bool isUserPresent = false;

      bool checkForResponse = await Future.forEach(
        this.existingPatientsPhoneNumberList,
        (phoneNum) {
          if (!isUserPresent && phoneNum.toString() == enteredNumber) {
            isUserPresent = true;
            return true;
          }
        },
      ).then((value) {
        return isUserPresent;
      });

      return checkForResponse;
    }
  }

}