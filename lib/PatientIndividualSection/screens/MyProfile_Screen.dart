// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, unused_field, prefer_const_literals_to_create_immutables, use_build_context_synchronously, sized_box_for_whitespace, avoid_unnecessary_containers, unused_import, import_of_legacy_library_into_null_safe, unused_local_variable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/patientAuth_details.dart';
import '../providers/patientUser_details.dart';
import './Tabs_Screen.dart';
import './MySettings_Screen.dart';

class MyProfileScreen extends StatefulWidget {
  static const routeName = '/patient-my-profile-screen';

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isLangEnglish = true;
  File _profilePicture = new File("");
  bool _isProfilePicTaken = false;

  File _prescriptionFile = new File("");
  bool _isDocumentFileTaken = false;
  String docFileName = "";
  String docFileBytes = "";
  String docFileSize = "";
  String docFileExtentionType = "";
  String docFileLocation = "";

  bool isSaveChangesBtnActive = false;

  Map<String, bool> editBtnMapping = {
    "patient_FullName": false,
    "patient_Gender": false,
    "patient_Age": false,
    "patient_Height": false,
    "patient_Weight": false,
    "patient_BloodGroup": false,
    "patient_Allergies": false,
    "patient_Medication": false,
    "patient_Injuries": false,
    "patient_Surgeries": false,
    "patient_PhoneNumber": false,
    "patient_CurrentCity": false,
    "patient_CurrentCityPinCode": false,
    "patient_RegistrationDetails": false,
  };

  Map<String, String> userMapping = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userMapping = Provider.of<PatientUserDetails>(context)
        .getPatientUserPersonalInformation();
  }

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
    
    Provider.of<PatientUserDetails>(context, listen: false).setIndividualObjectDetails(Provider.of<PatientUserDetails>(context, listen: false).getIndividualObjectDetails());
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var maxDimension = max(screenHeight, screenWidth);
    var minDimension = min(screenHeight, screenWidth);

    bool isImageAvailable = false;
    final defaultImg = 'assets/images/healthy.png';

    var userInfoDetails = Provider.of<PatientUserDetails>(context);
    Map<String, String> userMapping =
        userInfoDetails.getPatientUserPersonalInformation();

    String imageNetworkUrl = userMapping["patient_ProfilePicUrl"] ?? "";
    // String imageNetworkUrl = Provider.of<PatientUserDetails>(context, listen: false).getIndividualObjectDetails().patient_ProfilePicUrl;

    return Scaffold(
      // backgroundColor: Color.fromRGBO(66, 204, 195, 0.84),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            color: Color.fromRGBO(66, 204, 195, 0.84),
            // color: Colors.amber,
            height: maxDimension * 0.245,
            margin: EdgeInsets.only(
                // left: screenWidth * 0.0125,
                // right: screenWidth * 0.0125,
                // top: screenHeight * 0.0275,
                // top: screenHeight * 0.001,
                // bottom: screenHeight * 0.005,
                ),
            padding: EdgeInsets.only(
              left: screenWidth * 0.015,
              right: screenWidth * 0.015,
              top: screenHeight * 0.0075,
              bottom: screenHeight * 0.001,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreenPatient.routeName);
                  },
                  iconSize: 30,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.center,
                    // color: Colors.grey,
                    height: screenHeight * 0.235,
                    width: screenWidth * 0.45,
                    padding: EdgeInsets.symmetric(
                      // vertical: screenHeight * 0.005,
                      horizontal: screenWidth * 0.01,
                    ),
                    margin: EdgeInsets.only(
                      top: maxDimension * 0.0025,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenWidth * 0.025,
                        ),
                        Container(
                          height: screenWidth * 0.315,
                          width: screenWidth * 0.315,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: screenWidth,
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
                                    child: _isProfilePicTaken
                                        ? Image.file(
                                            _profilePicture,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          )
                                        : imageNetworkUrl == ""
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
                        // Container(
                        //   width: screenWidth * 0.8,
                        //   // height: screenHeight * 0.05,
                        //   child: TextButton(
                        //     style: TextButton.styleFrom(
                        //       textStyle: const TextStyle(
                        //         fontSize: 18,
                        //         color: Color(0xff42ccc3),
                        //       ),
                        //     ),
                        //     onPressed: () {
                        //       if (_isProfilePicTaken) {
                        //         Provider.of<PatientUserDetails>(context,
                        //                 listen: false)
                        //             .updatePatientProfilePicture(
                        //                 context, _profilePicture);
                        //         setState(() {
                        //           _isProfilePicTaken = false;
                        //         });
                        //       } else {
                        //         _seclectImageUploadingType(
                        //           context,
                        //           "Set your Profile Picture",
                        //           "Image Picker",
                        //           imageNetworkUrl,
                        //         );
                        //       }
                        //     },
                        //     child: Text(
                        //       !_isProfilePicTaken
                        //           ? isLangEnglish ? 'CHANGE PHOTO' : "तस्वीर बदलिये"
                        //           : isLangEnglish ? "SAVE PHOTO" : "तस्वीर सेव करें",
                        //       style: TextStyle(
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.bold,
                        //         // color: Color(0xff42ccc3),
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(MySettingsScreen.routeName);
                  },
                  iconSize: 30,
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                width: screenWidth,
                color: Color.fromRGBO(66, 204, 195, 0.84),
                alignment: Alignment.center,
                child: Text(
                  '${userMapping['patient_FullName']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: minDimension * 0.015,
                ),
                width: screenWidth,
                color: Color.fromRGBO(66, 204, 195, 0.84),
                alignment: Alignment.center,
                child: Text(
                  '+91 ${userMapping['patient_PhoneNumber']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.0065,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Name" : "नाम",
            'patient_FullName',
            isLangEnglish ? "Enter your Name..." : "अपना नाम दर्ज करें...",
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Gender" : "लिंग",
            'patient_Gender',
            isLangEnglish ? "Enter your Gender..." : "अपना लिंग दर्ज करें...",
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Age" : "आयु",
            "patient_Age",
            isLangEnglish ? "Enter your Age..." : "अपनी आयु दर्ज करें...",
            userMapping,
            TextInputType.number,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Height (in cm)" : "ऊंचाई (सेमी में)",
            "patient_Height",
            isLangEnglish ? "Enter your Height..." : "अपनी ऊंचाई दर्ज करें ...",
            userMapping,
            TextInputType.number,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Weight (in Kg)" : "वजन (किलोग्राम में)",
            "patient_Weight",
            isLangEnglish ? "Enter your Weight..." : "अपना वजन दर्ज करें ...",
            userMapping,
            TextInputType.number,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Blood Group" : "ब्लड ग्रुप",
            "patient_BloodGroup",
            isLangEnglish
                ? "Enter your Blood Group..."
                : "अपना ब्लड ग्रुप डालें...",
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Allergies (If any)" : "एलर्जी (यदि कोई हो)",
            "patient_Allergies",
            isLangEnglish
                ? "Enter your Allergies..."
                : "अपनी एलर्जी दर्ज करें ...",
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Medications (If any)" : "दवाएं (यदि कोई हो)",
            "patient_Medication",
            isLangEnglish
                ? "Enter your Medication..."
                : "अपनी दवा दर्ज करें ...",
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Injuries (If any)" : "चोट (यदि कोई हो)",
            "patient_Injuries",
            isLangEnglish
                ? "Enter your Previous Injuries..."
                : "अपनी पिछली चोटें दर्ज करें...",
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Surgeries (If any)" : "सर्जरी (यदि कोई हो)",
            "patient_Injuries",
            isLangEnglish
                ? "Enter your Previous Surgeries..."
                : "अपनी पिछली सर्जरी दर्ज करें...",
            userMapping,
            TextInputType.name,
          ),
          // TextFieldContainer(
          //   context,
          //   "Phone Number",
          //   'patient_PhoneNumber',
          //   "Enter your Contact Number...",
          //   userMapping,
          //   TextInputType.number,
          // ),
          TextFieldContainer(
            context,
            isLangEnglish ? "City" : "शहर",
            'patient_CurrentCity',
            isLangEnglish ? "Enter your City..." : "अपना शहर दर्ज करें...",
            userMapping,
            TextInputType.name,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "City Pincode" : "शहर का पिनकोड",
            'patient_CurrentCityPinCode',
            isLangEnglish ? "Enter your Pincode..." : "अपना पिनकोड डालें...",
            userMapping,
            TextInputType.number,
          ),
          TextFieldContainer(
            context,
            isLangEnglish ? "Registration Details" : "पंजीकरण के विवरण",
            'patient_RegistrationDetails',
            isLangEnglish ? "Enter your Address..." : "अपना पता दर्ज करें...",
            userMapping,
            TextInputType.name,
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          // Container(
          //   child: TextButton(
          //     onPressed: !isSaveChangesBtnActive ? null : () {},
          //     child: Container(
          //       width: screenWidth * 0.95,
          //       padding: EdgeInsets.symmetric(
          //         vertical: screenHeight * 0.025,
          //         horizontal: screenWidth * 0.01,
          //       ),
          //       decoration: BoxDecoration(
          //         color: !isSaveChangesBtnActive
          //             ? Color.fromRGBO(220, 229, 228, 1)
          //             : Color(0xff42CCC3),
          //         borderRadius: BorderRadius.circular(10),
          //         border: Border.all(
          //           width: 2,
          //           color: Color(0xffCDCDCD),
          //         ),
          //       ),
          //       child: Center(
          //         child: Text(
          //           "Save Changes",
          //           style: TextStyle(
          //             color: Colors.black,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: screenHeight * 0.0125,
          // ),
        ],
      ),
    );
  }

  Widget imageContainer(BuildContext context, String imgUrl) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    final defaultImg = 'assets/images/healthy.png';
    bool isImageAvailable = false;
    if (imgUrl.length > 0) isImageAvailable = true;

    return Container(
      height: useableHeight * 0.3,
      padding: EdgeInsets.symmetric(
        vertical: useableHeight * 0.010,
        horizontal: screenWidth * 0.015,
      ),
      margin: EdgeInsets.symmetric(
        vertical: useableHeight * 0.0025,
      ),
      child: Card(
        elevation: 15,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100,
          ),
          padding: EdgeInsets.symmetric(vertical: useableHeight * 0.01),
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: screenWidth * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.4),
              child: ClipOval(
                child: isImageAvailable
                    ? Image.network(imgUrl)
                    : Image.asset(defaultImg),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget TextShowingFieldContainer(
    BuildContext context,
    String labelText,
    String contentText,
    Map<String, String> userMapping,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TextEditingController existingText = TextEditingController();
    existingText.text = userMapping[contentText] ?? "";

    existingText.selection = TextSelection.fromPosition(
        TextPosition(offset: existingText.text.length));

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          // color: Color.fromRGBO(66, 204, 195, 1),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.0015,
          // horizontal: screenWidth * 0.00125,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.01,
        ),
        height: screenHeight * 0.1,
        width: screenWidth * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth * 0.775,
              child: TextFormField(
                autocorrect: true,
                autofocus: true,
                enabled: false,
                controller: existingText,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: labelText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextFieldContainer(
    BuildContext context,
    String labelText,
    String contentText,
    String hintTextMsg,
    Map<String, String> userMapping,
    TextInputType keyBoardType,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TextEditingController existingText = TextEditingController();
    existingText.text = userMapping[contentText] ?? "";

    existingText.selection = TextSelection.fromPosition(
        TextPosition(offset: existingText.text.length));

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          // color: Color.fromRGBO(66, 204, 195, 1),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.001,
          // horizontal: screenWidth * 0.00125,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.02,
          vertical: screenHeight * 0.01,
        ),
        height: screenHeight * 0.1,
        // width: screenWidth * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: screenWidth * 0.85,
              child: TextFormField(
                autocorrect: true,
                autofocus: true,
                enabled: editBtnMapping[contentText],
                controller: existingText,
                keyboardType: keyBoardType,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: hintTextMsg,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(8, 255, 198, 1),
                    overflow: TextOverflow.ellipsis,
                    fontSize: 15,
                  ),
                  border: UnderlineInputBorder(),
                  labelText: labelText,
                ),
              ),
            ),
            ClipOval(
              child: Material(
                color: Color.fromRGBO(220, 229, 228, 1), // Button color
                child: InkWell(
                  splashColor: Color.fromRGBO(120, 158, 156, 1), // Splash color
                  onTap: () {
                    setState(() {
                      if (editBtnMapping[contentText] == true) {
                        Provider.of<PatientUserDetails>(context, listen: false)
                            .updatePatientUserPersonalInformation(context,
                                contentText, existingText.text.toString());

                        userMapping[contentText] = existingText.text.toString();
                      }
                      isSaveChangesBtnActive = true;

                      if (editBtnMapping[contentText] == true) {
                        editBtnMapping[contentText] = false;
                      } else {
                        editBtnMapping[contentText] = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: SizedBox(
                      width: screenWidth * 0.075,
                      height: screenWidth * 0.075,
                      child: Icon(
                        editBtnMapping[contentText] == false
                            ? Icons.edit_rounded
                            : Icons.save_rounded,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _seclectImageUploadingType(
    BuildContext context,
    String titleText,
    String contextText,
    String imageNetworkUrl,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    String str1 = "Pick From Galary";
    String str2 = "Click a Picture";

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              final picker = ImagePicker();
              final imageFile = await picker.getImage(
                source: ImageSource.gallery,
                imageQuality: 80,
                maxHeight: 650,
                maxWidth: 650,
              );

              if (imageFile == null) {
                return;
              }

              setState(() {
                _profilePicture = File(imageFile.path);
                _isProfilePicTaken = true;
              });
              Navigator.pop(ctx);
              // _saveUploadedImage(context, imageNetworkUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
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
                      Icons.photo_size_select_actual_rounded,
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
              final picker = ImagePicker();
              final imageFile = await picker.getImage(
                source: ImageSource.camera,
                imageQuality: 80,
                maxHeight: 650,
                maxWidth: 650,
              );

              if (imageFile == null) {
                return;
              }
              setState(() {
                _profilePicture = File(imageFile.path);
                _isProfilePicTaken = true;
              });
              Navigator.pop(ctx);
              // _saveUploadedImage(context, imageNetworkUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
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
                      Icons.camera_alt_rounded,
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

  void openSingleDocumentFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  void openMultipleDocumentFiles(List<PlatformFile> files) {}

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }

  Future<void> _seclectDocumentUploadingType(
    BuildContext context,
    String titleText,
    String contextText,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    String str1 = "Upload from Local Storage";
    String str2 = "Click a Picture";

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              // // For Selecting, Opening, and Saving only one single file
              // final result = await FilePicker.platform.pickFiles(); // will select only one file at a time
              final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
              if (result == null) {
                return;
              }

              setState(() {
                _isDocumentFileTaken = true;
              });

              // // Open Single File
              final file = result.files.first;
              openSingleDocumentFile(file);

              print('Name: ${file.name}');
              print('Bytes: ${file.bytes}');
              print('Size: ${file.size}');
              print('Extension: ${file.extension}');
              print('Path: ${file.path}');

              final newFile = await saveFilePermanently(file);

              print('From Path: ${file.path!}');
              print('To Path: ${newFile.path}');

              // // // For Selecting, Opening, and Saving Multiple files at the same time
              // final result = await FilePicker.platform.pickFiles(allowMultiple: true); // will select multiple files at a time
              // openMultipleDocumentFiles(result!.files);

              // // For Selecting, Opening, and Saving files of specific type at the same time
              // final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc']);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
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
                      Icons.photo_size_select_actual_rounded,
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
        ],
      ),
    );
  }

  Future<void> _saveUploadedImage(
      BuildContext context, String imageNetworkUrl) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        actions: <Widget>[
          Container(
            // height: 0.3 * screenHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.025,
            ),
            alignment: Alignment.center,
            child: Container(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: screenWidth * 0.25,
                child: ClipOval(
                  child: _isProfilePicTaken
                      ? Image.file(
                          _profilePicture,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Image.asset("assets/images/healthy.png"),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          InkWell(
            onTap: () async {
              Provider.of<PatientUserDetails>(context, listen: false)
                  .updatePatientProfilePicture(context, _profilePicture);

              Navigator.pop(ctx);
              setState(() {
                _isProfilePicTaken = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
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
                      Icons.save_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Save Image",
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
            height: screenHeight * 0.01,
          ),
          InkWell(
            onTap: () async {
              imageNetworkUrl == ""
                  ? Image.asset(
                      "assets/images/healthy.png",
                    )
                  : Image.network(
                      imageNetworkUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
              Navigator.pop(ctx);

              setState(() {
                _isProfilePicTaken = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(220, 229, 228, 1),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
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
                      Icons.delete_rounded,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Discard Image",
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
}
