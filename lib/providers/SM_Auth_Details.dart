// ignore_for_file: unnecessary_this, unused_import, duplicate_import, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import "./SM_FirebaseLinks_Details.dart";

class SwasthyaMitraAuthDetails with ChangeNotifier {
  // checkEntryType == true, sign-in
  // checkEntryType == false, sign-up
  bool checkEntryType = true;

  setEntryType(bool entryType) {
    this.checkEntryType = entryType;
  }
  bool getEntryType() {
    return this.checkEntryType;
  }

  List<String> existingSwasthyaMitrasPhoneNumberList = [];

  List<String> get getSwasthyaMitrasPhoneNumberList {
    return [...this.existingSwasthyaMitrasPhoneNumberList];
  }

  bool get isSwasthyaMitrasPhoneNumberListEmpty {
    if (this.existingSwasthyaMitrasPhoneNumberList.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getExistingSwasthyaMitrasUserPhoneNumbers(BuildContext context) async {
    // var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    // var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLink = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebasePathUrl('/SwasthyaMitrasUserPhoneNumberList.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedUserPhoneNumbers = json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedUserPhoneNumbers.toString() != "null") {
        List<String> phoneNumberList = [];
        extractedUserPhoneNumbers.forEach(
          (phoneId, phoneData) {
            phoneNumberList.add(phoneData['SwasthyaMitra_PhoneNumber'].toString());
          },
        );

        existingSwasthyaMitrasPhoneNumberList = phoneNumberList;
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

    if (this.existingSwasthyaMitrasPhoneNumberList.isEmpty) {
      return false;
    }
    else {
      bool isUserPresent = false;

      bool checkForResponse = await Future.forEach(
        this.existingSwasthyaMitrasPhoneNumberList,
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