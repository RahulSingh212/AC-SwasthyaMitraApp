// ignore_for_file: unnecessary_this, unused_import, unused_local_variable, unused_field

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:swasthyamitra/providers/SM_User_Details.dart';

import '../../providers/SM_FirebaseLinks_Details.dart';
import 'patientUser_details.dart';

class PatientEmailAuthDetails with ChangeNotifier {
  bool checkExecution = true;
  // static const firebaseDatabaseUniqueKey = "AIzaSyC45IrtkpIbdpvASGqFTi1GWD8MGj0M7Rw";
  late String _emailToken;
  late String _patientExpiryDateTime;
  late String _patientUniqueId;
  String errorMessageValue = "";

  Future<void> signUp(
    BuildContext context,
    String email,
    String password,
  ) async {
    String firebaseDatabaseUniqueKey = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebaseWebApiKey();
    String signUpUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$firebaseDatabaseUniqueKey';

    try {
      final signUpResponse = await http.post(
        Uri.parse(signUpUrl),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(signUpResponse.body);

      if (responseData['error'] != null) {
        this.checkExecution = false;
        errorMessageValue = responseData['error']['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessageValue = responseData['error']['message'],
            ),
          ),
        );
        notifyListeners();
      } else {
        // print(responseData['refreshToken']);
        // print(responseData['expiresIn']);
        Provider.of<PatientUserDetails>(context, listen: false)
            .upLoadNewPatientPersonalInformationViaEmail(
          context,
          responseData['email'],
          responseData['localId'],
        );
      }
    } catch (errorVal) {
      throw errorVal;
    }
  }

  Future<void> signIn(
    BuildContext context,
    String email,
    String password,
  ) async {
    String firebaseDatabaseUniqueKey = Provider.of<SwasthyaMitraFirebaseDetails>(context, listen: false).getFirebaseWebApiKey();
    String signInUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$firebaseDatabaseUniqueKey";

    try {
      final signInResponse = await http.post(
        Uri.parse(signInUrl),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(signInResponse.body);

      // print(responseData['UID']);
      responseData.forEach((key, value) {
        print("Key: $key,\nValue: $value");
      });

      if (responseData['error'] != null) {
        errorMessageValue = responseData['error']['message'];
        notifyListeners();
      } else {
        /// sign in the user
      }
    } catch (errorVal) {
      throw errorVal;
    }
  }
}
