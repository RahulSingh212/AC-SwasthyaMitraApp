// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:path_provider/path_provider.dart' as sysPaths;
import '../Appointment/find_doctor.dart';
import '../Helper/Doctorsdata.dart';
import '../Helper/constants.dart';
import '../Widgets/AllDoctors.dart';
import 'BookTest.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AllTestDetail extends StatefulWidget {
  const AllTestDetail({Key? key}) : super(key: key);

  @override
  _AllTestDetailState createState() => _AllTestDetailState();
}

class _AllTestDetailState extends State<AllTestDetail>
    with TickerProviderStateMixin {
  late TabController _tabcontroller;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isfirst = true;

  late File _storedImage;
  late DateTime _picTiming;
  late var _savedImageFilePath;

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
    print("""
      
      jgewlfvhjdvjv
      dsjkbdsubdiubdku
      
      """);
    if (_savedImageFilePath != null) {
      _ScanDialogBox(context);
    }
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

  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabcontroller.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabcontroller.removeListener(_handleTabIndex);
    _tabcontroller.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 8),
          child: Column(
            children: [
              Text(
                "Appointments and Tests",
                style: TextStyle(
                  color: Color(0xff2C2C2C),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 0.035805626 * _height,
              ),
              Container(
                child: TabBar(
                    isScrollable: true,
                    labelStyle: TextStyle(fontSize: 20),
                    labelPadding: EdgeInsets.only(
                        left: 0.0625 * _width, right: 0.140625 * _width),
                    labelColor: AppColors.AppmainColor,
                    unselectedLabelColor: Color(0xffB8B8B8),
                    controller: _tabcontroller,
                    indicatorColor: AppColors.AppmainColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        text: "Upcoming",
                      ),
                      Tab(
                        text: "Previous",
                      ),
                    ]),
              ),
              Container(
                height: 0.7416879795 * _height,
                child: TabBarView(
                  controller: _tabcontroller,
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 3,
                        itemBuilder: (_, index) {
                          return AllDoctor(
                            time: '5:00 PM',
                            date: "28 Jul",
                            name: "Dr. Ram Singh",
                            branch: "Physiotherapist",
                            ImageUrl: 'assets/images/Doctor.jpg',
                          );
                        }),
                    SingleChildScrollView(
                      child: Column(children: [
                        for (int i = 0; i < alldoc.length; i++)
                          Column(
                            children: <Widget>[
                              for (int j = 0; j < alldoc[i].length + 1; j++)
                                Row(
                                  mainAxisAlignment: j == 0
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    j == 0
                                        ? Row(
                                            children: [
                                              Container(
                                                  child: Text(
                                                "July",
                                                style: TextStyle(
                                                    color: Color(0xff7F8084),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                              SizedBox(
                                                width: 0.03125 * _width,
                                              ),
                                              Container(
                                                  child: Icon(
                                                Icons.radio_button_off,
                                                color: AppColors.AppmainColor,
                                              )),
                                            ],
                                          )
                                        : AllDoctor(
                                            time: '5:00 PM',
                                            date: "28 Jul",
                                            name: "Dr. Ram Singh",
                                            branch: "Physiotherapist",
                                            ImageUrl:
                                                'assets/images/Doctor.jpg',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                3 /
                                                4,
                                          ),
                                    SizedBox(
                                      width: 0.03125 * _width,
                                    )
                                  ],
                                )
                            ],
                          )
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton:
            _tabcontroller.index == 0 ? _bottomButtons() : null,
      ),
    );
  }

  Widget _bottomButtons() {
    return FloatingActionButton(
        onPressed: () {
          showmenu();
        },
        backgroundColor: AppColors.AppmainColor,
        child: Icon(
          Icons.add,
          size: 30.0,
        ));
  }

  showmenu() {
    print("i am clicked           fdrsxrtnxtxx");
    Future.delayed(Duration.zero, () {
      MenuDialogBox();
    });
    // SchedulerBinding.instance?.addPostFrameCallback((_) {
    //   MenuDialogBox();
    // });
  }

  Future<void> MenuDialogBox() {
    return showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BookTest()));
                  },
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Find_doctor()));
                  },
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
                  onTap: () {
                    _takePicture();
                  },
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
              onTap: () {
                Navigator.pop(context);
              },
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
      },
    );
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
                        fontWeight: FontWeight.w500),
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
                        color: AppColors.AppmainColor),
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
}
