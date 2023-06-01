// ignore_for_file: prefer_const_constructors, deprecated_member_use, unused_import, duplicate_import, unused_local_variable

import 'dart:async';
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
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../Helper/constants.dart';
import '../../Navigation_Page/BookTest.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';

class BookYourNewTestScreen extends StatefulWidget {
  static const routeName = '/patient-book-your-new-test-screen';

  @override
  State<BookYourNewTestScreen> createState() => _BookYourNewTestScreenState();
}

class _BookYourNewTestScreenState extends State<BookYourNewTestScreen> {
  bool isLangEnglish = true;
  int amount = 600;
  late String orderid;
  late Razorpay _razorpay;
  String choosenTestType = "Blood Tests";
  String choosenCenterType = "Auriga Centre 1";

  List<String> TestType = [
    "Blood Tests",
    "Complete Blood Count",
    "Liver Function Test",
    "Kidney Function Test",
    "Lipid Profile",
    "Blood Sugar Test",
    "Urine Test",
    "Cardiac Blood Test",
    "Height"
  ];

  List<String> AurigaCenter = [
    "Auriga Centre 1",
    "Auriga Centre 2",
    "Auriga Centre 3",
    "Auriga Centre 4",
    "Auriga Centre 5"
  ];

  String generateRnadom() {
    int noofletter = 20;
    String uppercaseletter = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String lowercaseletter = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '0123456789';
    String specialchars = '!@#%^&*()~?';
    String chars = '';

    return List.generate(noofletter, (index) {
      final ran = Random.secure().nextInt(chars.length);
      return chars[ran];
    }).join('');
  }

  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final key = utf8.encode(Seckretkey);
    final bytes = utf8.encode('$orderid|${response.paymentId}');

    final hmacSha256 = Hmac(sha256, key);
    final Digest generatedSignature = hmacSha256.convert(bytes);

    if (generatedSignature.toString() == response.signature) {
      PaynmentSuccessful(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Payment was unauthentic!"),
      ));
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
      print("Payment was unauthentic!");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    PaynmentError(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
  }

  Future<void> PaynmentError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(25),
            height: 300,
            width: 150,
            child: Column(
              children: [
                Center(
                  child: Text(
                    isLangEnglish ? "PAYNMENT UNSUCCESSFUL" : "भुगतान असफल",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(65),
                      color: Colors.red,
                    ),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.sms_failed_outlined,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> PaynmentSuccessful(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(25),
            height: 300,
            width: 150,
            child: Column(
              children: [
                Center(
                    child: Text(
                  isLangEnglish ? "PAYNMENT SUCCESSFUL" : "भुगतान सफल",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(65),
                      color: Color(0xffD3F3F1),
                    ),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: AppColors.AppmainColor,
                      child: Icon(
                        Icons.check,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> createOrder() async {
    String username = mykey;
    String password = Seckretkey;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": (amount * 100).toString(),
      "currency": "INR",
      "receipt": "rcptid_11"
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
      setState(() {
        orderid = jsonDecode(res.body)['id'];
      });
      launchRazorPay(orderid);
    }
    print(res.body);
  }

  void launchRazorPay(String orderid) {
    var options = {
      'key': mykey,
      'amount': (amount * 100).toString(),
      'name': 'Acme Corp.',
      'order_id': orderid,
      'description': 'Fine T-Shirt',
      'timeout': 60, // in seconds
      'prefill': {'contact': '7206117880', 'email': 'harsh20061@iiitd.ac.in'}
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

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
        width: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: 0.065 * _height,
            right: 0.055555 * _width,
            left: 0.055555 * _width),
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.AppmainColor,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                SizedBox(
                  width: 0.0277777 * _width,
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff2c2c2c),
                    fontWeight: FontWeight.bold,
                  ),
                  child: Text(
                    isLangEnglish ? "Book New Test" : "नया टेस्ट बुक करें",
                  ),
                ),

                SizedBox(
                  width: 0.041666 * _width,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     image: DecorationImage(image: AssetImage("img/Vector.png"),
                //       fit: BoxFit.cover
                //     ),
                //   ),
                // ),
                Icon(
                  Icons.text_snippet,
                  color: AppColors.AppmainColor,
                  size: 34,
                ),
              ],
            ),
            SizedBox(
              height: 0.01023 * _height,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff929292),
                fontWeight: FontWeight.w400,
              ),
              child: Text(
                isLangEnglish
                    ? "Select the test type and the appropriate date and time to book a new test"
                    : "एक नया परीक्षण बुक करने के लिए परीक्षण प्रकार और उपयुक्त तिथि और समय का चयन करें",
              ),
            ),
            SizedBox(
              height: 0.044757 * _height,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 24,
                color: Color(0xff2c2c2c),
                fontWeight: FontWeight.w500,
              ),
              child: Text(
                isLangEnglish ? "Test Type" : "परीक्षण प्रकार",
              ),
            ),

            SizedBox(
              height: 0.006393 * _height,
            ),
            // DropDownMenu

            DropdownButtonFormField(
              autofocus: false,

              decoration: InputDecoration(
                focusedBorder: _buildBorder(Color(0xff42CCC3)),
                border: _buildBorder(
                  Color(0xffEBEBEB),
                ),
                label: Text(
                  isLangEnglish ? "Select" : "चुनिए",
                  style: TextStyle(color: Color(0xff42CCC3)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              focusColor: Colors.white,
              value: choosenTestType,
              //elevation: 5,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: TestType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  choosenTestType = value as String;
                });
              },
              hint: Text(
                isLangEnglish ? "Select Test Type" : "परीक्षण प्रकार चुनें",
                style: TextStyle(color: Color(0xff6C757D), fontSize: 15),
              ),
            ),

            SizedBox(
              height: 0.048593 * _height,
            ),
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 24,
                color: Color(0xff2c2c2c),
                fontWeight: FontWeight.w500,
              ),
              child: Text(
                isLangEnglish
                    ? "Select Auriga Centre"
                    : "ऑरिगा सेंटर का चयन करें",
              ),
            ),

            SizedBox(
              height: 0.0063938 * _height,
            ),
            // DropDownMenu
            DropdownButtonFormField(
              autofocus: false,

              decoration: InputDecoration(
                focusedBorder: _buildBorder(Color(0xff42CCC3)),
                border: _buildBorder(Color(0xffEBEBEB)),
                label: Text(
                  isLangEnglish ? "Select" : "चुनिए",
                  style: TextStyle(color: Color(0xff42CCC3)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              focusColor: Colors.white,
              value: choosenCenterType,
              //elevation: 5,
              style: TextStyle(
                color: Colors.white,
              ),
              iconEnabledColor: Colors.black,
              items: AurigaCenter.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  choosenCenterType = value as String;
                });
              },
              hint: Text(
                isLangEnglish ? "Select Test Type" : "परीक्षण प्रकार चुनें",
                style: TextStyle(
                  color: Color(0xff6C757D),
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.AppmainColor,
        onPressed: () {
          if (choosenTestType == "") {
            String titleText =
                isLangEnglish ? "Invalid Test Type" : "अमान्य परीक्षण प्रकार";
            String contextText = isLangEnglish
                ? "Please select your Test Type..."
                : "कृपया अपना परीक्षण प्रकार चुनें...";
            _checkForError(context, titleText, contextText);
          } else if (choosenCenterType == "") {
            String titleText =
                isLangEnglish ? "Invalid Auriga Center" : "अमान्य औरिगा केंद्र";
            String contextText = isLangEnglish
                ? "Please select your Auriga Center..."
                : "कृपया अपने औरिगा केंद्र का चयन करें...";
            _checkForError(context, titleText, contextText);
          } else {
            calldialog();
          }
        },
        child: Icon(
          Icons.arrow_forward,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  calldialog() {
    _paynment2DialogBox(context);
  }

  Future _paynment2DialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          var _padding = MediaQuery.of(context).padding;
          double _width = (MediaQuery.of(context).size.width);
          double _height = (MediaQuery.of(context).size.height) - _padding.top;
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 402,
              width: 267,
              padding: EdgeInsets.only(
                left: 0.05555555 * _width,
                right: 0.05555555 * _width,
                top: 0.025575 * _height,
                bottom: 0.025575 * _height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      isLangEnglish ? "Booking Confirmed" : "निश्चित आरक्षण",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 0.035805 * _height,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 0.033333 * _width,
                        right: 0.033333 * _width,
                        top: 0.015345 * _height,
                        bottom: 0.015345 * _height,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(65),
                        color: Color(0xffD3F3F1),
                      ),
                      child: CircleAvatar(
                        radius: 52,
                        backgroundColor: AppColors.AppmainColor,
                        child: Icon(
                          Icons.check,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 0.0127877 * _height,
                  ),

                  //Check box banana ha

                  Text(
                    isLangEnglish
                        ? "Liver Function Test"
                        : "जिगर कार्य परीक्षण",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff2c2c2c),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Color(0xffD4D4D4),
                  ),
                  Row(
                    children: [
                      Text(
                        isLangEnglish ? "Total Fees" : "कुल फीस",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff2c2c2c),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        amount.toString(),
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff2c2c2c),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: Container(),
                  ),

                  GestureDetector(
                    onTap: () {
                      onpressedConform();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        top: 11,
                        bottom: 11,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.AppmainColor),
                      child: Center(
                        child: Text(
                          isLangEnglish ? "CONFIRM" : "पुष्टि करें",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.0125 * _height),
                ],
              ),
            ),
          );
        });
  }

  onpressedConform() {
    createOrder();
    Navigator.pop(context);
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
