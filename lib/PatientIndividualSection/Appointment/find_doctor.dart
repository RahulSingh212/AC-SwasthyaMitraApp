import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Find_doctor extends StatefulWidget {
  const Find_doctor({Key? key}) : super(key: key);

  @override
  State<Find_doctor> createState() => _Find_doctorState();
}

class _Find_doctorState extends State<Find_doctor> {
  bool ispressed = false;
  List<String> departments = [
    'Neuro-interventional Radiology',
    'Psychiatry',
    'Cosmetology',
    'Neurology',
    'Endocrinology',
    'Neuro Surgery',
    'General Medicine',
    'Ophthalmology',
    'Cardiology',
    'Nephrology',
    'Paediatrics',
    'ENT',
    'Oncology',
    'Gastroenterology',
    'Gynaecology',
    'Urology',
  ];
  String dept_selected = " ";
  List<String> doctors = [
    'Neuro-interventional Radiology',
    'Psychiatry',
    'Cosmetology',
    'Neurology',
    'Endocrinology',
    'Neuro Surgery',
    'General Medicine',
    'Ophthalmology',
    'Cardiology',
    'Nephrology',
    'Paediatrics',
    'ENT',
    'Oncology',
    'Gastroenterology',
    'Gynaecology',
    'Urology',
  ];
  String doc_selected = " ";

  List<String> recent_search = [
    'Neuro-interventional Radiology',
    'Psychiatry',
    'Cosmetology',
    'Neurology',
    'Endocrinology',
    'Neuro Surgery',
  ];

  TextEditingController _search = TextEditingController();
  _display_dept_Dialog(BuildContext context) async {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    dept_selected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          print(MediaQuery.of(context).size.width);
          return SimpleDialog(
              title: const Text('Select the Department'),
              titleTextStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Color(0xff2c2c2c),
              ),
              titlePadding: EdgeInsets.only(
                  left: 0.05833333 * _width, top: 2 * 0.011508951 * _height),
              children: [
                Container(
                    width: 0.79444444 * _width,
                    height: 0.80434782 * _height,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: departments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          dense: true,
                          title: Text(
                            departments[index],
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff2c2c2c),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              dept_selected = departments[index];
                            });
                            print("serchpressed ${doctors[index]}");
                          },
                        );
                      },
                    )),
              ]);
        });
  }

  _display_doc_Dialog(BuildContext context) async {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    dept_selected = await showDialog(
        context: context,
        builder: (BuildContext context) {
          print(MediaQuery.of(context).size.width);
          return SimpleDialog(
              title: const Text('Select the Doctor Type'),
              titleTextStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Color(0xff2c2c2c),
              ),
              titlePadding: EdgeInsets.only(
                  left: 0.05833333 * _width, top: 2 * 0.011508951 * _height),
              children: [
                Container(
                    width: 0.79444444 * _width,
                    height: 0.80434782 * _height,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: doctors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          dense: true,
                          title: Text(
                            doctors[index],
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff2c2c2c),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              doc_selected = doctors[index];
                            });
                            print("serchpressed ${doctors[index]}");
                          },
                        );
                      },
                    )),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        MediaQuery.of(context).size.height - _padding.top - _padding.bottom;
    
    return Scaffold(
      backgroundColor: const Color(0xFFfbfcff),
      body: Container(
        padding: EdgeInsets.only(top: _padding.top),
        child: Stack(
          children: [
            Positioned(
              width: _width,
              top: 0.718670 * _height,
              child: Container(
                alignment: Alignment.center,
                child:
                    SvgPicture.asset('assets/images/Appointemnt_pg_vector.svg'),
                // Image.asset('assets/images/Appointemnt_pg_vector.png'),
              ),
            ),
            Positioned(
              left: 0.05555555 * _width,
              top: 0.025575 * _height,
              child: const Text(
                "Appointment with Doctor",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                ),
              ),
            ),
            Positioned(
              left: 0.05555555 * _width,
              top: 0.08695652 * _height,
              width: 0.888888 * _width,
              height: 0.06393861 * _height,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xffebebeb)),
                        borderRadius: BorderRadius.circular(11)),
                    hintStyle: const TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      color: Color(0xff6c757d),
                    ),
                    suffixIcon: IconButton(
                      icon: Image.asset('assets/images/Search.png'),
                      onPressed: () {
                        setState(() {
                          recent_search.insert(0, _search.text);
                        });
                        print("serchpressed $ispressed");
                      },
                    )),
              ),
            ),
            Positioned(
                left: 0.05555555 * _width,
                top: 0.162404 * _height,
                width: 0.4111111 * _width,
                height: 0.0447570 * _height,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffebebeb),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      _display_dept_Dialog(context);
                    },
                    child: const Text(
                      "Department",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff6c757d),
                      ),
                    ),
                  ),
                )),
            Positioned(
                left: 0.533333333 * _width,
                top: 0.162404 * _height,
                width: 0.4111111 * _width,
                height: 0.0447570 * _height,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffebebeb),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      _display_doc_Dialog(context);
                    },
                    child: const Text(
                      "Doctor type",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff6c757d),
                      ),
                    ),
                  ),
                )),
            Positioned(
              left: 0.62222 * _width,
              top: 0.23785 * _height,
              child: const Text(
                "Recent Search",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  color: Color(0xffc4c4c4),
                ),
              ),
            ),
            Positioned(
                left: 0.0694444 * _width,
                top: 0.273657 * _height,
                child: Container(
                  padding: EdgeInsets.zero,
                  width: _width,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount:
                        recent_search.length >= 5 ? 5 : recent_search.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Transform.rotate(
                          angle: 45 * pi / 180,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Color(0xffc4c4c4),
                            ),
                            onPressed: () {
                              setState(() {
                                print("${recent_search[index]}removed");
                                recent_search.remove(recent_search[index]);
                              });
                            },
                          ),
                        ),
                        title: Text(
                          recent_search[index],
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            color: Color(0xffc4c4c4),
                          ),
                        ),
                      );
                    },
                  ),
                ))
            /*To check selected item
              Positioned(
                  left: 0.05555555 * _width,
                  top: 0.21355 * _height,
                  width: 0.4111111 * _width,
                  height: 0.0447570 * _height,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffebebeb),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        _display_dept_Dialog(context);
                      },
                      child: Text(
                        dept_selected,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff6c757d),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                  left: 0.533333333 * _width,
                  top: 0.21355 * _height,
                  width: 0.4111111 * _width,
                  height: 0.0447570 * _height,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffebebeb),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        doc_selected,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color(0xff6c757d),
                        ),
                      ),
                    ),
                  )
              ),

               */
          ],
        ),
      ),
    );
  }
}
