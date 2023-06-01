// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, avoid_unnecessary_containers, unused_import, unused_local_variable, unused_element, must_be_immutable

import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/screens/PatientPrescriptionScreens/PatientGivenPrescriptionScreen.dart';

import '../../PatientIndividualSection/providers/patientUser_details.dart';
import '../../PatientIndividualSection/screens/Tabs_Screen.dart';
import '../../models/patient_Info.dart';
import '../../providers/SM_FindPatients_Details.dart';
import '../../providers/SM_User_Details.dart';

class PatientFilteredScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-filtered-patient-screen';

  TextEditingController _searchedText;
  String _screenName;

  PatientFilteredScreenSwasthyaMitra(this._searchedText, this._screenName);

  @override
  State<PatientFilteredScreenSwasthyaMitra> createState() =>
      _PatientFilteredScreenSwasthyaMitraState();
}

class _PatientFilteredScreenSwasthyaMitraState
    extends State<PatientFilteredScreenSwasthyaMitra> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
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

    var swasthyaMitraPatientUserInfoDetails =
        Provider.of<SwasthyaMitraFindPatientDetails>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        title: Text(
          isLangEnglish ? "Searched Resluts" : "खोजे गए परिणाम",
        ),
        centerTitle: true,
      ),
      body: swasthyaMitraPatientUserInfoDetails
              .itemsFilteredPatientDetails.isEmpty
          ? Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.025,
                ),
                alignment: Alignment.center,
                height: screenHeight * 0.5,
                width: screenWidth * 0.85,
                margin: EdgeInsets.only(
                  top: screenHeight * 0.0125,
                ),
                child: Text(
                  isLangEnglish
                      ? "No results found for your search : \n' ${widget._searchedText.text} ' "
                      : "आपकी खोज के लिए कोई परिणाम नहीं मिला : \n' ${widget._searchedText.text} ' ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: minDimension * 0.075,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(66, 204, 195, 1),
                  ),
                ),
              ),
            )
          : Container(
              alignment: Alignment.center,
              // height: maxDimension * 0.85,
              child: ListView.builder(
                itemCount: swasthyaMitraPatientUserInfoDetails
                        .itemsFilteredPatientDetails.length +
                    1,
                itemBuilder: (ctx, index) {
                  if (index <
                      swasthyaMitraPatientUserInfoDetails
                          .itemsFilteredPatientDetails.length) {
                    return patientDetailInfoWidget(
                      context,
                      swasthyaMitraPatientUserInfoDetails
                          .itemsFilteredPatientDetails[index],
                    );
                  } else {
                    return SizedBox(
                      height: screenHeight * 0.1,
                    );
                  }
                },
              ),
            ),
    );
  }

  Widget patientDetailInfoWidget(
    BuildContext context,
    PatientDetailsInformation patientDetails,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenWidth, screenHeight);
    var maxDimension = max(screenWidth, screenHeight);

    return InkWell(
      onTap: () {
        if (widget._screenName == "PatientScreen") {
          if (patientDetails.patient_ProfilePermission) {
            String titleText = isLangEnglish ? "User Details" : "रोगी का विवरण";
            String contextText = isLangEnglish
                ? "Are you sure to view the details of the patients?"
                : "क्या आप निश्चित रूप से रोगी का विवरण देखना चाहते हैं?";
            _checkForSettingUpUserProfile(
              context,
              titleText,
              contextText,
              patientDetails,
            );
            print(patientDetails.patient_FullName);
          } else {
            String titleText =
                isLangEnglish ? "Not Authorized" : "अधिकृत नहीं हैं";
            String contextText = isLangEnglish
                ? "Patient has restricted the authorization access!"
                : "रोगी ने प्राधिकरण पहुंच प्रतिबंधित कर दी है!";
            _checkForError(context, titleText, contextText);
          }
        } else {
          Navigator.pushNamed(
            context,
            PatientGivenPresciptionScreenSwasthyaMitra.routeName,
          );
        }
      },
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.5),
          // side: BorderSide(
          //   width: 5,
          //   color: Colors.green,
          // ),
        ),
        child: Container(
          height: maxDimension * 0.125,
          padding: EdgeInsets.symmetric(
            horizontal: minDimension * 0.0125,
            vertical: maxDimension * 0.00625,
          ),
          margin: EdgeInsets.only(
            bottom: maxDimension * 0.005,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            // color: patientDetails.patient_ProfilePermission ? Colors.white70 : ui.Color.fromARGB(255, 215, 193, 191),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: minDimension * 0.245,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 233, 218, 218),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: patientDetails.patient_ProfilePicUrl == ""
                        ? Image.asset(
                            'assets/images/healthy.png',
                            fit: BoxFit.fill,
                            width: minDimension * 0.25,
                          )
                        : Image.network(
                            patientDetails.patient_ProfilePicUrl,
                            fit: BoxFit.fill,
                            width: minDimension * 0.25,
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: minDimension * 0.01,
              ),
              Container(
                width: screenWidth * 0.65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Container(
                        child: Text(
                          "${patientDetails.patient_FullName}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: minDimension * 0.05,
                            color: Colors.black,
                          ),
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "${patientDetails.patient_EmailId == "" ? patientDetails.patient_PhoneNumber : patientDetails.patient_EmailId}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: minDimension * 0.04,
                          color: Colors.black,
                        ),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Container(
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Authorization: ',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                              TextSpan(
                                text: patientDetails.patient_ProfilePermission
                                    ? isLangEnglish
                                        ? "Access Allowed"
                                        : "अनुमति दिया"
                                    : isLangEnglish
                                        ? "Access Blocked"
                                        : "अनुमति अवरुद्ध",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkForSettingUpUserProfile(
      BuildContext context,
      String titleText,
      String contextText,
      PatientDetailsInformation patientDetails,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    Provider.of<PatientUserDetails>(context, listen: false)
        .setIndividualObjectDetails(patientDetails);
    // Provider.of<PatientUserDetails>(context, listen: false).setPatientUserInfo(
    //   context,
    //   patientDetails,
    // );
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.dangerous_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 55,
            color: Colors.brown,
            onPressed: () {
              Navigator.pop(ctx);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              // Navigator.pushNamed(context, TabsScreenPatient.routeName, (route) => false));
              // Navigator.pushNamed(context, TabsScreenPatient.routeName);

              print(Provider.of<PatientUserDetails>(context, listen: false)
                  .isEnteryMade);
              Provider.of<PatientUserDetails>(context, listen: false)
                  .setPatientUserInfo(
                context,
                patientDetails,
              )
                  .then((value) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    TabsScreenPatient.routeName, (route) => false);
              });

              // Navigator.of(context).pushNamedAndRemoveUntil(TabsScreenPatient.routeName, (route) => false);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => TabsScreenPatient(),
              //   ),
              // );
            },
          ),
        ],
      ),
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
