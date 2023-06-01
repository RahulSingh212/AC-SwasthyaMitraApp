// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class CallDialog extends StatefulWidget {
  const CallDialog({Key? key}) : super(key: key);

  @override
  _CallDialogState createState() => _CallDialogState();
}

class _CallDialogState extends State<CallDialog> {
  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Dialogs"),
      ),
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            // RaisedButton(
            //   onPressed: () {
            //     _myDialogBox(context);
            //   },
            //   child: Text("first dialog box"),
            // ),
            // RaisedButton(
            //   onPressed: () {
            //     _paynment2DialogBox(context);
            //   },
            //   child: Text("Second dialog box"),
            // ),
            // RaisedButton(
            //   onPressed: () {
            //     CancelAppointDialogBox(context);
            //   },
            //   child: Text("Cnacell Appointnment dialog box"),
            // ),
            // RaisedButton(
            //   onPressed: () {
            //     AppointDialogBox(context);
            //   },
            //   child: Text("Appointnment dialog box"),
            // ),
            // RaisedButton(
            //   onPressed: () {
            //     PaynmentError(context);
            //   },
            //   child: Text("Menu dialog box"),
            // ),
          ],
        ),
      ),
    );
  }

  Future _myDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.backgroundColor,
              ),
              height: 284,
              width: 267,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff898989),
                        ),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff898989),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Mon, 5 July",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff2c2c2c),
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "06:45 PM",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff2c2c2c),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Write a brief description about your ailment :",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  //  Text form field
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    showCursor: false,
                    minLines: 1,
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Color(0xffCDCDCD),
                          )),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 11, bottom: 11),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.AppmainColor),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future _paynment2DialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog();
        });
  }

  Future CancelAppointDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 24, top: 40),
                  height: 300,
                  width: 320,
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage("img/Doctor.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Dr. Ram Singh has cancelled ",
                        style: TextStyle(
                            color: Color(0xff2C2C2C),
                            fontSize: 19,
                            fontWeight: FontWeight.w500),
                      ),
                      Center(
                        child: Text(
                          "your appointment",
                          style: TextStyle(
                              color: Color(0xff2C2C2C),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "You were scheduled for ",
                          style: TextStyle(
                              color: Color(0xff2C2C2C),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Center(
                        child: Text(
                          "April 17 at 11:30 AM",
                          style: TextStyle(
                              color: Color(0xff2C2C2C),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 14, bottom: 15),
                    height: 52,
                    width: 320,
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "BOOK AGAIN",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xffFC667B),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future AppointDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 24, top: 40),
                  height: 300,
                  width: 320,
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage("img/Doctor.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "Dr. Ram Singh is ",
                          style: TextStyle(
                              color: Color(0xff2C2C2C),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Center(
                        child: Text(
                          "waiting for you!",
                          style: TextStyle(
                              color: Color(0xff2C2C2C),
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "You were scheduled for ",
                          style: TextStyle(
                              color: Color(0xff2C2C2C),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Center(
                        child: Text(
                          "April 17 at 11:30 AM",
                          style: TextStyle(
                              color: Color(0xff2C2C2C),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 14, bottom: 15),
                    height: 52,
                    width: 320,
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "CALL",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff42CCC3),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future MenuDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 138,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff989898)),
                        child: Text(
                          "Book New Test",
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.AppmainColor,
                        child: Icon(
                          Icons.text_snippet,
                          color: Colors.white,
                          size: 26,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 138,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff989898)),
                        child: Text(
                          "Find Doctors",
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.AppmainColor,
                        child: Icon(
                          Icons.person_search_rounded,
                          color: Colors.white,
                          size: 26,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 138,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff989898)),
                        child: Text(
                          "Scan Report",
                        )),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.AppmainColor,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 26,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.AppmainColor,
                    child: Icon(
                      Icons.dangerous,
                      color: Colors.white,
                      size: 26,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }


  Future PaynmentSuccessful(BuildContext context){
    return showDialog(context: context,
        builder: (context){
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
                Center(child: Text("PAYNMENT SUCCESSFUL",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
                SizedBox(height: 20,),
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
                        )),
                  ),
                ),
              ],
            ),

          ),
        );
        });
  }
  Future PaynmentError(BuildContext context){
    return showDialog(context: context,
        builder: (context){
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
                Center(child: Text("PAYNMENT UNSUCCESSFUL",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)),
                SizedBox(height: 20,),
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


}

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  bool checkbox = true;
  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Date",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff898989),
                  ),
                ),
                Expanded(child: Container()),
                Text(
                  "Time",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff898989),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  "Mon, 5 July",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff2c2c2c),
                      fontWeight: FontWeight.w500),
                ),
                Expanded(child: Container()),
                Text(
                  "06:45 PM",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff2c2c2c),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 28,
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
                    )),
              ),
            ),

            SizedBox(
              height: 1,
            ),

            //Check box banana ha
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  onChanged: (value) {
                    setState(() {
                      this.checkbox = value!;
                      print(value);
                      print(checkbox);
                    });
                  },
                  value: this.checkbox,
                ),
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "I’ve read and accept the",
                      style: TextStyle(
                          color: Color(0xff2C2C2C),
                          fontWeight: FontWeight.w400,
                          fontSize: 10),
                    ),
                    TextSpan(
                        text: " terms & conditions",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('Terms of Service"');
                          }),
                  ]),
                ),
              ],
            ),

            Text(
              "Clinic Appointment",
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff2c2c2c),
                  fontWeight: FontWeight.w500),
            ),
            Divider(
              thickness: 2,
              color: Color(0xffD4D4D4),
            ),
            Row(
              children: [
                Text(
                  "Consultation Fee",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff2c2c2c),
                      fontWeight: FontWeight.w500),
                ),
                Expanded(child: Container()),
                Text(
                  "₹ 600.00",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff2c2c2c),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 11, bottom: 11),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.AppmainColor),
              child: Center(
                child: Text(
                  "CONFIRM",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
