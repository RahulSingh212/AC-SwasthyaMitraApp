// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, unused_import, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unused_element, duplicate_import

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/models/slot_info.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../../models/appointment_info.dart';
import '../../providers/SM_DashBoard_Details.dart';
import '../../providers/SM_User_Details.dart';

import '../../models/slot_info.dart';

class ScheduleScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-schedule-test-screen';

  @override
  State<ScheduleScreenSwasthyaMitra> createState() =>
      _ScheduleScreenSwasthyaMitraState();
}

class _ScheduleScreenSwasthyaMitraState extends State<ScheduleScreenSwasthyaMitra> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish = isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


  }

  Future<void> _refreshSwasthyaMitraAvailableSlots(BuildContext context) async {

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

    return Scaffold(
      backgroundColor: Color(0xFFf2f3f4),
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          enableFeedback: false,
          onPressed: () {
            // Navigator.of(context).pushReplacementNamed(MyProfileScreen.routeName);
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Color(0xff42ccc3),
            size: 35,
          ),
        ),
        title: Text(
          isLangEnglish ? "My Schedule" : "मेरे अनुसूची",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(),
    );
  }

  Widget CalendarAppointmentDetailsWidgets(
    BuildContext context,
    SwasthyaMitrSlotInformation slotInfoDetails,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var avlScreenHeight = screenHeight - topInsets - bottomInsets;

    return InkWell(
      onTap: () {},
      // splashColor: Theme.of(context).primaryColorDark,

      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Color.fromRGBO(242, 242, 242, 1),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: Colors.white70,
          ),
          height: slotInfoDetails.isRepeat
              ? screenHeight * 0.44
              : screenHeight * 0.365,
          width: screenWidth * 0.9,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.0125,
            vertical: screenWidth * 0.025,
          ),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.055,
                width: screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Colors.white,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor:
                              Color.fromRGBO(120, 158, 156, 1),
                        ),
                        child: Checkbox(
                          activeColor: Color.fromRGBO(120, 158, 156, 1),
                          checkColor: Colors.white,
                          value: slotInfoDetails.isClinic,
                          onChanged: (bool? value) {},
                        ),
                      ),
                    ),
                    Text(isLangEnglish ? 'Clinic' : "क्लिनिक"),
                    SizedBox(
                      width: screenWidth * 0.005,
                    ),
                    Material(
                      color: Colors.white,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor:
                              Color.fromRGBO(120, 158, 156, 1),
                        ),
                        child: Checkbox(
                          activeColor: Color.fromRGBO(120, 158, 156, 1),
                          checkColor: Colors.white,
                          value: slotInfoDetails.isHome,
                          onChanged: (bool? value) {},
                        ),
                      ),
                    ),
                    Text(isLangEnglish ? 'Home' : "घर"),
                    SizedBox(
                      width: screenWidth * 0.3,
                    ),
                    InkWell(
                      onTap: () {
                        _dateShowerInCalendar(
                          context,
                          slotInfoDetails.registeredDate,
                        );
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                  // vertical: screenHeight * 0.00625,
                ),
                height: screenHeight * 0.1125,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: screenHeight * 0.1,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: screenWidth * 0.325,
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 2,
                                  color: Color(0xffCDCDCD),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: screenWidth * 0.025,
                                horizontal: screenWidth * 0.05,
                              ),
                              child: Text(
                                "${slotInfoDetails.startTime.format(context)}",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.004,
                          ),
                          Container(
                            child: Text(isLangEnglish ? 'Start' : "शुरू"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffCDCDCD),
                          width: 1.5,
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.1,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              width: screenWidth * 0.325,
                              height: screenHeight * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 2,
                                  color: Color(0xffCDCDCD),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: screenWidth * 0.025,
                                horizontal: screenWidth * 0.05,
                              ),
                              child: Text(
                                "${slotInfoDetails.endTime.format(context)}",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.004,
                          ),
                          Container(
                            child: Text(isLangEnglish ? 'End' : "समाप्त"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.035,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: isLangEnglish
                              ? 'Appointment Fees: '
                              : "अपॉइंटमेंट फीस ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text:
                              '₹ ${slotInfoDetails.appointmentFeesPerPatient}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.4,
                      child: CheckboxListTile(
                        title: Text(isLangEnglish ? "Repeat" : "दोहराएं"),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Color.fromRGBO(120, 158, 156, 1),
                        checkColor: Colors.white,
                        value: slotInfoDetails.isRepeat,
                        onChanged: (bool? value) {},
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      child: slotInfoDetails.isRepeat
                          ? SizedBox(width: 0)
                          : Text(
                              "Exp: ${DateFormat.yMMMMd('en_US').format(slotInfoDetails.expiredDate)}",
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                              ),
                              textAlign: TextAlign.right,
                            ),
                    ),
                  ],
                ),
              ),
              slotInfoDetails.isRepeat
                  ? weekDayShowerWidget(
                      context,
                      slotInfoDetails.repeatWeekDaysList,
                    )
                  : SizedBox(
                      height: 0,
                    ),
              SizedBox(
                height: screenHeight * 0.005,
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => EditDoctorAppointmentSlotScreen(
                    //       docSlotInfo: slotInfoDetails,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.0125,
                      horizontal: screenWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      // color: Color(0xff42CCC3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Color(0xffCDCDCD),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        isLangEnglish ? "Edit" : "एडिट करें",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget weekDayShowerWidget(BuildContext context, List<bool> selectedDays) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var weekDaySelected = selectedDays;

    return Container(
      child: WeekdaySelector(
        color: Color.fromRGBO(120, 158, 156, 1),
        selectedColor: Color.fromRGBO(120, 158, 156, 1),
        elevation: 3,
        fillColor: Colors.white,
        selectedFillColor: Color.fromRGBO(220, 229, 228, 1),
        onChanged: (int day) {},
        values: weekDaySelected,
      ),
    );
  }

  Widget allWeakdaysWidget(
      BuildContext context, bool isRepeat, bool isClicked, bool isSaved) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    Color blacText = Color(0xff789E9C);
    Color blacweek = Color(0xffDCE5E4);
    Color blacbox = Color(0xff789E9C);
    Map<String, bool> RepeatedDays = {
      "M": false,
      "T": false,
      "W": false,
      "Th": false,
      "F": false,
      "S": false,
      "Su": false
    };
    List<String> days = ["M", "T", "W", "Th", "F", "S", "Su"];

    return isRepeat
        ? Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: screenHeight * 0.07,
                child: Wrap(
                  children: List.generate(
                    7,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isClicked) {
                              if (isSaved == false) {
                                RepeatedDays[days[index]] =
                                    !(RepeatedDays[days[index]]!);
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(8),
                          child: Text(
                            days[index],
                            style: TextStyle(
                              fontSize: 12.5,
                              color: isClicked ? Color(0xff42CCC3) : blacText,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffCDCDCD),
                            ),
                            borderRadius: BorderRadius.circular(100),
                            color: ((RepeatedDays[days[index]])!)
                                ? (isClicked
                                    ? Color(0xffdef8f5)
                                    : Color(0xffDCE5E4))
                                : Color(0xffffffff),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              isSaved == false
                  ? Container(
                      padding: EdgeInsets.only(
                        right: screenWidth * 0.025,
                        left: screenWidth * 0.025,
                      ),
                      child: Text(
                        "Please choose the time in which you are available in your Clinic.",
                        style: TextStyle(
                          color: Color(0xff6C757D),
                        ),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
            ],
          )
        : Container(
            height: 0,
          );
  }

  void TimePicker(BuildContext context, TimeOfDay timechosen) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

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
        timechosen = time;
      });
    }
  }

  void _dateShowerInCalendar(BuildContext context, DateTime givenTime) {
    showDatePicker(
      context: context,
      firstDate: givenTime,
      initialDate: givenTime,
      lastDate: givenTime,
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        } else {}
      },
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
