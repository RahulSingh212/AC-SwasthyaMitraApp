// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, await_only_futures, unnecessary_brace_in_string_interps, unnecessary_new, prefer_const_constructors, unnecessary_string_interpolations, unused_import, duplicate_import

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:path/path.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/doctor_Info.dart';
import '../models/slot_info.dart';
import '../models/token_info.dart';

class PatientTransactionDetails with ChangeNotifier {
  String SecretKeyForReceivingAccount = "dKkgD6mKUnO6ULiBqKXDdcXL";
  String SecretKeyForTheApplication = "rzp_test_30GMNmjgB5gp2H";
  String orderid = "";
  late Razorpay _razorpay;

  Future<void> executePatientAppointmentTransaction(
    BuildContext context,
    DoctorDetailsInformation doctorDetails,
    DoctorSlotInformation slotInfoDetails,
  ) async {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // Razorpay _razorpay = Razorpay();
  }

  void _handlePaymentSuccess(
      BuildContext context, PaymentSuccessResponse response) {
    final key = utf8.encode(SecretKeyForReceivingAccount);
    final bytes = utf8.encode('$orderid|${response.paymentId}');

    final hmacSha256 = Hmac(sha256, key);
    final Digest generatedSignature = hmacSha256.convert(bytes);

    if (generatedSignature.toString() == response.signature) {
      print('payment successful...');
      // PaynmentSuccessful(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment was unauthentic!"),
        ),
      );
      print("Payment was unauthentic!");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // PaynmentError(context);
    print('Error: payment error');
    print(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('Error: payment error value');
    print(response);
  }

  // Future<void> PaynmentError(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Container(
  //           padding: EdgeInsets.all(25),
  //           height: 300,
  //           width: 150,
  //           child: Column(
  //             children: [
  //               Center(
  //                 child: Text(
  //                   isLangEnglish ? "PAYNMENT UNSUCCESSFUL" : "भुगतान असफल",
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 24,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Center(
  //                 child: Container(
  //                   padding: EdgeInsets.all(12),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(65),
  //                     color: Colors.red,
  //                   ),
  //                   child: CircleAvatar(
  //                     radius: 52,
  //                     backgroundColor: Colors.red,
  //                     child: Icon(
  //                       Icons.sms_failed_outlined,
  //                       size: 60,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> PaynmentSuccessful(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         child: Container(
  //           padding: EdgeInsets.all(25),
  //           height: 300,
  //           width: 150,
  //           child: Column(
  //             children: [
  //               Center(
  //                   child: Text(
  //                 isLangEnglish ? "PAYNMENT SUCCESSFUL" : "भुगतान सफल",
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 24,
  //                 ),
  //               )),
  //               SizedBox(
  //                 height: 20,
  //               ),
  //               Center(
  //                 child: Container(
  //                   padding: EdgeInsets.all(12),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(65),
  //                     color: Color(0xffD3F3F1),
  //                   ),
  //                   child: CircleAvatar(
  //                     radius: 52,
  //                     backgroundColor: AppColors.AppmainColor,
  //                     child: Icon(
  //                       Icons.check,
  //                       size: 60,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> createOrder(
    BuildContext context,
    DoctorDetailsInformation doctorDetails,
    DoctorSlotInformation slotInfoDetails,
    String patientPhoneNumber,
    DateTime bookedTokenDate,
    TimeOfDay bookedTokenTime,
  ) async {
    String username = SecretKeyForTheApplication;
    String password = SecretKeyForReceivingAccount;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    String aptDate =
        "${bookedTokenDate.day}-${bookedTokenDate.month}-${bookedTokenDate.year}";
    String aptTime = bookedTokenTime.toString();

    Map<String, dynamic> body = {
      "amount":
          (slotInfoDetails.appointmentFeesPerPatient.round() * 100).toString(),
      "currency": "INR",
      "receipt": "${slotInfoDetails.slotUniqueId}",
    };
    var res = await http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      print(res.body);
      orderid = jsonDecode(res.body)['id'];
      launchRazorPay(
          orderid, doctorDetails, slotInfoDetails, patientPhoneNumber);
    }
    print(res.body);
  }

  void launchRazorPay(
    String orderid,
    DoctorDetailsInformation doctorDetails,
    DoctorSlotInformation slotInfoDetails,
    String patientPhoneNumber,
  ) {
    var options = {
      'key': SecretKeyForTheApplication,
      'amount':
          (slotInfoDetails.appointmentFeesPerPatient.round() * 100).toString(),
      'name': 'Acme Corp.',
      'order_id': orderid,
      'description': 'Fine T-Shirt',
      'timeout': 60, // in seconds
      'prefill': {'contact': '${patientPhoneNumber}', 'email': ''}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  // OutlineInputBorder _buildBorder(Color color) {
  //   return OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(10),
  //     borderSide: BorderSide(
  //       color: color,
  //       width: 1,
  //     ),
  //   );
  // }

}
