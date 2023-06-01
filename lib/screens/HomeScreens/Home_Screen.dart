// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, sort_child_properties_last, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../Helper/constants.dart';
import '../../providers/SM_DashBoard_Details.dart';
import '../../providers/SM_FindPatients_Details.dart';
import '../../providers/SM_User_Details.dart';

import '../AvailableTestsScreens/BookTestsForPaitients_Screen.dart';
import '../FindAddPatientScreens/FindAndAddPatient_Screen.dart';
import '../NotificationScreens/Notifications_Screen.dart';
import '../ProfileScreens/MyProfile_Screen.dart';

class HomeScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-home-screen';

  @override
  State<HomeScreenSwasthyaMitra> createState() =>
      _HomeScreenSwasthyaMitraState();
}

class _HomeScreenSwasthyaMitraState extends State<HomeScreenSwasthyaMitra> {
  bool isLangEnglish = true;
  Map<String, String> userMapping = {};

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User declined or has not accepted permission");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .mobileMessagingToken = token.toString();
        print(token);

        updateMobileMessagingToken(token.toString());
      },
    );
  }

  void updateMobileMessagingToken(String token) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("SwasthyaMitraUsersPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    print("Updating message token id");
    db.collection("SwasthyaMitraUsersPersonalInformation")
        .doc(loggedInUserId)
        .update({"SwasthyaMitra_MobileMessagingTokenId": token});
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: IOSInitialize);

    flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onSelectNotification: (String? payload) async {
        try {
          if (payload != null && payload.isNotEmpty) {
          } else {}
        } catch (errorVal) {
          print(errorVal);
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print(".....onMessage.......");
        print(
            "onMessage: ${message.notification?.title}/${message.notification!.body}");

        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true,
        );

        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          "channel id 5",
          "aurigaCare",
          "",
          importance: Importance.high,
          styleInformation: bigTextStyleInformation,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('notification'),
          playSound: true,
        );

        NotificationDetails platformChannelSpecifies = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: const IOSNotificationDetails(),
        );
        await flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title,
            message.notification!.body,
            platformChannelSpecifies,
            payload: message.data['body']);
      },
    );
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAJf9Zzxw:APA91bG2byLOz03IcaNF5kfF9jeEj9hudr-VbWCNfBBuGdi6GYToR_rutgKIynxNfeNjKzSBC2JFMZ1xX_e6wVBgL-5yihEtdxcMWMshW8fggjQRxyBuR5QabafIUBpC3iAA9gpHxzSG',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              'title': title,
              "body": body,
              "android_channel_id": "aurigaCare",
            },
            "to": token,
          },
        ),
      );
    } catch (errorVal) {}
  }

  double width = 0;
  double height = 0;
  var numberoftest = 0;
  var textValue = 'Start Accepting';
  var textValue2 =
      "Accept new test request and complete them to improve your SwasthyaMitra rating.";
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
          .updateSwasthyaMitraUserPersonalInformation(
              context, 'SwasthyaMitra_AcceptingRequestStatus', 'true');

      userMapping['SwasthyaMitra_AcceptingRequestStatus'] = 'true';
      setState(() {
        isSwitched = true;
        textValue = isLangEnglish ? 'Stop Accepting' : "स्वीकार ना करें";
        textValue2 = isLangEnglish
            ? "You are currently accepting requests for tests and appointments."
            : "आप वर्तमान में परीक्षण और नियुक्तियों के लिए अनुरोध स्वीकार कर रहे हैं।";
        // Container();
      });
      // print('Switch Button is ON');
    } else {
      Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
          .updateSwasthyaMitraUserPersonalInformation(
              context, 'SwasthyaMitra_AcceptingRequestStatus', 'false');

      userMapping['SwasthyaMitra_AcceptingRequestStatus'] = 'false';
      setState(
        () {
          isSwitched = false;
          textValue = isLangEnglish ? 'Start Accepting' : "स्वीकार करें";
          textValue2 = isLangEnglish
              ? "Accept new test request and complete them to improve your SwasthyaMitra rating."
              : "नए परीक्षण अनुरोध को स्वीकार करें और अपनी स्वास्थ्य मित्र रेटिंग को बेहतर बनाने के लिए उन्हें पूरा करें।";
        },
      );
      // print('Switch Button is OFF');
    }
  }

  @override
  void initState() {
    super.initState();

    Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
        .setSwasthyaMitraUserInfo(context)
        .then((value) {});

    requestPermission();
    getToken();
    initInfo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;

    Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
        .fetchPatientAppointmentList(context);

    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;

    textValue = isLangEnglish ? "Start Accepting" : "स्वीकार करें";
    textValue2 = isLangEnglish
        ? "Accept new test request and complete them to improve your SwasthyaMitra rating."
        : "नए परीक्षण अनुरोध को स्वीकार करें और अपनी स्वास्थ्य मित्र रेटिंग को बेहतर बनाने के लिए उन्हें पूरा करें।";

    userMapping = Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
        .getSwasthyaMitraUserPersonalInformation();

    if (userMapping['SwasthyaMitra_AcceptingRequestStatus'].toString() ==
        'true') {
      isSwitched = true;
    } else {
      isSwitched = false;
    }

    Provider.of<SwasthyaMitraDashBoardDetails>(context, listen: false)
        .fetchPatientBookedTests(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    var _padding = MediaQuery.of(context).padding;
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height) -
        _padding.top -
        _padding.bottom -
        kBottomNavigationBarHeight;

    var userInfoDetails = Provider.of<SwasthyaMitraUserDetails>(context);
    Map<String, String> userMapping =
        userInfoDetails.getSwasthyaMitraUserPersonalInformation();

    String imageNetworkUrl = userMapping['SwasthyaMitra_ProfilePicUrl'] ?? "";

    return Scaffold(
      backgroundColor: Colors.white10,
      // appBar: ,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        margin: EdgeInsets.only(
                          top: 0.05 * height,
                          bottom: 0.01 * height,
                          // left: 0.025 * width,
                          // right: 0.025 * width,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationScreenSwasthyaMitra(),
                                  ),
                                );
                              },
                              child: Container(
                                child: Icon(
                                  Icons.notifications_none,
                                  size: 0.095 * screenWidth,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    MyProfileScreenSwasthyaMitra.routeName);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                height: screenWidth * 0.1125,
                                width: screenWidth * 0.1125,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: screenWidth,
                                  child: CircleAvatar(
                                    radius: screenWidth,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        screenWidth,
                                      ),
                                      child: ClipOval(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                          ),
                                          child: imageNetworkUrl == ""
                                              ? Image.asset(
                                                  "assets/images/Nurse.png",
                                                )
                                              : Image.network(
                                                  imageNetworkUrl,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.9,
                        alignment: Alignment.centerLeft,
                        // margin:EdgeInsets.only(lef),
                        padding: EdgeInsets.only(
                          top: 0.001 * height,
                          // left: 0.0000001 * height,
                          // right: 0.3 * height,
                          bottom: 0.005 * height,
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Hi, ',
                                style: TextStyle(
                                  fontSize: 25 * (0.035 / 15) * width,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${userMapping['SwasthyaMitra_CenterName']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25 * (0.035 / 15) * width,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.only(
                          top: 0.0025 * height,
                          bottom: 0.0025 * height,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                color: Color(0xff42CCC3),
                              ),
                              width: 0.7 * screenWidth,
                              height: 0.1 * height,
                              child: Row(
                                children: [
                                  FittedBox(
                                    fit: BoxFit.fill,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.only(left: 0.04 * width),
                                      width: 0.25 * width,
                                      child: Text(
                                        Provider.of<SwasthyaMitraDashBoardDetails>(
                                                context)
                                            .getPatientActiveTestAppointmentList
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 50 * (0.035 / 15) * width,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 0.02 * width,
                                    ),
                                    width: 0.35 * width,
                                    child: Text(
                                      isLangEnglish
                                          ? "New Test Requests"
                                          : "नए जाँच अनुरोध",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25 * (0.035 / 15) * width,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 0.1 * height,
                              width: screenWidth * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Color(0xff5662F6),
                              ),

                              // width: 0.0001 * width,
                              child: IconButton(
                                onPressed: () {},
                                iconSize: 50 * (0.035 / 15) * width,
                                icon: Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(
                          top: 0.005 * height,
                          // left: 0.07 * width,
                          // right: 0.1 * width,
                          bottom: 0.0125 * height,
                        ),
                        height: 0.225 * height,
                        width: screenWidth * 0.9,
                        // color: Colors.pink,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 0.04 * width,
                                top: 0.015 * height,
                              ),
                              child: Text(
                                isLangEnglish
                                    ? 'SwasthyaMitra'
                                    : "स्वास्थ्य मित्रा",
                                style: TextStyle(
                                  fontSize: 24 * (0.035 / 15) * width,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff42CCC3),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 0.04 * width,
                                top: 0.01 * height,
                                bottom: 0.01 * height,
                              ),
                              child: Text(
                                '$textValue2',
                                style: TextStyle(
                                  fontSize: 18 * (0.035 / 15) * width,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff6C757D),
                                ),
                              ),
                            ),
                            Expanded(
                              // padding: EdgeInsets.only(left: 0.04*width),
                              // // height: 0.25 * height,
                              // width: width/1.3,
                              // // width: 100,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.only(
                              //     topLeft: Radius.circular(10),
                              //     bottomLeft: Radius.circular(10),
                              //   ),
                              //   color: Colors.white,
                              // ),
                              // margin: EdgeInsets.only(top: 100),
                              child: Container(
                                padding: EdgeInsets.only(left: 0.04 * width),
                                child: Row(
                                  children: [
                                    Text(
                                      '$textValue',
                                      style: TextStyle(
                                        fontSize: 20 * (0.035 / 15) * width,
                                        color: Color(0xff42CCC3),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Switch(
                                      onChanged: toggleSwitch,
                                      value: isSwitched,
                                      activeColor: Color(0xff42CCC3),
                                      activeTrackColor: Color(0xffCFF2F0),
                                      inactiveThumbColor: Color(0xffFFFFFF),
                                      inactiveTrackColor: Color(0xffEAF0F5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        child: Container(
                          width: screenWidth * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 0.425 * screenWidth,
                                height: 0.175 * screenHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.only(
                                  top: 0.01 * height,
                                  bottom: 0.01 * height,
                                  left: 0.01 * width,
                                  right: 0.01 * width,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        isLangEnglish
                                            ? 'Test for Patient'
                                            : "मरीज के लिए जाँच",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        isLangEnglish
                                            ? 'Book Test for a patient via SwasthyaMitra'
                                            : "स्वास्थ्यमित्र से मरीज के लिए जाँच बुक करें",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 41, 34, 34),
                                          fontSize: 11 * (0.035 / 15) * width,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.0005,
                                    ),
                                    Container(
                                      width: width,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF5662F6),
                                        ),
                                        onPressed: () {
                                          // Navigator.pushNamed(
                                          //     context,
                                          //     BookTestForPatientSwasthyaMitra
                                          //         .routeName);
                                          Navigator.pushNamed(
                                              context,
                                              FindAndAddPatientScreenSwasthyaMitra
                                                  .routeName);
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => BookTest(),
                                          //   ),
                                          // );
                                        },
                                        child: Text(
                                          isLangEnglish
                                              ? 'Book Test'
                                              : "जाँच बुक करें",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12 * (0.035 / 15) * width,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 0.425 * screenWidth,
                                height: 0.175 * screenHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.only(
                                  top: 0.01 * height,
                                  bottom: 0.01 * height,
                                  left: 0.01 * width,
                                  right: 0.01 * width,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        isLangEnglish
                                            ? 'Book Appointment'
                                            : "नियुक्ति बुक करें",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        isLangEnglish
                                            ? 'Book Appointment for a patient via SwasthyaMitra'
                                            : "स्वास्थ्यमित्र से मरीज के लिए अपॉइंटमेंट बुक करें",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11 * (0.035 / 15) * width,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.0005,
                                    ),
                                    Container(
                                      width: width,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF5662F6),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              FindAndAddPatientScreenSwasthyaMitra
                                                  .routeName);
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (context) => FindAndAddPatientScreenSwasthyaMitra(),
                                          //   ),
                                          // );
                                        },
                                        child: Text(
                                          isLangEnglish
                                              ? 'Book Appointment'
                                              : "नियुक्ति बुक करें",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12 * (0.035 / 15) * width,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width * 0.45,
                              padding: EdgeInsets.only(left: 0.01 * height),
                              margin: EdgeInsets.only(left: 0.05 * width),
                              child: Text.rich(
                                TextSpan(
                                  text: isLangEnglish
                                      ? 'Upcoming Tests: '
                                      : 'आगामी टेस्ट: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20 * (0.035 / 15) * width,
                                  ),
                                ),
                              ),
                            ),
                            // Provider.of<SwasthyaMitraHomeScreenrDetails>(context)
                            //         .items
                            //         .isNotEmpty
                            //     ? Container(
                            //         width: width * 0.3,
                            //         child: TextButton(
                            //           style: TextButton.styleFrom(
                            //             textStyle: TextStyle(
                            //               fontSize: 18 * (0.035 / 15) * width,
                            //               color: Colors.black,
                            //             ),
                            //           ),
                            //           onPressed: () {
                            //             Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     ScheduleScreenSwasthyaMitra(),
                            //               ),
                            //             );
                            //           },
                            //           child: const Text(
                            //             'View All',
                            //             style: TextStyle(
                            //               color: Color(0xff9B9B9B),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Provider.of<SwasthyaMitraHomeScreenrDetails>(context).items.isEmpty
                  //     ? Container(
                  //         width: screenWidth * 0.95,
                  //         height: screenHeight * 0.175,
                  //         padding: EdgeInsets.symmetric(
                  //           horizontal: screenWidth * 0.075,
                  //           vertical: screenHeight * 0.025,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(25),
                  //           color: Colors.white70,
                  //         ),
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: <Widget>[
                  //             Container(
                  //               child: Text(
                  //                 "\"No appointments/Tests for today\"",
                  //                 style: TextStyle(
                  //                   color: Color.fromRGBO(196, 207, 238, 1),
                  //                   fontSize: screenWidth * 0.0425,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             ),
                  //             Container(
                  //               child: Text(
                  //                 "\"Laughing is good for the Heart and can increase the blood flow by 20%\"",
                  //                 style: TextStyle(
                  //                   color: Color.fromRGBO(196, 207, 238, 1),
                  //                   fontSize: screenWidth * 0.0425,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     : Expanded(
                  //         child: ListView.builder(
                  //           itemCount:
                  //               Provider.of<SwasthyaMitraHomeScreenrDetails>(context)
                  //                   .items
                  //                   .length,
                  //           itemBuilder: (ctx, index) {
                  //             return appointmentReminderWidget(
                  //               context,
                  //               Provider.of<SwasthyaMitraHomeScreenrDetails>(context,
                  //                       listen: false)
                  //                   .items[index],
                  //             );
                  //           },
                  //         ),
                  //       ),
                  SizedBox(
                    height: screenHeight * 0.0125,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget appointmentReminderWidget(
  //   BuildContext context,
  //   BookedTokenSlotInformation tokenInfo,
  // ) {
  //   var screenHeight = MediaQuery.of(context).size.height;
  //   var screenWidth = MediaQuery.of(context).size.width;
  //   var topInsets = MediaQuery.of(context).viewInsets.top;
  //   var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
  //   var useableHeight = screenHeight - topInsets - bottomInsets;

  //   return GestureDetector(
  //     onTap: () {},
  //     child: Align(
  //       child: Container(
  //         height: screenHeight * 0.1,
  //         width: screenWidth * 0.9,
  //         padding: EdgeInsets.symmetric(
  //           vertical: screenHeight * 0.005,
  //           horizontal: screenWidth * 0.01,
  //         ),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(15),
  //           color: Colors.white70,
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             Container(
  //               child: Icon(
  //                 Icons.watch_later_outlined,
  //                 size: 50,
  //                 color: AppColors.AppmainColor,
  //               ),
  //             ),
  //             Container(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Container(
  //                     child: Text.rich(
  //                       TextSpan(
  //                         children: <TextSpan>[
  //                           TextSpan(
  //                             text: 'Appointment',
  //                             style: TextStyle(
  //                               fontSize: 17.5,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     child: Text.rich(
  //                       TextSpan(
  //                         children: <TextSpan>[
  //                           TextSpan(
  //                             text: 'Dr. ${tokenInfo.doctorFullName} ',
  //                             style: TextStyle(
  //                               fontSize: 15,
  //                               color: Color.fromARGB(255, 165, 174, 200),
  //                             ),
  //                           ),
  //                           TextSpan(
  //                             text:
  //                                 'at ${tokenInfo.bookedTokenTime.format(context)}',
  //                             style: TextStyle(
  //                               fontSize: 15,
  //                               color: Color.fromARGB(255, 165, 174, 200),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   Container(),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               width: screenWidth * 0.001,
  //             ),
  //             SizedBox(
  //               width: screenWidth * 0.001,
  //             ),
  //             SizedBox(
  //               width: screenWidth * 0.001,
  //             ),
  //             Container(
  //               child: ClipOval(
  //                 child: Material(
  //                   color: Color.fromRGBO(220, 229, 228, 1), // Button color
  //                   child: InkWell(
  //                     splashColor:
  //                         Color.fromRGBO(120, 158, 156, 1), // Splash color
  //                     onTap: () {
  //                       // Navigator.of(context).push(
  //                       //   MaterialPageRoute(
  //                       //     builder: (context) => ViewBookedTokenScreen(
  //                       //       0,
  //                       //       tokenInfo,
  //                       //     ),
  //                       //   ),
  //                       // );
  //                       // setState(() {});
  //                     },
  //                     child: Padding(
  //                       padding: EdgeInsets.all(2),
  //                       child: SizedBox(
  //                         width: screenWidth * 0.075,
  //                         height: screenWidth * 0.075,
  //                         child: Icon(
  //                           Icons.navigate_next_rounded,
  //                           size: 21,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               width: screenWidth * 0.0001,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
