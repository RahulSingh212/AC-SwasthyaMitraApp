// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, unused_import, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unused_element

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/PatientIndividualSection/providers/patientAuth_details.dart';
import 'package:swasthyamitra/PatientIndividualSection/providers/patientUser_details.dart';
import 'package:swasthyamitra/PatientIndividualSection/screens/SignUp_Screens/SelectLanguage_Screen.dart';
import 'package:swasthyamitra/screens/PatientPrescriptionScreens/PatientGivenPrescriptionScreen.dart';

import '../../PatientIndividualSection/screens/Tabs_Screen.dart';
import '../../models/patient_Info.dart';
import '../../providers/SM_Auth_Details.dart';
import '../../providers/SM_User_Details.dart';
import '../../providers/SM_FindPatients_Details.dart';

import '../../screens/FindAddPatientScreens/PatientHome_Screen.dart';
import '../FindAddPatientScreens/PatientFiltered_Screen.dart';

class PatientPrescriptionScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-patient-prescription-screen';

  @override
  State<PatientPrescriptionScreenSwasthyaMitra> createState() =>
      _PatientPrescriptionScreenSwasthyaMitraState();
}

class _PatientPrescriptionScreenSwasthyaMitraState
    extends State<PatientPrescriptionScreenSwasthyaMitra> {
  TextEditingController _search = new TextEditingController();
  bool isLangEnglish = true;
  Map<String, String> userMapping = {};

  @override
  void initState() {
    super.initState();

    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<SwasthyaMitraFindPatientDetails>(context, listen: false)
        .fetchPatientsForSwasthyaMitraCenter(context, {});

    userMapping = Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
        .getSwasthyaMitraUserPersonalInformation();
  }

  Future<void> _refreshAvailableDoctors(
    BuildContext context,
    Map<String, String> filteredOptions,
  ) async {
    Provider.of<SwasthyaMitraFindPatientDetails>(context, listen: false)
        .fetchPatientsForSwasthyaMitraCenter(context, {});
  }

  Future<void> _refreshSwasthyaMitraPatientInformation(BuildContext ctx) async {
    Provider.of<SwasthyaMitraFindPatientDetails>(ctx, listen: false)
        .fetchPatientsForSwasthyaMitraCenter(ctx, {});
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
    var width = screenWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          enableFeedback: false,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Color(0xff42ccc3),
            size: 35,
          ),
        ),
        title: Text(
          isLangEnglish ? "Available Patients" : "उपलब्ध मरीज",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      // AppBar(
      //   elevation: 1,
      //   centerTitle: false,
      //   toolbarHeight: maxDimension * 0.2,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   title: Column(
      //     children: [
      //       Align(
      //         alignment: Alignment.centerLeft,
      //         child: Container(
      //           padding: EdgeInsets.only(
      //             right: 0.45 * width,
      //             bottom: 0.02 * width,
      //           ),
      //           child: Text(
      //             isLangEnglish ? "My Patients" : "मेरे मरीज",
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.w400,
      //               fontSize: minDimension * 0.065,
      //             ),
      //             textAlign: TextAlign.left,
      //           ),
      //         ),
      //       ),
      //       Align(
      //         alignment: Alignment.centerLeft,
      //         child: Container(
      //           padding: EdgeInsets.only(
      //             left: 0.01 * width,
      //             bottom: 0.02 * width,
      //           ),
      //           child: Text(
      //             isLangEnglish
      //                 ? "'Find' your patients and 'Add' new patients"
      //                 : "अपने मरीज को 'खोजें' और नए मरीज को 'जोड़ें'",
      //             style: TextStyle(
      //               color: Colors.grey,
      //               fontWeight: FontWeight.w400,
      //               fontSize: minDimension * 0.04,
      //             ),
      //             textAlign: TextAlign.left,
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: screenHeight * 0.01,
      //       ),
      //       Align(
      //         alignment: Alignment.center,
      //         child: Container(
      //           width: screenWidth * 0.925,
      //           child: TextField(
      //             controller: _search,
      //             decoration: InputDecoration(
      //               hintText: isLangEnglish ? "Search" : "खोज",
      //               border: OutlineInputBorder(),
      //               enabledBorder: OutlineInputBorder(
      //                 borderSide: BorderSide(color: Color(0xffebebeb)),
      //                 borderRadius: BorderRadius.circular(15),
      //               ),
      //               hintStyle: TextStyle(
      //                 fontFamily: 'Roboto',
      //                 fontWeight: FontWeight.w400,
      //                 fontSize: 15,
      //                 fontStyle: FontStyle.normal,
      //                 color: Color(0xff6c757d),
      //               ),
      //               suffixIcon: IconButton(
      //                 icon: Image.asset('assets/images/Search.png'),
      //                 iconSize: minDimension * 0.125,
      //                 onPressed: () {
      //                   TextEditingController searchedText =
      //                       TextEditingController();
      //                   searchedText.text = _search.text;

      //                   Provider.of<SwasthyaMitraFindPatientDetails>(context,
      //                           listen: false)
      //                       .fetchFilteredPatientsForSwasthyaMitra(
      //                     context,
      //                     searchedText,
      //                   )
      //                       .then((value) {
      //                     Navigator.of(context).push(
      //                       MaterialPageRoute(
      //                         builder: (context) =>
      //                             PatientFilteredScreenSwasthyaMitra(
      //                           searchedText,
      //                           "PatientScreen"
      //                         ),
      //                       ),
      //                     );
      //                     _search.text = "";
      //                     FocusScope.of(context).unfocus();
      //                   });
      //                 },
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       // SizedBox(
      //       //   height: screenHeight * 0.2,
      //       // ),
      //     ],
      //   ),
      // ),
      body: Provider.of<SwasthyaMitraFindPatientDetails>(context)
              .getItemsCompletePatientDetails
              .isEmpty
          ? Align(
              child: Container(
                alignment: Alignment.center,
                height: screenHeight * 0.25,
                width: screenWidth * 0.7,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.005,
                ),
                child: Text(
                  isLangEnglish
                      ? "No previoius patients available"
                      : "कोई पिछला मारिज उपलब्ध नहीं है",
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
          : Container(
              child: ListView.builder(
                itemCount: Provider.of<SwasthyaMitraFindPatientDetails>(context)
                        .getItemsCompletePatientDetails
                        .length +
                    1,
                itemBuilder: (ctx, index) {
                  if (index <
                      Provider.of<SwasthyaMitraFindPatientDetails>(context)
                          .getItemsCompletePatientDetails
                          .length) {
                    return patientDetailInfoWidget(
                      context,
                      Provider.of<SwasthyaMitraFindPatientDetails>(context)
                          .getItemsCompletePatientDetails[index],
                    );
                  } else {
                    return SizedBox(
                      height: screenHeight * 0.025,
                    );
                  }
                },
              ),
            ),
      // floatingActionButton: isAuthorized
      //     ? SizedBox(
      //         width: screenWidth * 0.8,
      //         child: FloatingActionButton.extended(
      //           elevation: 5,
      //           onPressed: () {
      //             Provider.of<PatientUserDetails>(context, listen: false)
      //                     .swasthyaMitraUniqueCred =
      //                 Provider.of<SwasthyaMitraUserDetails>(context,
      //                         listen: false)
      //                     .mp['SwasthyaMitra_personalUniqueIdentificationId']
      //                     .toString();
      //             Provider.of<PatientAuthDetails>(context, listen: false)
      //                 .getExistingPatientsUserPhoneNumbers(context);
      //             Navigator.pushNamed(
      //                 context, SelectLanguageScreenPatient.routeName);
      //           },
      //           icon: Icon(
      //             Icons.person_add_alt_sharp,
      //             size: screenWidth * 0.075,
      //           ),
      //           label: Text(
      //             isLangEnglish ? "Add New Patient" : "नया रोगी जोड़ें",
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: screenWidth * 0.045,
      //             ),
      //           ),
      //           backgroundColor: Color.fromRGBO(66, 204, 195, 1),
      //         ),
      //       )
      //     : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PatientGivenPresciptionScreenSwasthyaMitra(
              patientDetails,
            ),
          ),
        );
        print(patientDetails.patient_FullName);
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
              print(Provider.of<PatientUserDetails>(context, listen: false)
                  .isEnteryMade);
              Navigator.of(context).pushNamed(
                  PatientGivenPresciptionScreenSwasthyaMitra.routeName);
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
