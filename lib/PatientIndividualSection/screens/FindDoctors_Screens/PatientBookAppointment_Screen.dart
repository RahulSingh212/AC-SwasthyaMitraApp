// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_key_in_widget_constructors, unnecessary_string_interpolations, unnecessary_new, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers, unused_import, duplicate_import, must_be_immutable, unused_local_variable, unused_field, must_call_super, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:weekday_selector/weekday_selector.dart';
import 'package:duration_picker/duration_picker.dart';

import '../../Helper/constants.dart';
import '../../models/doctor_Info.dart';
import '../../models/slot_info.dart';
import '../../providers/appointmentUpdation_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientAuth_details.dart';
import '../../providers/patientUser_details.dart';
import '../AppointsAndTests_Screens/AppointmentsNTests_Screen.dart';
import '../HealthNFitness_Screens/HealthAndFitness_screen.dart';
import '../Home_Screens/Home_Screen.dart';
import '../Setting_Screens/TermsAndCondition_Screen.dart';
import '../Tabs_Screen.dart';
import 'FindDoctorScreen.dart';

class PatientBookAppointmentBookingScreen extends StatefulWidget {
  int pageIndex;
  DoctorDetailsInformation doctorDetails;
  DoctorSlotInformation slotInfoDetails;

  PatientBookAppointmentBookingScreen(
    this.pageIndex,
    this.doctorDetails,
    this.slotInfoDetails,
  );

  @override
  State<PatientBookAppointmentBookingScreen> createState() =>
      _PatientBookAppointmentBookingScreenState();
}

class _PatientBookAppointmentBookingScreenState
    extends State<PatientBookAppointmentBookingScreen> {
  // String SecretKeyForReceivingAccount = "dKkgD6mKUnO6ULiBqKXDdcXL";
  // String SecretKeyForTheApplication = "rzp_test_30GMNmjgB5gp2H";
  String SecretKeyForReceivingAccount = "zjtYNy1zRnFt86IdbdO9I2Jp";
  String SecretKeyForTheApplication = "rzp_test_gXb3YhX0TlQsBs";
  bool isAppointmentCreated = false;
  String orderid = "";
  late Razorpay _razorpay;

  TextEditingController patientBloodPressure = new TextEditingController();
  TextEditingController patientBodyTemperature = new TextEditingController();

  bool isLangEnglish = true;
  String patientPhoneNumber = "";
  TabController? _tabController;
  DateTime dateOfToday = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime dateOfTomorrow = DateTime.utc(
    DateTime.now().add(new Duration(days: 1)).year,
    DateTime.now().add(new Duration(days: 1)).month,
    DateTime.now().add(new Duration(days: 1)).day,
  );

  bool _isAppointmentDateSelected = false;
  DateTime choosenAppointmentDate = DateTime.now();
  bool isSlotsAvailabelOnSelectedDay = false;

  bool isClinicBtnSelected = false;
  bool isVideoBtnSelected = false;
  bool isConfirmButtonClicked = false;

  bool isSlotTimeOfDaySelected = false;
  TimeOfDay? choosenTimeOfDay;

  String patientAlimentText = "";

  List<bool> selectedWidgetList = [];

  List<String> WeekListEnglish = [
    "Mon",
    "Tues",
    "Wed",
    "Thr",
    "Fri",
    "Sat",
    "Sun"
  ];
  List<String> YearListEnglish = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  Color _color1 = AppColors.AppmainColor;
  var _color = Color(0xffEBEBEB);
  String appointnmentType = "Clinic Appointment";

  int selecteddateindex = 0;
  int slotindex = 0;

  var _pages = [];
  int _selectedPageIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Provider.of<AppointmentUpdationDetails>(context).items.isNotEmpty) {
      isSlotsAvailabelOnSelectedDay = true;
      selectedWidgetList = List<bool>.filled(
          Provider.of<AppointmentUpdationDetails>(context, listen: false)
              .items
              .length,
          false);
    }
  }

  Future<void> _refreshTheStatusOfTheAppointment(BuildContext context) async {
    Provider.of<AppointmentUpdationDetails>(context, listen: false)
        .checkAppointmentDetails(
      context,
      widget.slotInfoDetails,
      choosenAppointmentDate,
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _razorpay.clear();
  // }

  @override
  void initState() {
    patientPhoneNumber = Provider.of<PatientUserDetails>(context, listen: false)
            .mp['patient_PhoneNumber'] ??
        "";
    if (widget.slotInfoDetails.isClinic && widget.slotInfoDetails.isVideo) {
      isClinicBtnSelected = true;
    } else {
      if (widget.slotInfoDetails.isClinic) {
        isClinicBtnSelected = true;
      } else {
        isVideoBtnSelected = true;
      }
    }

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;

    // Provider.of<PatientTransactionDetails>(context, listen: false).executePatientAppointmentTransaction(context, widget.doctorDetails, widget.slotInfoDetails);
    // if (!widget.slotInfoDetails.isRepeat) {
    //   _refreshTheStatusOfTheAppointment(context);
    //   _isAppointmentDateSelected = true;
    //   choosenAppointmentDate = widget.slotInfoDetails.expiredDate;
    // }

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
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
              "title": title,
              "body": body,
              "android_channel_id": "aurigaCare",
            },
            "to": token,
          },
        ),
      );
    } catch (errorVal) {
      print("Push Message Error: " + "$errorVal");
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final key = utf8.encode(SecretKeyForReceivingAccount);
    final bytes = utf8.encode('$orderid|${response.paymentId}');

    final hmacSha256 = Hmac(sha256, key);
    final Digest generatedSignature = hmacSha256.convert(bytes);

    if (generatedSignature.toString() == response.signature) {
      print('payment successful...');

      String pName = Provider.of<PatientUserDetails>(context, listen: false)
          .mp["patient_FullName"]
          .toString();
      String pushMessageTitle = "Appointment booked";
      String pushMessageBody =
          "Patient Name: ${pName},${"\n"}Time:${choosenTimeOfDay?.format(context).toString()},${"\n"}Date: ${DateFormat.yMMMMd('en_US').format(choosenAppointmentDate)}";
      sendPushMessage(
        widget.doctorDetails.doctor_MobileMessagingTokenId,
        pushMessageBody,
        pushMessageTitle,
      );

      PatientAppointmentCreationProgress(context);
      if (widget.slotInfoDetails.isClinic && widget.slotInfoDetails.isVideo) {
        if (isClinicBtnSelected) {
          Provider.of<AppointmentUpdationDetails>(context, listen: false)
              .savePatientAppointmentSlot(
            context,
            true,
            false,
            choosenTimeOfDay!,
            choosenAppointmentDate,
            patientAlimentText,
            widget.slotInfoDetails,
            widget.doctorDetails,
            Provider.of<PatientUserDetails>(context, listen: false)
                .getIndividualObjectDetails(),
          );
        } else {
          Provider.of<AppointmentUpdationDetails>(context, listen: false)
              .savePatientAppointmentSlot(
            context,
            false,
            true,
            choosenTimeOfDay!,
            choosenAppointmentDate,
            patientAlimentText,
            widget.slotInfoDetails,
            widget.doctorDetails,
            Provider.of<PatientUserDetails>(context, listen: false)
                .getIndividualObjectDetails(),
          );
        }
      } else {
        if (widget.slotInfoDetails.isClinic) {
          Provider.of<AppointmentUpdationDetails>(context, listen: false)
              .savePatientAppointmentSlot(
            context,
            true,
            false,
            choosenTimeOfDay!,
            choosenAppointmentDate,
            patientAlimentText,
            widget.slotInfoDetails,
            widget.doctorDetails,
            Provider.of<PatientUserDetails>(context, listen: false)
                .getIndividualObjectDetails(),
          );
        } else {
          Provider.of<AppointmentUpdationDetails>(context, listen: false)
              .savePatientAppointmentSlot(
            context,
            false,
            true,
            choosenTimeOfDay!,
            choosenAppointmentDate,
            patientAlimentText,
            widget.slotInfoDetails,
            widget.doctorDetails,
            Provider.of<PatientUserDetails>(context, listen: false)
                .getIndividualObjectDetails(),
          );
        }
      }

      // Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Payment was unauthentic!"),
        ),
      );
      print("Payment was unauthentic!");
    }
  }

  Future<void> _creatingAppoitmentAfterSuccessfulPayment() async {
    print('payment successful...');

      String pName = Provider.of<PatientUserDetails>(context, listen: false)
          .mp["patient_FullName"]
          .toString();
      String pushMessageTitle = "Appointment booked";
      String pushMessageBody =
          "Patient Name: ${pName},${"\n"}Time:${choosenTimeOfDay?.format(context).toString()},${"\n"}Date: ${DateFormat.yMMMMd('en_US').format(choosenAppointmentDate)}";
      sendPushMessage(
        widget.doctorDetails.doctor_MobileMessagingTokenId,
        pushMessageBody,
        pushMessageTitle,
      );

    PatientAppointmentCreationProgress(context);
    if (widget.slotInfoDetails.isClinic && widget.slotInfoDetails.isVideo) {
      if (isClinicBtnSelected) {
        Provider.of<AppointmentUpdationDetails>(context, listen: false)
            .savePatientAppointmentSlot(
          context,
          true,
          false,
          choosenTimeOfDay!,
          choosenAppointmentDate,
          patientAlimentText,
          widget.slotInfoDetails,
          widget.doctorDetails,
          Provider.of<PatientUserDetails>(context, listen: false)
              .getIndividualObjectDetails(),
        );
      } else {
        Provider.of<AppointmentUpdationDetails>(context, listen: false)
            .savePatientAppointmentSlot(
          context,
          false,
          true,
          choosenTimeOfDay!,
          choosenAppointmentDate,
          patientAlimentText,
          widget.slotInfoDetails,
          widget.doctorDetails,
          Provider.of<PatientUserDetails>(context, listen: false)
              .getIndividualObjectDetails(),
        );
      }
    } else {
      if (widget.slotInfoDetails.isClinic) {
        Provider.of<AppointmentUpdationDetails>(context, listen: false)
            .savePatientAppointmentSlot(
          context,
          true,
          false,
          choosenTimeOfDay!,
          choosenAppointmentDate,
          patientAlimentText,
          widget.slotInfoDetails,
          widget.doctorDetails,
          Provider.of<PatientUserDetails>(context, listen: false)
              .getIndividualObjectDetails(),
        );
      } else {
        Provider.of<AppointmentUpdationDetails>(context, listen: false)
            .savePatientAppointmentSlot(
          context,
          false,
          true,
          choosenTimeOfDay!,
          choosenAppointmentDate,
          patientAlimentText,
          widget.slotInfoDetails,
          widget.doctorDetails,
          Provider.of<PatientUserDetails>(context, listen: false)
              .getIndividualObjectDetails(),
        );
      }
    }

    print("end..");
    print("end..");
    print("end..");
    print("end..");
    // Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    PaynmentError(context);
    print('Error: payment error');
    print(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('Error: payment error value');
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;

    var availableAptDetails =
        Provider.of<AppointmentUpdationDetails>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff42CCC3),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Container(
                  width: screenWidth,
                  child: Align(
                    child: Container(
                      width: screenWidth * 0.925,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 0.08055 * _width / 2,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: AppColors.AppmainColor,
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   child: Icon(
                          //     Icons.library_add_outlined,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.925,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: screenWidth * 0.275,
                          width: screenWidth * 0.275,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.011111 * _width,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          child: CircleAvatar(
                            radius: screenWidth * 0.6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                screenWidth * 0.2,
                              ),
                              child: ClipOval(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: widget.doctorDetails
                                              .doctor_ProfilePicUrl ==
                                          ""
                                      ? Image.asset(
                                          "assets/images/uProfile.png",
                                        )
                                      : Image.network(
                                          widget.doctorDetails
                                              .doctor_ProfilePicUrl,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                child: Text(
                                  widget.doctorDetails.doctor_FullName
                                          .toLowerCase()
                                          .startsWith("dr")
                                      ? widget.doctorDetails.doctor_FullName
                                      : "Dr. ${widget.doctorDetails.doctor_FullName}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.05,
                                    color: Colors.white,
                                  ),
                                  softWrap: false,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(
                                height: 0.01534 * _height,
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(
                                  left: 0.013888 * _width,
                                  top: 0.006393 * _height,
                                  bottom: 0.006393 * _height,
                                  right: 0.013888 * _width,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Container(
                                      width: screenWidth * 0.5,
                                      child: DefaultTextStyle(
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.AppmainColor,
                                        ),
                                        child: Text(
                                          "${widget.doctorDetails.doctor_Speciality}",
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0.011508 * _height,
                              ),
                              DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                                child: Text(
                                  "${widget.doctorDetails.doctor_ExperienceRating.toString()} ${isLangEnglish ? "Ratings" : "रेटिंग्स"}",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
              ],
            ),
          ), // Top Container Ending
          SizedBox(
            height: 0.0085 * _height,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 0.055555 * _width,
              right: 0.055555 * _width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                        child: Text(
                          !_isAppointmentDateSelected
                              ? isLangEnglish
                                  ? "Select your Date ➡"
                                  : "अपनी तिथि चुनें ➡"
                              : "${isLangEnglish ? "Date:" : "दिनांक:"} ${DateFormat.yMMMMd('en_US').format(choosenAppointmentDate)}",
                          style: TextStyle(
                            color: Color(0xff2c2c2c),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _presentDatePicker(context, widget.slotInfoDetails);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.0065,
                          ),
                          height: screenHeight * 0.055,
                          width: screenHeight * 0.035,
                          decoration: BoxDecoration(
                              // color: Color.fromRGBO(66, 204, 195, 1),
                              ),
                          child: Image(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              "assets/images/Calendar.png",
                            ),
                            color: Color.fromRGBO(108, 117, 125, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.0025 * _height,
                ),
                Divider(
                  thickness: 2,
                  color: Color(0xffD4D4D4),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),

          !_isAppointmentDateSelected
              ? Align(
                  child: Container(
                    alignment: Alignment.center,
                    height: screenHeight * 0.45,
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.005,
                    ),
                    child: Text(
                      isLangEnglish
                          ? "Please select your preferred appointment date"
                          : "",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.075,
                        color: Color.fromRGBO(66, 204, 195, 1),
                      ),
                      textAlign: ui.TextAlign.center,
                    ),
                  ),
                )
              : !isSlotsAvailabelOnSelectedDay
                  ? Align(
                      child: Container(
                        alignment: Alignment.center,
                        height: screenHeight * 0.45,
                        width: screenWidth * 0.9,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.005,
                        ),
                        child: Text(
                          isLangEnglish
                              ? "No available slots are left for the day \n\nTry booking for another day"
                              : "No available slots are left for the day \n\nTry booking for another day",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.075,
                            color: Color.fromRGBO(66, 204, 195, 1),
                          ),
                          textAlign: ui.TextAlign.center,
                        ),
                      ),
                    )
                  : Align(
                      child: Container(
                        width: screenWidth * 0.9,
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    isLangEnglish ? 'Available: ' : "उपलब्ध: ",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${availableAptDetails.items.length} ${isLangEnglish ? "Slots" : "स्लॉट्स"}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.045,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

          _isAppointmentDateSelected && isSlotsAvailabelOnSelectedDay
              ? Align(
                  child: Container(
                    height: screenHeight * 0.1,
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.only(
                      bottom: screenHeight * 0.03,
                    ),
                    child:
                        // Provider.of<AppointmentUpdationDetails>(context,
                        //             listen: false)
                        //         .items
                        //         .isEmpty
                        //     ? RefreshIndicator(
                        //         onRefresh: () =>
                        //             _refreshTheStatusOfTheAppointment(context),
                        //         child: Container(
                        //           child: Text(
                        //             "Fetching details from the database",
                        //           ),
                        //         ),
                        //       )
                        //     :
                        ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.005,
                      ),
                      itemCount: Provider.of<AppointmentUpdationDetails>(
                              context,
                              listen: false)
                          .items
                          .length,
                      itemBuilder: (ctx, index) {
                        return showSlotTimeWidget(
                          context,
                          Provider.of<AppointmentUpdationDetails>(context,
                                  listen: false)
                              .items[index],
                          index,
                        );
                      },
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),

          _isAppointmentDateSelected && isSlotsAvailabelOnSelectedDay
              ? Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.only(
                      bottom: screenHeight * 0.02,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        isLangEnglish
                            ? "Choose a method of appointment or consultation"
                            : "नियुक्ति या परामर्श का तरीका चुनें",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          _isAppointmentDateSelected && isSlotsAvailabelOnSelectedDay
              ? Align(
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.925,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.035,
                    ),
                    decoration: BoxDecoration(
                      color: ui.Color.fromARGB(179, 234, 224, 224),
                      border: Border.all(
                        width: 2,
                        color: Color.fromRGBO(66, 204, 195, 1),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.slotInfoDetails.isClinic
                          ? isLangEnglish
                              ? "Clinic Appointment"
                              : "क्लिनिक नियुक्ति"
                          : isLangEnglish
                              ? "Video Consultation"
                              : "वीडियो परामर्श",
                      style: TextStyle(
                        color: Color.fromRGBO(66, 204, 195, 1),
                        fontSize: screenWidth * 0.075,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          SizedBox(
            height: screenHeight * 0.025,
          ),

          _isAppointmentDateSelected && isSlotsAvailabelOnSelectedDay
              ? Align(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.only(
                      bottom: screenHeight * 0.0075,
                    ),
                    child: Text(
                      isLangEnglish ? "Bill Details:" : "बिल विवरण:",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          _isAppointmentDateSelected && isSlotsAvailabelOnSelectedDay
              ? Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            (widget.slotInfoDetails.isClinic &&
                                    widget.slotInfoDetails.isVideo)
                                ? isClinicBtnSelected
                                    ? isLangEnglish
                                        ? "Appointment Fees"
                                        : "नियुक्ति शुल्क"
                                    : isLangEnglish
                                        ? "Consultation Fees"
                                        : "परामर्श शुल्क"
                                : widget.slotInfoDetails.isClinic
                                    ? isLangEnglish
                                        ? "Appointment Fees"
                                        : "नियुक्ति शुल्क"
                                    : isLangEnglish
                                        ? "Consultation Fees"
                                        : "परामर्श शुल्क",
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '₹ ',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.065,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${widget.slotInfoDetails.appointmentFeesPerPatient.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          _isAppointmentDateSelected && isSlotsAvailabelOnSelectedDay
              ? Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Divider(
                      thickness: 2,
                      color: Color(0xffD4D4D4),
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
          _isAppointmentDateSelected && isSlotsAvailabelOnSelectedDay
              ? Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            isLangEnglish ? "Total Payable" : "कुल देय",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.055,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: '₹ ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.065,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${widget.slotInfoDetails.appointmentFeesPerPatient.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.055,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
        ],
      ),
      floatingActionButton: isConfirmButtonClicked
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.AppmainColor,
              onPressed: () {
                if (!_isAppointmentDateSelected) {
                  String titleText = isLangEnglish
                      ? "Invalid Appointment Date"
                      : "अमान्य नियुक्ति तिथि";
                  String contextText = isLangEnglish
                      ? "Please select your appointment date"
                      : "कृपया अपनी नियुक्ति तिथि चुनें";
                  _checkForError(context, titleText, contextText);
                } else if (!isSlotsAvailabelOnSelectedDay) {
                  String titleText = isLangEnglish
                      ? "No slots available"
                      : "कोई स्लॉट उपलब्ध नहीं";
                  String contextText = isLangEnglish
                      ? "No slots are left for the day😞 \nTry booking for another day"
                      : "दिन के लिए कोई स्लॉट नहीं बचा है😞 \nएक और दिन के लिए बुकिंग का प्रयास करें";
                  _checkForError(context, titleText, contextText);
                } else if (!isSlotTimeOfDaySelected) {
                  String titleText = isLangEnglish
                      ? "Slot not selected"
                      : "स्लॉट नहीं चुना गया";
                  String contextText = isLangEnglish
                      ? "Please select your preferred appointment slot"
                      : "कृपया अपना पसंदीदा अपॉइंटमेंट स्लॉट चुनें";
                  _checkForError(context, titleText, contextText);
                } else {
                  _patientAilmentShowBox(context);
                  // PatientAppointmentCreationProgress(context);
                }
                // else if (widget.slotInfoDetails.isClinic &&
                //     widget.slotInfoDetails.isVideo) {
                //   if (isClinicBtnSelected) {
                //     Provider.of<AppointmentUpdationDetails>(context, listen: false)
                //         .savePatientAppointmentSlot(
                //       context,
                //       true,
                //       false,
                //       choosenTimeOfDay!,
                //       choosenAppointmentDate,
                //       patientAlimentText,
                //       widget.slotInfoDetails,
                //       widget.doctorDetails,
                //     );
                //   } else {
                //     Provider.of<AppointmentUpdationDetails>(context, listen: false)
                //         .savePatientAppointmentSlot(
                //       context,
                //       false,
                //       true,
                //       choosenTimeOfDay!,
                //       choosenAppointmentDate,
                //       patientAlimentText,
                //       widget.slotInfoDetails,
                //       widget.doctorDetails,
                //     );
                //   }
                // } else {
                //   if (widget.slotInfoDetails.isClinic) {
                //     Provider.of<AppointmentUpdationDetails>(context, listen: false)
                //         .savePatientAppointmentSlot(
                //       context,
                //       true,
                //       false,
                //       choosenTimeOfDay!,
                //       choosenAppointmentDate,
                //       patientAlimentText,
                //       widget.slotInfoDetails,
                //       widget.doctorDetails,
                //     );
                //   } else {
                //     Provider.of<AppointmentUpdationDetails>(context, listen: false)
                //         .savePatientAppointmentSlot(
                //       context,
                //       false,
                //       true,
                //       choosenTimeOfDay!,
                //       choosenAppointmentDate,
                //       patientAlimentText,
                //       widget.slotInfoDetails,
                //       widget.doctorDetails,
                //     );
                //   }
                // }
              },
              child: Icon(
                Icons.arrow_forward,
                size: 28,
              ),
            ),
    );
  }

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
      'timeout': 600, // in seconds
      'prefill': {'contact': '${patientPhoneNumber}', 'email': ''}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> PaynmentError(BuildContext context) async {
    Timer _timerOut = Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenPatient.routeName, (route) => false);
    });
    return await showDialog(
      context: context,
      builder: (ctx) {
        // var _timer = Timer(Duration(seconds: 5), () {
        //   Navigator.pop(ctx);
        //   // Navigator.of(context).pushNamedAndRemoveUntil(
        //   //     TabsScreenPatient.routeName, (route) => false);
        // });

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
                    isLangEnglish ? "PAYMENT UNSUCCESSFUL" : "भुगतान असफल",
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
    ).then((value) {
      _timerOut.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenPatient.routeName, (route) => false);
    });
  }

  Future<void> PaynmentSuccessful(BuildContext context) async {
    var builderContext = context;

    Timer _timerOut = Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenPatient.routeName, (route) => false);
    });

    return await showDialog(
      context: context,
      builder: (ctx) {
        var _timer = Timer(Duration(seconds: 2), () {
          Navigator.pop(ctx);
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     TabsScreenPatient.routeName, (route) => false);
        });

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
                  isLangEnglish ? "PAYMENT SUCCESSFUL" : "भुगतान सफल",
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
    ).then((value) {
      // Navigator.pop(builderContext);
      _timerOut.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenPatient.routeName, (route) => false);
    });
  }

  Future<void> PatientAppointmentCreationProgress(BuildContext context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    Timer _timerOut = Timer(Duration(seconds: 6), () {
      PaynmentSuccessful(context);
    });
    return await showDialog(
      context: context,
      builder: (ctx) {
        Timer _timer = Timer(Duration(seconds: 5), () {
          Navigator.pop(ctx);
          // PaynmentSuccessful(context);
        });
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(25),
            height: screenHeight * 0.65,
            width: screenWidth * 0.8,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: minDimension * 0.25,
                    width: minDimension * 0.25,
                    child: CircularProgressIndicator(),
                  ),
                ),
                SizedBox(
                  height: maxDimension * 0.05,
                ),
                Center(
                  child: Text(
                    isLangEnglish ? "In Progress..." : "प्रगति में...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: minDimension * 0.065,
                    ),
                  ),
                ),
                SizedBox(
                  height: maxDimension * 0.065,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffD3F3F1),
                    ),
                    child: Text(
                      isLangEnglish
                          ? "Creating your appointment in progress..."
                          : "आपका अपॉइंटमेंट तैयार किया जा रहा है...",
                      textAlign: ui.TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffD3F3F1),
                    ),
                    child: Text(
                      isLangEnglish
                          ? "Please wait and don't press anything while your appointment gets created"
                          : "कृपया प्रतीक्षा करें और जब तक आपका अपॉइंटमेंट तैयार न हो जाए, तब तक कुछ भी न दबाएं.",
                      textAlign: ui.TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      _timerOut.cancel();
      PaynmentSuccessful(context);
    });
  }

  Future<void> _patientAilmentShowBox(BuildContext context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: max(screenHeight, screenWidth) * 0.575,
            width: min(screenHeight, screenWidth) * 0.925,
            padding: EdgeInsets.symmetric(
              horizontal: min(screenHeight, screenWidth) * 0.04,
              vertical: min(screenHeight, screenWidth) * 0.06,
            ),
            child: ListView(
              physics: ScrollPhysics(),
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Date\n' : "दिनांक\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${WeekListEnglish[choosenAppointmentDate.weekday - 1]}, ${choosenAppointmentDate.day} ${YearListEnglish[choosenAppointmentDate.month - 1]}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Time\n' : "समय\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${choosenTimeOfDay?.format(context).toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
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
                  height: screenHeight * 0.0125,
                ),
                Container(
                  child: Text(
                    isLangEnglish
                        ? 'Write a brief description about your ailment:'
                        : "अपनी बीमारी के बारे में संक्षिप्त विवरण लिखें:",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01125,
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: screenWidth * 0.35,
                          // padding: EdgeInsets.only(
                          //   // top: 0.01 * height,
                          //   left: 0.02 * height,
                          //   right: 0.03 * height,
                          // ),
                          child: TextField(
                            controller: patientBloodPressure,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: isLangEnglish ? 'BP' : "बीपी",
                              hintText: isLangEnglish ? 'BP' : "बीपी",
                            ),
                            onChanged: (text) {
                              // setState(() {

                              // });
                            },
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.35,
                          // padding: EdgeInsets.only(
                          //   // top: 0.02 * height,
                          //   left: 0.02 * height,
                          //   right: 0.03 * height,
                          // ),
                          child: TextField(
                            controller: patientBodyTemperature,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: isLangEnglish
                                  ? 'Temperature(℃)'
                                  : "तापमान(℃)",
                              hintText: isLangEnglish
                                  ? 'Temperature(℃)'
                                  : "तापमान(℃)",
                            ),
                            onChanged: (text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Color.fromRGBO(205, 205, 205, 1),
                    ),
                  ),
                  child: TextField(
                    onChanged: ((value) {
                      patientAlimentText = value;
                    }),
                    decoration: InputDecoration(
                      hintText: 'Enter your ailment...',
                      focusedBorder: InputBorder.none,
                    ),
                    autocorrect: true,
                    minLines: 4,
                    maxLines: 4,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.035,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() {
                      String bpText = patientBloodPressure.text;
                      String temperatureText = patientBodyTemperature.text;
                      String alimentText = patientAlimentText;

                      patientAlimentText =
                          "Description: ${alimentText}, Blood Pressure: ${bpText} mmHg, Body Temperature: ${temperatureText}℃";
                    });
                    _patientAppointmentConfirmationShowBox(context);
                  },
                  child: Container(
                    width: screenWidth * 0.65,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                      horizontal: screenWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff42CCC3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        isLangEnglish ? "Next" : "अगला",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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

  Future<void> _choosePaymentMethodOption(BuildContext context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    String str1 = isLangEnglish ? "Online Payment" : "ऑनलाइन भुगतान";
    String str2 = isLangEnglish ? "Cash Payment" : "नकद भुगतान";

    String titleText = isLangEnglish
        ? "Choose your payment option"
        : "अपना भुगतान विकल्प चुनें";
    String contextText = isLangEnglish
        ? "Select from available options"
        : "उपलब्ध विकल्पों में से चुनें";

    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              // For Online Transactions
              Navigator.pop(ctx);
              createOrder(
                context,
                widget.doctorDetails,
                widget.slotInfoDetails,
                patientPhoneNumber,
                choosenAppointmentDate,
                choosenTimeOfDay!,
              );
            },
            child: Container(
              width: screenWidth * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueAccent,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.015,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.language_outlined,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      str1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          InkWell(
            onTap: () async {
              // For Pay by Cash
              Navigator.pop(ctx);
              _creatingAppoitmentAfterSuccessfulPayment();
            },
            child: Container(
              width: screenWidth * 0.7,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.015,
                vertical: screenWidth * 0.025,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.075,
                vertical: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.money,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      str2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _patientAppointmentConfirmationShowBox(
      BuildContext context) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return await showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: max(screenHeight, screenWidth) * 0.675,
            width: min(screenHeight, screenWidth) * 0.85,
            padding: EdgeInsets.symmetric(
              horizontal: min(screenHeight, screenWidth) * 0.04,
              vertical: min(screenHeight, screenWidth) * 0.06,
            ),
            child: ListView(
              physics: ScrollPhysics(),
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Date\n' : "दिनांक\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${WeekListEnglish[choosenAppointmentDate.weekday - 1]}, ${choosenAppointmentDate.day} ${YearListEnglish[choosenAppointmentDate.month - 1]}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Time\n' : "समय\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${choosenTimeOfDay?.format(context).toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
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
                  height: screenHeight * 0.035,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 0.035 * screenWidth,
                      right: 0.035 * screenWidth,
                      top: 0.015 * screenHeight,
                      bottom: 0.015 * screenHeight,
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
                  height: screenHeight * 0.035,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PatientTermsAndConditionsScreen(
                          3,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * 0.6,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: isLangEnglish
                                  ? "I've read and accept the "
                                  : "मैंने पढ़ा और स्वीकार करता हूं ",
                              style: TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(137, 134, 137, 1),
                              ),
                            ),
                            TextSpan(
                              text: isLangEnglish
                                  ? 'terms and conditions.'
                                  : "नियम और शर्तें।",
                              style: TextStyle(
                                color: Color.fromRGBO(66, 204, 195, 1),
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      (widget.slotInfoDetails.isClinic &&
                              widget.slotInfoDetails.isVideo)
                          ? isClinicBtnSelected
                              ? isLangEnglish
                                  ? "Clinic Appointment"
                                  : "क्लिनिक अपॉइंटमेंट"
                              : isLangEnglish
                                  ? "Video Appointment"
                                  : "वीडियो अपॉइंटमेंट"
                          : widget.slotInfoDetails.isClinic
                              ? isLangEnglish
                                  ? "Clinic Appointment"
                                  : "क्लिनिक अपॉइंटमेंट"
                              : isLangEnglish
                                  ? "Video Appointment"
                                  : "वीडियो अपॉइंटमेंट",
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.0015,
                ),
                Align(
                  child: Container(
                    width: screenWidth * 0.7,
                    child: Divider(
                      thickness: 2,
                      color: Color.fromRGBO(212, 212, 212, 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.0015,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          isLangEnglish ? "Total Payable" : "कुल देय",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '₹ ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${widget.slotInfoDetails.appointmentFeesPerPatient.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isConfirmButtonClicked = true;
                      print(isConfirmButtonClicked);

                      Navigator.pop(ctx);

                      if (widget.slotInfoDetails.appointmentFeesPerPatient
                              .floor() <
                          1) {
                        _creatingAppoitmentAfterSuccessfulPayment();
                      } else {
                        _choosePaymentMethodOption(context);
                        // createOrder(
                        //   context,
                        //   widget.doctorDetails,
                        //   widget.slotInfoDetails,
                        //   patientPhoneNumber,
                        //   choosenAppointmentDate,
                        //   choosenTimeOfDay!,
                        // );
                      }
                    });
                  },
                  child: Container(
                    width: screenWidth * 0.65,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                      horizontal: screenWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff42CCC3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: !isConfirmButtonClicked
                        ? Center(
                            child: Text(
                              isLangEnglish ? "CONFIRM" : "पुष्टि करें",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      setState(() {
        isConfirmButtonClicked = false;
      });
    });
  }

  Widget showSlotTimeWidget(
    BuildContext context,
    TimeOfDay slotTime,
    int listIndex,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    bool isBoxSelected = false;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedWidgetList = List<bool>.filled(
              Provider.of<AppointmentUpdationDetails>(context, listen: false)
                  .items
                  .length,
              false);
          selectedWidgetList[listIndex] = true;
          isSlotTimeOfDaySelected = true;
          choosenTimeOfDay =
              Provider.of<AppointmentUpdationDetails>(context, listen: false)
                  .items[listIndex];
        });
      },
      child: Align(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.025,
          ),
          margin: EdgeInsets.only(
            right: screenWidth * 0.075,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: selectedWidgetList[listIndex]
                  ? Color.fromRGBO(66, 204, 195, 1)
                  : Color.fromRGBO(235, 235, 235, 1),
            ),
          ),
          child: Text(
            "${slotTime.format(context)}",
            style: TextStyle(
              color: Color.fromRGBO(66, 204, 195, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget timeDurationPicker(
    BuildContext context,
    Duration choosenDuration,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Align(
      alignment: Alignment.center,
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.75,
        child: DurationPicker(
          onChange: (pickerDuration) {
            setState(() {
              choosenDuration = pickerDuration;
            });
          },
          duration: choosenDuration,
        ),
      ),
    );
  }

  Widget weekDaySelectorWidget(
    BuildContext context,
    List<bool> selectWeekDayList,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Align(
      alignment: Alignment.center,
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.035,
          horizontal: screenWidth * 0.01,
        ),
        margin: EdgeInsets.only(
          bottom: screenHeight * 0.025,
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 254, 229, 0.9),
        ),
        child: WeekdaySelector(
          elevation: 3,
          fillColor: Colors.white,
          selectedFillColor: Color.fromRGBO(120, 158, 156, 1),
          onChanged: (int day) {
            setState(() {
              int index = day % 7;
              selectWeekDayList[index] = !selectWeekDayList[index];
            });
          },
          values: selectWeekDayList,
        ),
      ),
    );
  }

  void _presentTimePicker(
    BuildContext context,
    TimeOfDay choosenTime,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TimeOfDay timechosen = TimeOfDay.now();
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: timechosen,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(primaryColor: Color(0xff42CCC3)),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: child!,
            ),
          ),
        );
      },
    );
    if (time != null) {
      setState(() {
        choosenTime = time;
      });
    } else {
      return;
    }
  }

  void _presentDatePicker(
    BuildContext context,
    DoctorSlotInformation slotInfoDetails,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    DateTime initialDate = DateTime.now();
    DateTime finalDate = DateTime.now();

    if (slotInfoDetails.registeredDate.isAfter(dateOfToday)) {
      initialDate = slotInfoDetails.registeredDate;
    } else {
      initialDate = dateOfToday;
    }

    if (slotInfoDetails.isRepeat) {
      finalDate = initialDate.add(new Duration(days: 14));
    } else {
      finalDate = slotInfoDetails.expiredDate;
    }

    // for (int i = 0; i < 7; i++) {
    //   int val = (initialDate.weekday+i)%7;
    //   if (slotInfoDetails.repeatWeekDaysList[val] == false) {
    //     initialDate.add(new Duration(days: 1));
    //   }
    //   else {
    //     break;
    //   }
    // }

    // print(initialDate);
    // print(finalDate);
    // print(slotInfoDetails.repeatWeekDaysList);

    showDatePicker(
      context: context,
      firstDate: initialDate,
      initialDate: initialDate.add(new Duration(minutes: 1)),
      lastDate: finalDate,
      selectableDayPredicate: (DateTime day) {
        if (!widget.slotInfoDetails.isRepeat) {
          return true;
        } else {
          return true;
          // int val = day.weekday % 7;
          // print(val);
          // return slotInfoDetails.repeatWeekDaysList[val];
        }
      },
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        } else if (slotInfoDetails.isRepeat == false) {
          setState(() {
            _isAppointmentDateSelected = true;
            choosenAppointmentDate = pickedDate;
            _refreshTheStatusOfTheAppointment(context);
          });
        } else {
          int val = pickedDate.weekday % 7;

          if (!slotInfoDetails.repeatWeekDaysList[val]) {
            String titleText =
                isLangEnglish ? "In-valid week day" : "अमान्य सप्ताह का दिन";
            String contextText = isLangEnglish
                ? "This day of the week is not open for the doctor"
                : "सप्ताह का यह दिन डॉक्टर के लिए नहीं खुला है";
            _checkForError(context, titleText, contextText);
          } else {
            setState(() {
              _isAppointmentDateSelected = true;
              choosenAppointmentDate = pickedDate;
              _refreshTheStatusOfTheAppointment(context);
            });
          }
        }
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

class appointments extends StatelessWidget {
  final Color color;
  String text;
  appointments({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;
    return Container(
      margin: EdgeInsets.only(right: 0.055555 * _width),
      padding: EdgeInsets.only(
        top: 0.012787 * _height,
        bottom: 0.012787 * _height,
        left: 0.027777777 * _width,
        right: 0.027777777 * _width,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.01666 * _width),
        border: Border.all(color: color, width: 0.005555 * _width),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xff2c2c2c),
            fontWeight: FontWeight.w400,
            fontSize: 15),
      ),
    );
  }
}

class TabbarItems extends StatelessWidget {
  final Color color;
  String text;
  bool isPM;
  TabbarItems({
    Key? key,
    required this.color,
    required this.text,
    this.isPM = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;
    return Container(
      margin: EdgeInsets.only(
        right: 0.055555 * _width,
        top: 0.0127877 * _height,
        bottom: 0.006393 * _height,
      ),
      padding: EdgeInsets.only(
          top: 0.012787 * _height,
          bottom: 0.012787 * _height,
          left: 0.027777777 * _width,
          right: 0.027777777 * _width),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.01666 * _width),
        border: Border.all(color: color, width: 0.005555 * _width),
      ),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: AppColors.AppmainColor,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          Text(
            " PM",
            style: TextStyle(
              color: AppColors.AppmainColor,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  String text;
  int noofslot;
  Color color;
  TabItem(
      {Key? key,
      required this.text,
      required this.noofslot,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;
    return Container(
      margin: EdgeInsets.only(right: 0.013888 * _width),
      padding: EdgeInsets.only(
          left: 0.0083333 * _width,
          right: 0.0083333 * _width,
          top: 0.0038363 * _height,
          bottom: 0.0038363 * _height),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.01666 * _width),
        border: Border.all(color: color, width: 0.005555 * _width),
      ),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
                color: Color(0xff2c2c2c),
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(
            "$noofslot ${"slots available"}",
            style: TextStyle(
              color: AppColors.AppmainColor,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
