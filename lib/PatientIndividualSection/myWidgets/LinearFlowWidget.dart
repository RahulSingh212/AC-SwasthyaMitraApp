// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, duplicate_import, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Helper/constants.dart';
import '../screens/BookNewTests_Screens/BookYourTest_Screen.dart';
import '../screens/FindDoctors_Screens/FindDoctorScreen.dart';

class LinearFlowWidget extends StatefulWidget {
  @override
  State<LinearFlowWidget> createState() => _LinearFlowWidgetState();
}

class _LinearFlowWidgetState extends State<LinearFlowWidget> with SingleTickerProviderStateMixin {
  bool isButtonPressed = false;
  int selectedIconIndex = 3;
  late AnimationController controller;
  
  late File _storedImage;
  late DateTime _picTiming;
  late var _savedImageFilePath;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(
        milliseconds: 300,
      ),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var iconList = <Icon>[
      Icon(
        !isButtonPressed ? Icons.add : Icons.close,
      ),
      Icon(
        Icons.camera_alt_outlined,
      ),
      Icon(
        Icons.person_search,
      ),
      Icon(
        Icons.notes_rounded,
      ),
    ].map<Widget>(buildItem).toList();

    return Flow(
      delegate: FlowMenuDelegate(controller: controller),
      children: iconList,
    );
  }

  Widget buildItem(Icon icon) {
    return Container(
      width: 60,
      height: 60,
      child: FloatingActionButton(
        elevation: 0,
        splashColor: Colors.black,
        backgroundColor: (icon.icon == Icons.add || icon.icon == Icons.close)
            ? Color.fromRGBO(8, 255, 198, 1)
            : Color.fromRGBO(66, 204, 195, 1),
        child: Icon(
          icon.icon,
          // color: Colors.white,
          size: 35,
        ),
        onPressed: () {
          setState(() {
            if (icon.icon == Icons.add || icon.icon == Icons.close) {
              isButtonPressed = !isButtonPressed;
            }
          });

          if (controller.status == AnimationStatus.completed &&
              icon.icon == Icons.close) {
            controller.reverse();
          } else if (controller.status != AnimationStatus.completed &&
              icon.icon == Icons.add) {
            controller.forward();
          } else {
            if (icon.icon == Icons.notes_rounded) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookYourNewTestScreen(),
                ),
              );
            } else if (icon.icon == Icons.person_search) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FindDoctorScreenPatient(),
                ),
              );
            } else if (icon.icon == Icons.camera_alt_outlined) {
              _takePicture();
            }
          }
        },
      ),
    );
  }

  Future<void> _takePicture() async {
    _picTiming = DateTime.now();
    print(_picTiming);
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 480,
      maxWidth: 640,
    );

    if (imageFile == null) {
      String titleText = "Camera Application Turned Off";
      String contextText = "Please Re-Try Again!";
      _checkForError(context, titleText, contextText);
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final _savedImageFile =
        await File(imageFile.path).copy('${appDir.path}/${fileName}');

    _savedImageFilePath = _savedImageFile.toString();
    print(_savedImageFile);
    if (_savedImageFilePath != null) {
      _ScanDialogBox(context);
    }
  }

  Future _ScanDialogBox(BuildContext context) {
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
                    "Upload Document",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.w500,),
                  ),
                ),

                SizedBox(
                  height: 0.035805 * _height,
                ),
                Center(
                    child: Card(
                  elevation: 5,
                  child: Container(
                    height: 120,
                    width: 90,
                    child: Image.file(
                      _storedImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                )),

                SizedBox(
                  height: 0.0127877 * _height,
                ),

                //Check box banana ha

                Center(
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffCDCDCD)),
                    ),
                    child: Text(
                      "Report_1245.pdf",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Report Type:",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffCDCDCD)),
                    ),
                    child: Text(
                      "Blood Test Report",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ),
                ),

                Expanded(child: Container()),

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 11, bottom: 11),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.AppmainColor,),
                    child: const Center(
                      child: Text(
                        "UPLOAD",
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
      },
    );
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

class FlowMenuDelegate extends FlowDelegate {
  final Animation<double> controller;

  const FlowMenuDelegate({required this.controller})
      : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width - 65;
    final yStart = size.height - 65;

    for (int i = context.childCount - 1; i >= 0; i--) {
      var margin = 8;
      final childSize = context.getChildSize(i)!.width;
      final dx = (childSize + margin) * i;
      final x = xStart;
      final y = yStart - dx * controller.value;

      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return false;
  }
}
