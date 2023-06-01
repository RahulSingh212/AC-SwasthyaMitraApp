// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/paientHealthAndWellNess_details.dart';
import '../../providers/patientUser_details.dart';
import 'Blood_Pressure.dart';
import 'BMI_Page.dart';
import 'Blood_Sugar_level.dart';
import 'Body_Temperature.dart';
import 'Calorie_Intake.dart';
import 'Haemoglobin.dart';
import 'Oxygen.dart';
import 'Steps_Distance.dart';

class WellNess_Page extends StatefulWidget {
  const WellNess_Page({Key? key}) : super(key: key);

  @override
  State<WellNess_Page> createState() => _WellNess_PageState();
}

class _WellNess_PageState extends State<WellNess_Page> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
        .fetchPreviousBloodPressureList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
    Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
        .fetchPreviousStepsDistanceList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
    Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
        .fetchPreviousBloodSugarLevelList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
    Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
        .fetchPreviousOxygenLevelList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
    Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
        .fetchPreviousCalorieIntakeLevelList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
    Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
        .fetchPreviousHaemoglobinLevelList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
    Provider.of<PatientHealthAndWellNessDetails>(context, listen: false)
        .fetchPreviousTemperatureLevelList(
      Provider.of<PatientUserDetails>(context, listen: false)
          .getIndividualObjectDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) -
        _padding.top -
        _padding.bottom -
        kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: ScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
              ),
              width: screenWidth * 0.95,
              child: Text(
                isLangEnglish ? "Wellness" : "कल्याण",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: _width * 0.07,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                  // height: ,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.015 * _height,
          ),
          Align(
            child: Container(
              width: _width * 0.95,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.0225,
              ),
              child: Text(
                isLangEnglish
                    ? "A state of physical, mental and social well-being in which disease and infirmity are absent"
                    : "शारीरिक, मानसिक और सामाजिक कल्याण की एक अवस्था जिसमें रोग और दुर्बलता अनुपस्थित होती है",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: _width * .035,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff929292),
                  // height: ,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0.015 * _height,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                child: Blood_Pressure(
                  width: _width,
                  height: _height,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                child: Steps_Distance(
                  width: _width,
                  height: _height,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                child: Blood_Sugar(
                  width: _width,
                  height: _height,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                child: Oxygen(
                  width: _width,
                  height: _height,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                child: Calorie(
                  width: _width,
                  height: _height,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                child: BMI(
                  width: _width,
                  height: _height,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                child: Haemoglobin(
                  width: _width,
                  height: _height,
                ),
              ),
            ),
          ),
          Align(
            child: Container(
              width: screenWidth * 0.95,
              margin: EdgeInsets.symmetric(
                vertical: screenHeight * 0.005,
              ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color.fromRGBO(242, 242, 242, 1),
                  ),
                ),
                child: Body_Temperature(
                  width: _width,
                  height: _height,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
        ],
      ),
    );
  }
}
