// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/constants.dart';

class DoctorSlot extends StatefulWidget {
  const DoctorSlot({Key? key}) : super(key: key);

  @override
  _DoctorSlotState createState() => _DoctorSlotState();
}

class _DoctorSlotState extends State<DoctorSlot> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Color _color1 = AppColors.AppmainColor;
  var _color = Color(0xffEBEBEB);
  String appointnmentType = "Clinic Appointment";

  bool isselected = true;
  int selectedType = 1;
  int dateno = 0;

  List types = ["Clinic Appointment", "Video Consultation"];

  List noofslot = [5, 6, 5];
  List datetext = ["Today, 5 Jul", "Tomorrow, 6 Jul", "Wed, 7 Jul"];
  List slottime = ["06:45", "07:00", "07:15", "07:30", "07:45"];

  int selecteddateindex = 0;
  int slotindex = 0;

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;
    return Scaffold(
      body: Container(
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    height: _height * 0.25,
                    color: const Color(0xff42CCC3),
                  ),
                ),
                Positioned(
                  top: 0.03836 * _height,
                  width: _width,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 0.05555 * _width, right: 0.05555 * _width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 0.08055 * _width / 2,
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.AppmainColor,
                          ),
                        ),
                        const Icon(
                          Icons.library_add_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 0.06944 * _width,
                    bottom: 0.02173 * _height,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.011111 * _width, color: Colors.white),
                            borderRadius: BorderRadius.circular(45),
                          ),
                          child: const CircleAvatar(
                            foregroundImage:
                                AssetImage("assets/images/Doctor.jpg"),
                            radius: 40,
                          ),
                        ),
                        SizedBox(
                          width: 0.02777 * _width,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                child: Text(
                                  "Dr. Ram Singh",
                                )),
                            SizedBox(
                              height: 0.015345 * _height,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 0.013888 * _width,
                                      top: 0.006393 * _height,
                                      bottom: 0.006393 * _height,
                                      right: 0.013888 * _width),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Center(
                                      child: DefaultTextStyle(
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.AppmainColor),
                                          child: Text(
                                            "Diabetologist",
                                          ))),
                                ),
                                SizedBox(
                                  width: 0.0555555 * _width,
                                ),
                                const DefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      "4.2/5 Rating",
                                    )),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 0.0227877 * _height,
            ),
            Container(
              margin: EdgeInsets.only(left: 0.0555555 * _width),
              height: 0.102301 * _height,
              child: Wrap(
                children: List.generate(3, (index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          dateno = index;
                          slottime = [
                            "80:00",
                            "07:00",
                            "00:00",
                            "12:23",
                            "12:89"
                          ];
                        });
                      },
                      child: TabItem(
                        text: datetext[index],
                        color: index == dateno
                            ? AppColors.AppmainColor
                            : const Color(0xffEBEBEB),
                        noofslot: noofslot[index],
                      ));
                }),
              ),
            ),
            SizedBox(
              height: 0.0005754 * _height,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 0.055555 * _width, right: 0.055555 * _width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      datetext[dateno],
                      style: const TextStyle(
                          color: Color(0xff2c2c2c),
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 0.002787 * _height,
                  ),
                  const Divider(
                    thickness: 2,
                    color: Color(0xffD4D4D4),
                  ),
                  SizedBox(
                    height: 0.006393 * _height,
                  ),
                  Text(
                    "Total ${noofslot[dateno]}",
                    style: const TextStyle(
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0.055555 * _width),
                    height: 0.127877 * _height,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                slotindex = index;
                              });
                            },
                            child: TabbarItems(
                                color: slotindex == index
                                    ? AppColors.AppmainColor
                                    : Color(0xffEBEBEB),
                                text: slottime[index]));
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.06836 * _height,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 0.044444 * _width, right: 0.044444 * _width),
              child: Column(
                children: [
                  SizedBox(
                    height: 0.025575 * _height,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0.055555 * _width, right: 0.055555 * _width),
                    child: const Text(
                      "Choose a method of appointment or consultation",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff2c2c2c),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 0.0125575 * _height,
                  ),
                  Container(
                      height: 0.102301 * _height,
                      child: Wrap(
                        children: List.generate(2, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedType = index;
                                if (selectedType == 1) {
                                  appointnmentType = types[1];
                                } else {
                                  appointnmentType = types[0];
                                }
                              });
                            },
                            child: appointments(
                              color: index == selectedType
                                  ? AppColors.AppmainColor
                                  : const Color(0xffEBEBEB),
                              text: types[index],
                            ),
                          );
                        }),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0.055555 * _width,
                        top: 0.0191815 * _height,
                        right: 0.055555 * _width),
                    child: const DefaultTextStyle(
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff727272),
                            fontWeight: FontWeight.w500),
                        child: Text(
                          "Bill Details:",
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0.055555 * _width,
                        top: 0.0127877 * _height,
                        right: 0.055555 * _width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff727272),
                                fontWeight: FontWeight.w400),
                            child: Text(
                              "Consultaion Fee",
                            )),
                        DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff727272),
                                fontWeight: FontWeight.w400),
                            child: Text(
                              "₹ 600.00",
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0.055555 * _width, right: 0.055555 * _width),
                    child: const Divider(
                      color: Color(0xffD4D4D4),
                      thickness: 2,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 0.055555 * _width,
                        top: 0.006393 * _height,
                        right: 0.055555 * _width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff2c2c2c),
                                fontWeight: FontWeight.w500),
                            child: Text(
                              "Total Payable",
                            )),
                        DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff2c2c2c),
                                fontWeight: FontWeight.w500),
                            child: Text(
                              "₹ 600.00",
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.AppmainColor,
        onPressed: () {},
        child: const Icon(
          Icons.arrow_forward,
          size: 28,
        ),
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
            right: 0.027777777 * _width),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0.01666 * _width),
          border: Border.all(color: color, width: 0.005555 * _width),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Color(0xff2c2c2c),
              fontWeight: FontWeight.w400,
              fontSize: 15),
        ));
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
            bottom: 0.006393 * _height),
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
              style: const TextStyle(
                  color: AppColors.AppmainColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
            const Text(
              " PM",
              style: TextStyle(
                  color: AppColors.AppmainColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
          ],
        ));
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
            style: const TextStyle(
                color: Color(0xff2c2c2c),
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(
            "$noofslot slots available",
            style: const TextStyle(
                color: AppColors.AppmainColor,
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
        ],
      ),
    );
  }
}
