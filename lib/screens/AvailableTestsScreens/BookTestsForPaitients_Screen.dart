// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, sort_child_properties_last, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable, unused_element

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/Book_Test.dart';

class BookTestForPatientSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-book-test-for-patient-screen';

  @override
  State<BookTestForPatientSwasthyaMitra> createState() =>
      _BookTestForPatientSwasthyaMitraState();
}

class _BookTestForPatientSwasthyaMitraState
    extends State<BookTestForPatientSwasthyaMitra> {
  String dropdownvalue = 'Select Test';
  DateTime currDateTime = DateTime.now();
  DateTime selectedDateTime = DateTime.now();

  var items = [
    'Select Test',
    'Blood Test',
    'Complete Blood Count Test',
    'Liver Function Test',
    'Kidney Function Test',
    'Lipid Profile Test',
    'Blood Sugar Test',
    'Urine Test',
    'Cardiac Blood Test',
    'Height',
  ];

  List<Book_Tests> upcomming_test_list = [
    //   Book_Tests("Khushi Sharma 1", DateTime.now(), "assets/images/DoctorBac.png",
    //       "Blood Test", true),
    //   Book_Tests("Khushi Sharma 2", DateTime.now(), "assets/images/DoctorBac.png",
    //       "Blood Test", true),
    //   Book_Tests("Khushi Sharma 3", DateTime.now(), "assets/images/DoctorBac.png",
    //       "Blood Test", true),
    //   Book_Tests("Khushi Sharma 4", DateTime.now(), "assets/images/DoctorBac.png",
    //       "Blood Test", true),
    //   Book_Tests("Khushi Sharma 5", DateTime.now(), "assets/images/DoctorBac.png",
    //       "Blood Test", true),
    //   Book_Tests("Khushi Sharma 6", DateTime.now(), "assets/images/DoctorBac.png",
    //       "Blood Test", true),
    //   Book_Tests("Khushi Sharma 7", DateTime.now(), "assets/images/DoctorBac.png",
    //       "Blood Test", true),
  ];

  DateTime kToday = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Book_Tests>> all_Events = <DateTime, List<Book_Tests>>{};
  List<Book_Tests>? empty_list = [];
  ValueNotifier<List<Book_Tests>> _selectedEvents =
      ValueNotifier<List<Book_Tests>>([]);

  @override
  void initState() {
    super.initState();
    for (var v in upcomming_test_list) {
      DateTime? key = DateTime(v.Date_Time?.toUtc().year as int,
          v.Date_Time?.toUtc().month as int, v.Date_Time?.toUtc().day as int);
      if (all_Events.containsKey(key)) {
        all_Events[key]?.add(v);
      } else {
        List<Book_Tests>? temp = [v];
        all_Events[key] = temp;
      }
    }
    _selectedDay = DateTime(_focusedDay.toUtc().year, _focusedDay.toUtc().month,
        _focusedDay.toUtc().day);
    ;
    _selectedEvents =
        ValueNotifier(all_Events[_selectedDay!] ?? (<Book_Tests>[]));
  }

  List<Book_Tests> _getEventsForDay(DateTime day) {
    DateTime key =
        DateTime(day.toUtc().year, day.toUtc().month, day.toUtc().day);
    return all_Events[key] ?? [];
  }

  TimeOfDay _time = TimeOfDay.now();

  late String name;
  late String phoneno;

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
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
      backgroundColor: Color(0xffF5F5F5),
      //color: Color(0xff42CCC3)
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_circle_left,
              color: Color(0xff42ccc3),
              size: 35 * (0.035 / 15) * width,
            )),
        backgroundColor: Colors.white,
        title: Text(
          'Book Test for Patient',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 24 * (0.035 / 15) * width,
          ),
          textAlign: TextAlign.left,
        ),
        elevation: 0.0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              child: Container(
                width: width,
                padding: EdgeInsets.only(
                    top: 0.03 * height,
                    left: 0.02 * height,
                    right: 0.1 * height,
                    bottom: 0.01 * height),
                child: Text(
                  'Name of Patient',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20 * (0.035 / 15) * width,
                  ),
                ),
              ),
            ),
            Align(
              child: Container(
                padding: EdgeInsets.only(
                  top: 0.01 * height,
                  left: 0.02 * height,
                  right: 0.03 * height,
                ),
                height: 50 * 0.00135869565 * height,
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Patient Name',
                    hintText: 'Type Patient Name',
                  ),
                  onChanged: (text) {
                    setState(() {
                      name = text;
                    });
                  },
                ),
              ),
            ),
            Align(
              child: Container(
                width: width,
                padding: EdgeInsets.only(
                  top: 0.03 * height,
                  left: 0.02 * height,
                  right: 0.1 * height,
                  bottom: 0.01 * height,
                ),
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20 * (0.035 / 15) * width,
                  ),
                ),
              ),
            ),
            Align(
              child: Container(
                  padding: EdgeInsets.only(
                    top: 0.01 * height,
                    left: 0.02 * height,
                    right: 0.03 * height,
                  ),
                  height: 50 * 0.00135869565 * height,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      hintText: 'Type Phone Number',
                    ),
                    onChanged: (text) {
                      setState(() {
                        phoneno = text;
                      });
                    },
                  )),
            ),
            Align(
              child: Container(
                width: width,
                padding: EdgeInsets.only(
                  top: 0.03 * height,
                  left: 0.02 * height,
                  right: 0.1 * height,
                ),
                child: Text(
                  "Name of Test ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20 * (0.035 / 15) * width,
                  ),
                ),
              ),
            ),
            Align(
              child: Container(
                // color: Colors.white,
                width: width,
                height: 75 * 0.00135869565 * height,
                padding: EdgeInsets.only(
                  top: 0.01 * height,
                  left: 0.02 * height,
                  right: 0.03 * height,
                ),

                child: DropdownButtonFormField(
                  // style:
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: 'Test',
                    hintText: 'Test',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.w500,
                      fontSize: 17 * (0.035 / 15) * width,
                    ),
                  ),
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  value: dropdownvalue,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.tealAccent,
                  ),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.w500,
                          fontSize: 17 * (0.035 / 15) * width,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.0125,
                  vertical: screenWidth * 0.0125,
                ),
                width: screenWidth * 0.95,
                alignment: Alignment.center,
                child: Text(
                  "Select Date and Time according to availability of slot",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.0325,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 0.0135869565 * height),
            TableCalenderWidget(
              context,
              currDateTime,
              selectedDateTime,
            ),
            SizedBox(height: 0.0135 * height),

            Align(
              child: Container(
                width: screenWidth * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      child: Container(
                        // width: width * 0.95,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.0125,
                          vertical: screenWidth * 0.0125,
                        ),
                        child: Text(
                          "Select Time for Test ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20 * (0.035 / 15) * width,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _selectTime();
                      },
                      child: Align(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.0065,
                          ),
                          height: screenHeight * 0.055,
                          width: screenHeight * 0.035,
                          decoration: BoxDecoration(
                              // color: Color.fromRGBO(66, 204, 195, 1),
                              ),
                          child: Icon(
                            Icons.watch_later_rounded,
                            color: Color.fromRGBO(66, 204, 195, 1),
                            size: 30,
                          ),
                          // Image(
                          //   fit: BoxFit.fill,
                          //   image: AssetImage(
                          //     "assets/images/Calendar.png",
                          //   ),
                          //   color: Color.fromRGBO(108, 117, 125, 1),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              child: Container(
                width: width * 0.95,
                height: 50 * 0.00135869565 * height,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.0125,
                  vertical: screenWidth * 0.0125,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.83),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  // color: Color(0xffFFC857),
                  color: Colors.white,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  onPressed: () {
                    _selectTime();
                  },
                  child: Text(
                    ' ${_time.format(context)}',
                    style: TextStyle(
                      fontSize: 15 * (0.035 / 15) * width,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            //Space
            SizedBox(height: 20.0 * 0.00135869565 * height),
            _selectedEvents.value.isNotEmpty
                ? Container(
                    padding: EdgeInsets.only(
                      left: 2 * 0.00277777778 * width,
                    ),
                    alignment: Alignment.topLeft,
                    width: 0.9 * width,
                    child: Text(
                      "Tests Scheduled for ${DateFormat('dd MMMM').format(_selectedDay!)}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto",
                        fontSize: 22 * (0.035 / 15) * width,
                      ),
                    ),
                  )
                : Container(),

            SizedBox(height: 20.0 * 0.00135869565 * height),
            // Events
            // Container(
            //   height: 700 * 0.00135869565 * height,
            //   child: ValueListenableBuilder<List<Book_Tests>>(
            //     valueListenable: _selectedEvents,
            //     builder: (context, value, _) {
            //       return ListView.builder(
            //         itemCount: value.length,
            //         physics: NeverScrollableScrollPhysics(),
            //         shrinkWrap: true,
            //         itemBuilder: (context, index) {
            //           return Container(
            //               margin: EdgeInsets.symmetric(
            //                 horizontal: 12.0 * 0.0028 * width,
            //                 vertical: 7.0 * 0.00135 * height,
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Row(
            //                     children: [
            //                       Text(
            //                         DateFormat('hh:mm a')
            //                             .format(value[index].Date_Time!),
            //                         textAlign: TextAlign.left,
            //                         style: TextStyle(
            //                           fontWeight: FontWeight.w500,
            //                           fontFamily: "Poppins",
            //                           color: Color(0xff7f8084),
            //                           fontSize: 20 * (0.035 / 15) * width,
            //                         ),
            //                       ),
            //                       SizedBox(
            //                         width: 5 * 0.00277777778 * width,
            //                       ),
            //                       Icon(
            //                         Icons.circle_outlined,
            //                         color: Color(0xff42cdc3),
            //                         size: 19 * (0.035 / 15) * width,
            //                       ),
            //                     ],
            //                   ),
            //                   SizedBox(height: 5 * 0.00135869565 * height),
            //                   Row(
            //                     children: [
            //                       Container(
            //                         margin: EdgeInsets.only(
            //                           left: 10 * 0.00277777778 * width,
            //                           right: 10 * 0.00277777778 * width,
            //                         ),
            //                         height: 65 * 0.00135869565 * height,
            //                         decoration: BoxDecoration(
            //                           border: Border.all(
            //                             color: Color(0xff7f8084),
            //                           ),
            //                           borderRadius: BorderRadius.circular(12.0),
            //                         ),
            //                       ),
            //                       SizedBox(
            //                         width: 0.8 * width,
            //                         child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Column(
            //                               crossAxisAlignment:
            //                                   CrossAxisAlignment.start,
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.spaceBetween,
            //                               children: [
            //                                 Text(
            //                                   value[index].type!.toString(),
            //                                   textAlign: TextAlign.left,
            //                                   style: TextStyle(
            //                                     fontWeight: FontWeight.w500,
            //                                     fontFamily: "Roboto",
            //                                     fontSize:
            //                                         18 * (0.035 / 15) * width,
            //                                   ),
            //                                 ),
            //                                 SizedBox(
            //                                     height:
            //                                         3 * 0.00135869565 * height),
            //                                 Text(
            //                                   "   ${value[index].name!}",
            //                                   textAlign: TextAlign.left,
            //                                   style: TextStyle(
            //                                       fontWeight: FontWeight.w500,
            //                                       fontFamily: "Roboto",
            //                                       fontSize:
            //                                           18 * (0.035 / 15) * width,
            //                                       color: Color(0xff7f8084)),
            //                                 ),
            //                                 SizedBox(
            //                                     height:
            //                                         3 * 0.00135869565 * height),
            //                                 Text(
            //                                   "   ${value[index].name!}",
            //                                   textAlign: TextAlign.left,
            //                                   style: TextStyle(
            //                                       fontWeight: FontWeight.w500,
            //                                       fontFamily: "Roboto",
            //                                       fontSize:
            //                                           18 * (0.035 / 15) * width,
            //                                       color: Color(0xff7f8084)),
            //                                 ),
            //                                 SizedBox(
            //                                     height:
            //                                         3 * 0.00135869565 * height),
            //                               ],
            //                             ),
            //                             Image.asset("assets/images/Search.png"),
            //                           ],
            //                         ),
            //                       )
            //                     ],
            //                   )
            //                 ],
            //               ));
            //         },
            //       );
            //     },
            //   ),
            // ),
            // SizedBox(height: 30.0 * 0.00135869565 * height),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Book_Tests new_test = Book_Tests(
      //         name,
      //         DateTime(
      //           _selectedDay?.year as int,
      //           _selectedDay?.month as int,
      //           _selectedDay?.day as int,
      //           _time.hour,
      //           _time.minute,
      //         ),
      //         "assets/images/Doctor.jpg",
      //         dropdownvalue,
      //         true);
      //     upcomming_test_list.add(new_test);

      //     //insert into Backend

      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) => SimpleDialog(
      //         backgroundColor: Colors.transparent,
      //         shape: RoundedRectangleBorder(
      //           side: BorderSide.none,
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(10),
      //           ),
      //         ),
      //         alignment: Alignment.bottomCenter,
      //         children: [
      //           Container(
      //             width: 0.8 * width,
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               color: Colors.white,
      //             ),
      //             child: Column(
      //               children: [
      //                 Container(
      //                   // height: 100* 0.00135869565 * height,
      //                   // width: 148*0.00277777778 * width,
      //                   margin:
      //                       EdgeInsets.only(top: 20 * 0.00135869565 * height),
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10),
      //                     color: Colors.green,
      //                   ),
      //                   child: Image.asset(
      //                     "assets/images/Doctor.jpg",
      //                     fit: BoxFit.fitWidth,
      //                     width: 200 * 0.00277777778 * width,
      //                   ),
      //                 ),
      //                 SizedBox(height: 20.0 * 0.00135869565 * height),
      //                 Container(
      //                   alignment: Alignment.center,
      //                   width: 0.6 * width,
      //                   child: Text(
      //                     'Test booking confirmed for ${new_test.name}',
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w500,
      //                       fontSize: 20 * (0.035 / 15) * width,
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(height: 20.0 * 0.00135869565 * height),
      //                 Container(
      //                   alignment: Alignment.center,
      //                   width: 0.6 * width,
      //                   child: Text(
      //                     'Test is scheduled for ${DateFormat('dd MMM, hh:mm a').format(new_test.Date_Time!)}',
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w400,
      //                       fontSize: 15 * (0.035 / 15) * width,
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(height: 20.0 * 0.00135869565 * height),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             padding: EdgeInsets.only(top: 20.0 * 0.00135869565 * height),
      //             width: width * 0.8,
      //             // alignment: Alignment.center,
      //             // height: 100* 0.00135869565 * height,
      //             child: ElevatedButton(
      //               style: ElevatedButton.styleFrom(
      //                 primary: Colors.white,
      //               ),
      //               onPressed: () {
      //                 //Done Pressed
      //               },
      //               child: Container(
      //                 width: width * 0.8,
      //                 alignment: Alignment.center,
      //                 child: Text(
      //                   'Done',
      //                   style: TextStyle(
      //                       color: Color(0xff42ccc3),
      //                       fontWeight: FontWeight.w500,
      //                       fontSize: 20 * (0.035 / 15) * width),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      //   child: Icon(Icons.check),
      //   backgroundColor: Color(0xff42ccc3),
      // ),
    );
  }

  void _onDaySelected(
    DateTime day,
    DateTime focusedDay,
    DateTime selectedDateTime,
  ) {
    setState(() {
      selectedDateTime = focusedDay;
    });
  }

  Widget TableCalenderWidget(
    BuildContext context,
    DateTime currDateTime,
    DateTime selectedDateTime,
  ) {
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

    return Align(
      child: Container(
        child: TableCalendar(
          rowHeight: 50,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          availableGestures: AvailableGestures.all,
          focusedDay: selectedDateTime,
          firstDay: currDateTime,
          lastDay: currDateTime.add(
            Duration(days: 14),
          ),
        ),
        // TableCalendar<Book_Tests>(
        //   firstDay: currDateTime,
        //   lastDay: currDateTime.add(Duration(days: 14)),
        //   focusedDay: currDateTime,
        //   rowHeight: 50,
        //   selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        //   calendarFormat: CalendarFormat.month,
        //   eventLoader: _getEventsForDay,
        //   startingDayOfWeek: StartingDayOfWeek.sunday,
        //   availableCalendarFormats: {CalendarFormat.month: 'Month'},
        //   headerStyle: HeaderStyle(
        //       titleCentered: true,
        //       formatButtonVisible: false,
        //       titleTextStyle: TextStyle(
        //         fontFamily: "Roboto",
        //         fontSize: 25 * (0.035 / 15) * width,
        //         fontWeight: FontWeight.w500,
        //       )),
        //   daysOfWeekStyle: DaysOfWeekStyle(
        //     weekdayStyle: TextStyle(
        //       fontFamily: "Roboto",
        //       fontSize: 20 * (0.035 / 15) * width,
        //       fontWeight: FontWeight.w500,
        //     ),
        //     weekendStyle: TextStyle(
        //       fontFamily: "Roboto",
        //       fontSize: 20 * (0.035 / 15) * width,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        //   calendarStyle: CalendarStyle(
        //     outsideDaysVisible: false,
        //     markersMaxCount: 1,
        //     markersAnchor: -0.3,
        //     todayDecoration: BoxDecoration(
        //       color: Color(0x8142CCC3),
        //       shape: BoxShape.circle,
        //     ),
        //     markerDecoration: BoxDecoration(
        //       color: Color(0xff42ccc3),
        //       shape: BoxShape.circle,
        //     ),
        //     selectedDecoration: BoxDecoration(
        //       color: Color(0xFF42CCC3),
        //       shape: BoxShape.circle,
        //     ),
        //   ),
        //   onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        //     if (!isSameDay(_selectedDay, selectedDay)) {
        //       setState(() {
        //         _selectedDay = selectedDay;
        //         _focusedDay = focusedDay;
        //       });
        //       _selectedEvents.value = _getEventsForDay(selectedDay);
        //     }
        //   },
        // ),
      ),
    );
  }
}
