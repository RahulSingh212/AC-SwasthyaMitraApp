// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, unused_import, duplicate_import, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:swasthyamitra/providers/SM_User_Details.dart';
import 'package:swasthyamitra/screens/Tab_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/token_info.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';

import '../../Appointment/find_doctor.dart';
import '../../Helper/constants.dart';
import '../../Navigation_Page/BookTest.dart';
import '../../providers/patientHomeScreen_details.dart';
import '../../providers/patientUser_details.dart';
import '../AppointsAndTests_Screens/AppointmentsNTests_Screen.dart';
import '../AppointsAndTests_Screens/ViewBookedToken_Screen.dart';
import '../BookTests_Screen/PatientBookTest_Screen.dart';
import '../FindDoctors_Screens/FindDoctorScreen.dart';
import '../HealthNFitness_Screens/HealthAndFitness_screen.dart';
import '../MyProfile_Screen.dart';
import '../Notification_Screens/Notifications_Screen.dart';

class HomeScreenPatient extends StatefulWidget {
  static const routeName = '/patient-home-screen';

  @override
  State<HomeScreenPatient> createState() => _HomeScreenPatientState();
}

class _HomeScreenPatientState extends State<HomeScreenPatient> {
  bool isLangEnglish = true;

  bool isTodayAnything = true;
  var _padding;
  double _width = 0;
  double _height = 0;

  int scrollindex = 1;
  List scroll = [];

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
    CollectionReference usersRef = db.collection("PatientUsersPersonalInformation");

    print("Updating message token id");
    db.collection("PatientUsersPersonalInformation")
        .doc(Provider.of<PatientUserDetails>(context, listen: false).patientDetails.patient_personalUniqueIdentificationId)
        .update({"patient_MobileMessagingTokenId": token});
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
          "channel id 3",
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

  @override
  void initState() {
    super.initState();

    Provider.of<PatientUserDetails>(context, listen: false).setPatientUserInfo(
      context,
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );

    requestPermission();
    getToken();
    initInfo();

    isLangEnglish = Provider.of<SwasthyaMitraUserDetails>(context, listen: false).isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<PatientHomeScreenrDetails>(context)
        .fetchPatientActiveTodaysTokens(
      context,
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    _padding = MediaQuery.of(context).padding;
    _width = (MediaQuery.of(context).size.width);
    _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    set_scroll_list();

    var userInfoDetails = Provider.of<PatientUserDetails>(context);
    Map<String, String> userMapping =
        userInfoDetails.getPatientUserPersonalInformation();

    String imageNetworkUrl = userMapping['patient_ProfilePicUrl'] ?? "";
    return SafeArea(
      child: ListView(
        physics: ScrollPhysics(),
        children: [
          Container(
            color: AppColors.backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.01125,
                ),
                Container(
                  alignment: Alignment.center,
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //     // Navigator.of(context).push(
                      //     //   MaterialPageRoute(
                      //     //     builder: (context) => PatientNotificationsScreen(
                      //     //       0,
                      //     //     ),
                      //     //   ),
                      //     // );

                      //     Navigator.pushNamedAndRemoveUntil(context, TabsScreenSwasthyaMitra.routeName, (route) => false);
                      //   },
                      //   child: Container(
                      //     child: Icon(
                      //       Icons.notifications_none,
                      //       size: 0.095 * screenWidth,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        child: ClipOval(
                          child: Material(
                            color: Color.fromRGBO(
                                220, 229, 228, 1), // Button color
                            child: InkWell(
                              splashColor: Color.fromRGBO(
                                  120, 158, 156, 1), // Splash color
                              onTap: () {
                                Provider.of<PatientUserDetails>(context,
                                        listen: false)
                                    .isEnteryMade = false;
                                Provider.of<PatientUserDetails>(context,
                                        listen: false)
                                    .clearStateObjectsOfPreviousUsers(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    TabsScreenSwasthyaMitra.routeName,
                                    (route) => false).then((value) {});
                              },
                              child: Padding(
                                padding: EdgeInsets.all(2),
                                child: SizedBox(
                                  width: screenWidth * 0.075,
                                  height: screenWidth * 0.075,
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 21,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MyProfileScreen.routeName);
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
                                      borderRadius: BorderRadius.circular(1000),
                                    ),
                                    child: imageNetworkUrl == ""
                                        ? Image.asset(
                                            "assets/images/healthy.png",
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

                SizedBox(
                  height: 0.015 * screenHeight,
                ),
                Container(
                  width: screenWidth * 0.9,
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: isLangEnglish ? 'Hello, ' : "नमस्ते, ",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        TextSpan(
                          text: '${userMapping['patient_FullName']}!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.0135 * _height,
                ),

                // //  Input TextField
                // Container(
                //   width: screenWidth * 0.95,
                //   child: Material(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(
                //       10,
                //     ),
                //     elevation: 2.0,
                //     child: TextField(
                //       onChanged: (value) {
                //         setState(() {
                //           input = value;
                //         });
                //       },
                //       showCursor: false,
                //       decoration: InputDecoration(
                //         hintText: isLangEnglish
                //             ? "Search \"Swasthya Mitra\" Near You"
                //             : "खोज \"स्वास्थ्य मित्र\" आपके पास",
                //         hintStyle: TextStyle(
                //           color: Color(0xffC4CFEE),
                //         ),
                //         fillColor: Colors.white,
                //         suffixIcon: Container(
                //           margin: EdgeInsets.only(right: 0.01388 * _width),
                //           decoration: BoxDecoration(
                //             color: AppColors.AppmainColor,
                //             borderRadius: BorderRadius.circular(
                //               10,
                //             ),
                //           ),
                //           child: Icon(
                //             Icons.search,
                //           ),
                //         ),
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(
                //             10,
                //           ),
                //           borderSide: BorderSide.none,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                SizedBox(
                  height: 0.02 * _height,
                ),

                GestureDetector(
                  onVerticalDragDown: (_) {
                    setState(() {
                      scrollindex = (scrollindex + 1) % 3;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.95,
                    height: 0.175 * _height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0.01278 * _height,
                          left: 0,
                          child: scroll[(scrollindex + 2) % 3],
                        ),
                        Positioned(
                          top: 0.01278 * _height * 0.5,
                          left: 0,
                          child: scroll[(scrollindex + 1) % 3],
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: scroll[scrollindex],
                        ),
                        Positioned(
                          right: 0.06111 * _width,
                          top: 0.06393 * _height,
                          child: Container(
                            height: 0.04 * _height,
                            child: Column(
                              children: List.generate(
                                3,
                                (index) {
                                  return Container(
                                    // margin: EdgeInsets.only(
                                    //   bottom: 0.0076726 * _height,
                                    // ),
                                    height: 0.0041150 * _height,
                                    width: 0.011111 * _width,
                                    decoration: BoxDecoration(
                                      color: index != scrollindex
                                          ? Colors.white
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(
                                        0.05555 * _width,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //  help
                SizedBox(
                  height: 0.005 * screenHeight,
                ),
                Container(
                  width: screenWidth * 0.95,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isLangEnglish
                        ? "How can we help you?"
                        : "हम आपकी कैसे मदद कर सकते हैं?",
                    style: TextStyle(
                        color: Color(0xff2C2C2C),
                        fontSize: screenWidth * 0.055,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 0.005 * screenHeight,
                ),

                // three buttons
                Container(
                  width: screenWidth * 0.95,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenHeight * 0.01,
                  ),
                  // color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.of(context).pushNamed(
                          //   FindDoctorScreenPatient.routeName,
                          // );

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FindDoctorScreenPatient(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 1,
                          child: Container(
                            width: screenWidth * 0.275,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.0125,
                              vertical: screenHeight * 0.02,
                            ),
                            child: Column(
                              children: [
                                Image.asset("assets/images/Doctor_Icon.png",
                                    width: 0.04166 * 2 * _width,
                                    height: 0.04166 * 2 * _width),
                                SizedBox(
                                  height: 0.01023 * _height,
                                ),
                                Center(
                                  child: Text(
                                    isLangEnglish
                                        ? "Find Doctors"
                                        : "डॉक्टरों देखें",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: AppColors.AppmainColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (Provider.of<SwasthyaMitraUserDetails>(context,
                                      listen: false)
                                  .mp['SwasthyaMitra_AcceptingRequestStatus'] ==
                              'true') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BookTestScreenPatient(),
                              ),
                            );
                          } else {
                            String titleText = isLangEnglish
                                ? "Booking Test Unavailable"
                                : "जांच परीक्षण अनुपलब्ध";
                            String contextText = isLangEnglish
                                ? "Swasthya Mitra is not accepting tests requests currently."
                                : "स्वास्थ्य मित्र वर्तमान में जांच अनुरोध स्वीकार नहीं कर रहे हैं।";
                            _checkForError(context, titleText, contextText);
                          }

                          // String titleText = isLangEnglish
                          //     ? "Feature un-available"
                          //     : "सुविधा अनुपलब्ध";
                          // String contextText = isLangEnglish
                          //     ? "This feature will be available soon."
                          //     : "यह सुविधा जल्द ही उपलब्ध होगी।";
                          // _checkForError(context, titleText, contextText);
                        },
                        child: Card(
                          elevation: 1,
                          child: Container(
                            width: screenWidth * 0.275,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.0125,
                              vertical: screenHeight * 0.02,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/TestTube.png",
                                  width: 0.04166 * 2 * _width,
                                  height: 0.04166 * 2 * _width,
                                ),
                                SizedBox(
                                  height: 0.01023 * _height,
                                ),
                                Center(
                                  child: Text(
                                    isLangEnglish ? "Book Tests" : "बुक टेस्ट",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: AppColors.AppmainColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              HealthAndFitnessScreenPatient.routeName);
                        },
                        child: Card(
                          elevation: 1,
                          child: Container(
                            width: screenWidth * 0.275,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.0125,
                              vertical: screenHeight * 0.02,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/Heart-Outlined.png",
                                  width: 0.04166 * 2 * _width,
                                  height: 0.04166 * 2 * _width,
                                ),
                                SizedBox(
                                  height: 0.01023 * _height,
                                ),
                                Center(
                                  child: Text(
                                    isLangEnglish ? "Wellness" : "वेल्नेस",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: AppColors.AppmainColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.0125 * 2 * _height,
                ),

                Align(
                  child: Container(
                    width: screenWidth * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            isLangEnglish ? "For today" : "आज के लिए",
                            style: TextStyle(
                                color: Color(0xff2C2C2C),
                                fontSize: screenWidth * 0.055,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Provider.of<PatientHomeScreenrDetails>(context)
                                .items
                                .isNotEmpty
                            ? Container(
                                height: screenHeight * 0.045,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.5),
                                  color: Color.fromRGBO(196, 196, 196, 1),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0.025 * _width,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AppointmentsAndTestsScreenPatient(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    isLangEnglish ? "View All" : "सभी को देखें",
                                    style: TextStyle(
                                      color: Color(0xff9B9B9B),
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.0125 * screenHeight,
                ),

                Provider.of<PatientHomeScreenrDetails>(context).items.isEmpty
                    ?
                    // RefreshIndicator(
                    //     onRefresh: () {
                    //       return _refreshTheStatusOfBookedTokens(context);
                    //     },
                    //     child: Align(
                    //       child: Container(
                    //         alignment: Alignment.center,
                    //         height: screenHeight * 0.25,
                    //         width: screenWidth * 0.8,
                    //         padding: EdgeInsets.symmetric(
                    //           horizontal: screenWidth * 0.04,
                    //           vertical: screenHeight * 0.005,
                    //         ),
                    //         child: Text(
                    //           "No upcoming appointments available",
                    //           style: TextStyle(
                    //             fontStyle: FontStyle.italic,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: screenWidth * 0.075,
                    //             color: Color.fromRGBO(66, 204, 195, 1),
                    //           ),
                    //           textAlign: ui.TextAlign.center,
                    //         ),
                    //       ),
                    //     ),)

                    Container(
                        width: screenWidth * 0.95,
                        // height: screenHeight * 0.225,
                        height: screenHeight * 0.275,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.075,
                          vertical: screenHeight * 0.025,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white70,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                isLangEnglish
                                    ? "\"No appointments for today\""
                                    : "\"आज के लिए कोई अपॉइंटमेंट नहीं\"",
                                style: TextStyle(
                                  color: Color.fromRGBO(196, 207, 238, 1),
                                  fontSize: screenWidth * 0.0425,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              child: Text(
                                isLangEnglish
                                    ? "\"Laughing is good for the heart and can increase the blood flow by 20X\""
                                    : "\"हंसना दिल के लिए अच्छा होता है और यह रक्त प्रवाह को बढ़ाता है\"",
                                style: TextStyle(
                                  color: Color.fromRGBO(196, 207, 238, 1),
                                  fontSize: screenWidth * 0.0425,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Align(
                        child: Container(
                          height: screenHeight * 0.325,
                          width: screenWidth,
                          child: ListView.builder(
                            itemCount:
                                Provider.of<PatientHomeScreenrDetails>(context)
                                    .items
                                    .length,
                            itemBuilder: (ctx, index) {
                              return appointmentReminderWidget(
                                context,
                                Provider.of<PatientHomeScreenrDetails>(context,
                                        listen: false)
                                    .items[index],
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void set_scroll_list() {
    scroll = [
      Container(
        height: 0.153452 * _height,
        width: 0.89 * _width,
        decoration: BoxDecoration(
          color: Color(0xffC3EFED),
          borderRadius: BorderRadius.circular(
            0.04466 * _width,
          ),
        ),
      ),
      Container(
        height: 0.153452 * _height,
        width: 0.89 * _width,
        decoration: BoxDecoration(
          color: AppColors.AppmainColor,
          borderRadius: BorderRadius.circular(
            0.04466 * _width,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0.030555 * _width,
              top: 0,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/HomeImage.png"),
              ),
            ),
            Positioned(
              top: 0.038363 * _height,
              right: 0.08333 * _width,
              child: Column(
                children: [
                  Container(
                    width: 0.27222 * _width,
                    child: Text(
                      isLangEnglish
                          ? "Book Tests Online!"
                          : "ऑनलाइन टेस्ट बुक करें!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.015345 * _height,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          0.022222 * _width,
                          0.010230 * _height,
                          0.022222 * _width,
                          0.010230 * _height),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          0.022222 * _width,
                        ),
                      ),
                      width: 0.27222 * _width,
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            children: [
                              // TextSpan(
                              //   text: "Developer: ",
                              //   style: TextStyle(
                              //     color: Colors.black,
                              //     // fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              // WidgetSpan(
                              //   child: Icon(
                              //     Icons.ads_click_rounded,
                              //   ),
                              // ),
                              TextSpan(
                                // style: linkText,
                                text:
                                    isLangEnglish ? "Know More" : "अधिक जानिए",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(
                                    0xff42ccc3,
                                  ),
                                  // decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    var url =
                                        "https://www.youtube.com/watch?v=Afy9yv6DQZU";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                              ),
                            ],
                          ),
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
      Container(
        height: 0.153452 * _height,
        width: 0.89 * _width,
        decoration: BoxDecoration(
          color: Color(0xff8FE1DB),
          borderRadius: BorderRadius.circular(0.04466 * _width),
        ),
      ),
    ];
  }

  Widget appointmentReminderWidget(
    BuildContext context,
    BookedTokenSlotInformation tokenInfo,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    int hrs = (tokenInfo.bookedTokenTime.hour % 12);
    if (hrs == 0) {
      hrs = 12;
    }
    int mins = tokenInfo.bookedTokenTime.minute;
    String sig =
        (tokenInfo.bookedTokenTime.hour / 12).ceil() == 0 ? "AM" : "PM";

    String time =
        "${hrs < 10 ? "0" : ""}${hrs}:${mins < 10 ? "0" : ""}${mins} ${sig}";

    return GestureDetector(
      onTap: () {},
      child: Align(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child:Container(
          height: screenHeight * 0.125,
          width: screenWidth * 0.9,
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.005,
            horizontal: screenWidth * 0.01,
          ),
          margin: EdgeInsets.only(
            top: screenHeight * 0.0075,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white70,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.watch_later_outlined,
                  size: 50,
                  color: AppColors.AppmainColor,
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: isLangEnglish ? 'Appointment' : "नियुक्ति",
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Dr. ${tokenInfo.doctorFullName} ',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 165, 174, 200),
                              ),
                            ),
                            TextSpan(
                              text: isLangEnglish
                                  ? '\nat ${tokenInfo.bookedTokenTime.format(context)}'
                                  : '\nपर ${tokenInfo.bookedTokenTime.format(context)}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 165, 174, 200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(),
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth * 0.001,
              ),
              SizedBox(
                width: screenWidth * 0.001,
              ),
              SizedBox(
                width: screenWidth * 0.001,
              ),
              Container(
                child: ClipOval(
                  child: Material(
                    color: Color.fromRGBO(220, 229, 228, 1), // Button color
                    child: InkWell(
                      splashColor:
                          Color.fromRGBO(120, 158, 156, 1), // Splash color
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ViewBookedTokenScreen(
                              0,
                              tokenInfo,
                            ),
                          ),
                        );
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: SizedBox(
                          width: screenWidth * 0.075,
                          height: screenWidth * 0.075,
                          child: Icon(
                            Icons.navigate_next_rounded,
                            size: 21,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.0001,
              ),
            ],
          ),
        ),)
      ),
    );
  }

  Widget medicineReminderWidget(
    BuildContext context,
    String medicineName,
    String instructionText,
    TimeOfDay appointmentTime,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: screenHeight * 0.1,
        width: screenWidth * 0.9,
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.005,
          horizontal: screenWidth * 0.01,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white70,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(
                Icons.watch_later_outlined,
                size: 50,
                color: AppColors.AppmainColor,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '${medicineName}',
                            style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '${instructionText} ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 165, 174, 200),
                            ),
                          ),
                          TextSpan(
                            text: 'at ${appointmentTime.format(context)}',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 165, 174, 200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth * 0.001,
            ),
            SizedBox(
              width: screenWidth * 0.001,
            ),
            SizedBox(
              width: screenWidth * 0.001,
            ),
            Container(
              child: ClipOval(
                child: Material(
                  color: Color.fromRGBO(220, 229, 228, 1), // Button color
                  child: InkWell(
                    splashColor:
                        Color.fromRGBO(120, 158, 156, 1), // Splash color
                    onTap: () {
                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: SizedBox(
                        width: screenWidth * 0.075,
                        height: screenWidth * 0.075,
                        child: Icon(
                          Icons.navigate_next_rounded,
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: screenWidth * 0.0001,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
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
