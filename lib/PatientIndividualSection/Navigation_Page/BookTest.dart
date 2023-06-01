// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../Helper/constants.dart';
import '../Widgets/PaynmentMethord.dart';

import 'package:crypto/crypto.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

const String mykey = '';
const String Seckretkey = '';

class BookTest extends StatefulWidget {
  const BookTest({Key? key}) : super(key: key);

  @override
  _BookTestState createState() => _BookTestState();
}

class _BookTestState extends State<BookTest> {
  int amount = 600;
  late String orderid;
  late Razorpay _razorpay;
  String? choosenTest;
  String? choosenCenter;
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

  Future PaynmentError(BuildContext context) {
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
                    "PAYNMENT UNSUCCESSFUL",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  )),
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
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future PaynmentSuccessful(BuildContext context) {
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
                    "PAYNMENT SUCCESSFUL",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
        });
  }

  void createOrder() async {
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
        borderSide: BorderSide(color: color, width: 1));
  }

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: 0.038363 * _height,
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
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    )),
                SizedBox(
                  width: 0.0277777 * _width,
                ),
                const DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.bold),
                    child: Text(
                      "Book New Test",
                    )),

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
                const Icon(
                  Icons.text_snippet,
                  color: AppColors.AppmainColor,
                  size: 34,
                ),
              ],
            ),
            SizedBox(
              height: 0.01023 * _height,
            ),
            const DefaultTextStyle(
              style: TextStyle(
                  fontSize: 15,
                  color: Color(0xff929292),
                  fontWeight: FontWeight.w400),
              child: Text(
                "Select the test type and the appropriate date and time to book a new test",
              ),
            ),
            SizedBox(
              height: 0.044757 * _height,
            ),
            const DefaultTextStyle(
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff2c2c2c),
                    fontWeight: FontWeight.w500),
                child: Text(
                  "Test Type",
                )),

            SizedBox(
              height: 0.006393 * _height,
            ),
            // DropDownMenu

            DropdownButtonFormField(
              autofocus: false,

              decoration: InputDecoration(
                focusedBorder: _buildBorder(const Color(0xff42CCC3)),
                border: _buildBorder(const Color(0xffEBEBEB)),
                label: const Text(
                  "Select",
                  style: TextStyle(color: Color(0xff42CCC3)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              focusColor: Colors.white,
              value: choosenTest,
              //elevation: 5,
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: TestType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  choosenTest = value as String?;
                });
              },
              hint: const Text(
                "Select Test Type",
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
                    fontWeight: FontWeight.w500),
                child: Text(
                  "Select Auriga Centre",
                )),

            SizedBox(
              height: 0.0063938 * _height,
            ),
            // DropDownMenu
            DropdownButtonFormField(
              autofocus: false,

              decoration: InputDecoration(
                focusedBorder: _buildBorder(const Color(0xff42CCC3)),
                border: _buildBorder(const Color(0xffEBEBEB)),
                label: const Text(
                  "Select",
                  style: TextStyle(color: Color(0xff42CCC3)),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
              focusColor: Colors.white,
              value: choosenCenter,
              //elevation: 5,
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              items: AurigaCenter.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  choosenCenter = value as String?;
                });
              },
              hint: const Text(
                "Select Test Type",
                style: TextStyle(color: Color(0xff6C757D), fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.AppmainColor,
        onPressed: () {
          calldialog();
        },
        child: const Icon(
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
                  bottom: 0.025575 * _height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Booking Confirmed",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff2c2c2c),
                          fontWeight: FontWeight.w500),
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
                          bottom: 0.015345 * _height),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(65),
                        color: const Color(0xffD3F3F1),
                      ),
                      child: const CircleAvatar(
                          radius: 52,
                          backgroundColor: AppColors.AppmainColor,
                          child: Icon(
                            Icons.check,
                            size: 60,
                            color: Colors.white,
                          )),
                    ),
                  ),

                  SizedBox(
                    height: 0.0127877 * _height,
                  ),

                  //Check box banana ha

                  const Text(
                    "Liver Function Test",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.w500),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Color(0xffD4D4D4),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Total Fees",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff2c2c2c),
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: Container()),
                      Text(
                        amount.toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff2c2c2c),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  Expanded(child: Container()),

                  GestureDetector(
                    onTap: () {
                      onpressedConform();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 11, bottom: 11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.AppmainColor),
                      child: const Center(
                        child: Text(
                          "CONFIRM",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.0127877 * _height),
                ],
              ),
            ),
          );
        });
  }

  onpressedConform() {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const PaynmentMethord()));
    createOrder();
    Navigator.pop(context);
  }
}
