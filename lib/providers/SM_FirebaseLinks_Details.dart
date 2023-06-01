// ignore_for_file: unnecessary_this, unused_import, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SwasthyaMitraFirebaseDetails with ChangeNotifier {
  // String firebaseUrlInUse = "aurigacarehealthapplication-default-rtdb.firebaseio.com"; // -> Rahul Singh
  String firebaseUrlInUse = "aurigacare-dpapplication-default-rtdb.firebaseio.com"; // -> Auriga Care

  // static const firebaseDatabaseUniqueKey = "AIzaSyC45IrtkpIbdpvASGqFTi1GWD8MGj0M7Rw"; // -> Rahul Singh
  String firebaseWebApiKey = "AIzaSyCOmrl9Q82f_hftGYoC5_9uCyOZQsXc_Fc"; // -> Auriga Care

  String getFirebaseUrl() {
    return firebaseUrlInUse;
  }

  String getFirebaseWebApiKey() {
    return firebaseWebApiKey;
  }

  Uri getFirebasePathUrl(String pathLocation) {
    Uri url = Uri.https(
      '${firebaseUrlInUse}',
      '${pathLocation}',
    );

    return url;
  }
}