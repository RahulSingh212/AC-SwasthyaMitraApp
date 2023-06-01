// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable, import_of_legacy_library_into_null_safe, deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:open_file_safe/open_file_safe.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/token_info.dart';
import '../../providers/patientUser_details.dart';

class PatientViewPrescriptionScreen extends StatefulWidget {
  static const routeName = '/patient-view-prescription-screen';

  int pageIndex;
  String patientUserUniqueId;
  BookedTokenSlotInformation tokenInfo;

  PatientViewPrescriptionScreen(
    this.pageIndex,
    this.patientUserUniqueId,
    this.tokenInfo,
  );

  @override
  State<PatientViewPrescriptionScreen> createState() =>
      _PatientViewPrescriptionScreenState();
}

class _PatientViewPrescriptionScreenState
    extends State<PatientViewPrescriptionScreen> {
  bool isLangEnglish = true;
  bool _isDocumentFileTaken = false;
  File _documentFile = new File("");

  late Future<ListResult> futureFilesPatPres;
  late Future<ListResult> futureFilesDocPres;

  double prescriptionSize = 0;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();

    String aptDate = "${widget.tokenInfo.bookedTokenDate.day}-${widget.tokenInfo.bookedTokenDate.month}-${widget.tokenInfo.bookedTokenDate.year}";
    String aptTime = widget.tokenInfo.bookedTokenTime.toString();
    String refLinkForPatientPrescription = "PatientReportsAndPrescriptionsDetails/${widget.patientUserUniqueId}/${widget.tokenInfo.doctor_personalUniqueIdentificationId}/${widget.tokenInfo.registeredTokenId}/${aptDate}/${aptTime}/PatientPreviousPrescription";
    String refLinkForDoctorPrescription = "PatientReportsAndPrescriptionsDetails/${widget.patientUserUniqueId}/${widget.tokenInfo.doctor_personalUniqueIdentificationId}/${widget.tokenInfo.registeredTokenId}/${aptDate}/${aptTime}/DoctorGivenPrescription";

    futureFilesPatPres = FirebaseStorage.instance
        .ref('/${refLinkForPatientPrescription}')
        .listAll();
    futureFilesDocPres = FirebaseStorage.instance
        .ref('/${refLinkForDoctorPrescription}')
        .listAll();

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

    prescriptionSize = screenHeight * 0.15;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        title: Text(
            isLangEnglish ? 'Previous Prescriptions' : "पिछले चिकित्सा पर्ची"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              isLangEnglish ? "Doctor's Prescription" : "डॉक्टर चिकित्सा पर्ची",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          futureFilesDocPres.toString() == null
              ? Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.25,
                    child: Text(
                      isLangEnglish
                          ? "No prescription uploaded from the doctor"
                          : "डॉक्टर की ओर से कोई प्रिस्क्रिप्शन अपलोड नहीं किया गया",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                )
              : Align(
                  child: Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.25,
                    child: Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 0.5,
                          color: Color.fromRGBO(242, 242, 242, 1),
                        ),
                      ),
                      child: Container(
                        child: FutureBuilder<ListResult>(
                          future: futureFilesDocPres,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // print("hasData");
                              final files = snapshot.data!.items;

                              if (files.isEmpty) {
                                return Center(
                                  child: Container(
                                    child: Text(
                                      isLangEnglish
                                          ? "No prescription uploaded from the doctor"
                                          : "डॉक्टर की ओर से कोई प्रिस्क्रिप्शन अपलोड नहीं किया गया",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                physics: ScrollPhysics(),
                                itemCount: files.length,
                                itemBuilder: (context, index) {
                                  final file = files[index];
                                  double? progress = downloadProgress[index];

                                  return ListTile(
                                    title: Text(
                                      file.name,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    subtitle: progress != null
                                        ? LinearProgressIndicator(
                                            value: progress,
                                            backgroundColor: Colors.black,
                                          )
                                        : null,
                                    trailing: IconButton(
                                      onPressed: () =>
                                          downloadFiles(file, index),
                                      icon: Icon(
                                        Icons.download,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              // print("hasError");
                              return Container(
                                child: Center(
                                  child: Text(isLangEnglish
                                      ? "Error occoured"
                                      : "त्रुटि हुई"),
                                ),
                              );
                            } else {
                              // print("else");
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              isLangEnglish
                  ? "Your uploaded Prescription"
                  : "आपका अपलोड प्रिस्क्रिप्शन",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.001,
          ),
          Align(
            child: futureFilesPatPres.toString() == null
                ? Container(
                    alignment: Alignment.center,
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.9,
                    child: Text(
                      isLangEnglish
                          ? "No previous prescription uploaded from your end"
                          : "आपकी ओर से कोई पिछला नुस्खा अपलोड नहीं किया गया",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : Container(
                    width: screenWidth * 0.9,
                    height: screenHeight * 0.25,
                    child: Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 0.5,
                          color: Color.fromRGBO(242, 242, 242, 1),
                        ),
                      ),
                      child: Container(
                        child: FutureBuilder<ListResult>(
                          future: futureFilesPatPres,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // print("hasData");
                              final files = snapshot.data!.items;

                              if (files.isEmpty) {
                                return Center(
                                  child: Container(
                                    child: Text(
                                      isLangEnglish
                                          ? "No previous prescription uploaded from your end"
                                          : "आपकी ओर से कोई पिछला नुस्खा अपलोड नहीं किया गया",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: screenWidth * 0.055,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                physics: ScrollPhysics(),
                                itemCount: files.length,
                                itemBuilder: (context, index) {
                                  final file = files[index];
                                  double? progress = downloadProgress[index];

                                  return ListTile(
                                    title: Text(
                                      file.name,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    subtitle: progress != null
                                        ? LinearProgressIndicator(
                                            value: progress,
                                            backgroundColor: Colors.black,
                                          )
                                        : null,
                                    trailing: IconButton(
                                      onPressed: () =>
                                          downloadFiles(file, index),
                                      icon: Icon(
                                        Icons.download,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              // print("hasError");
                              return Container(
                                child: Center(
                                  child: Text(isLangEnglish
                                      ? "Error occoured"
                                      : "त्रुटि हुई"),
                                ),
                              );
                            } else {
                              // print("else");
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: screenHeight * 0.15,
          ),
          checkTokenPrescriptionUploadTime(widget.tokenInfo.bookedTokenDate,
                  widget.tokenInfo.bookedTokenTime)
              ? Align(
                  child: Container(
                    width: screenWidth * 0.85,
                    child: ElevatedButton.icon(
                      onPressed: !_isDocumentFileTaken
                          ? () async {
                              final result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                                type: FileType.custom,
                                allowedExtensions: ['pdf', 'doc'],
                              );
                              if (result == null) {
                                String titleText = isLangEnglish
                                    ? "No prescription picked!"
                                    : "कोई प्रिस्क्रिप्शन नहीं चुने गए!";
                                String contextText = isLangEnglish
                                    ? "Unable to upload the prescription..."
                                    : "प्रिस्क्रिप्शन अपलोड करने में असमर्थ...";
                                _checkForError(context, titleText, contextText);
                                return;
                              }

                              final file = result.files.first;
                              openSingleDocumentFile(file);

                              setState(() {
                                _isDocumentFileTaken = true;
                                _documentFile = File(file.path!);
                              });

                              Provider.of<PatientUserDetails>(context,
                                      listen: false)
                                  .uploadPatientAppointmentPrescription(
                                context,
                                widget.tokenInfo,
                                _documentFile,
                              )
                                  .then((value) {
                                setState(() {
                                  _isDocumentFileTaken = false;
                                });
                              });
                            }
                          : null,
                      icon: Icon(
                        Icons.file_present_sharp,
                        size: screenWidth * 0.075,
                      ),
                      label: Text(
                        isLangEnglish
                            ? "UPLOAD PRESCRIPTION"
                            : "अपलोड प्रिस्क्रिप्शन",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(66, 204, 195, 1),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.0125,
                          horizontal: screenWidth * 0.075,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(75),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: screenHeight * 0.025,
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

  Future<void> downloadFiles(Reference ref, int index) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    final url = await ref.getDownloadURL();

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/${ref.name}';
    await Dio().download(url, path, onReceiveProgress: (received, total) {
      double progress = received / total;

      setState(() {
        downloadProgress[index] = progress;
      });
    });

    if (url.contains('.mp4')) {
      await GallerySaver.saveVideo(path, toDcim: true);
    } else if (url.contains('.pdf')) {
      openPrescription(context, url.toString());
    } else if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }
  }

  Future<void> openPrescription(
    BuildContext context,
    String url,
  ) async {
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
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            width: screenWidth * 0.9,
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: isLangEnglish ? "Link: " : "लिंक: ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "Press to view",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Failed';
                        }
                      },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool checkTokenPrescriptionUploadTime(
    DateTime bookedTokenDate,
    TimeOfDay bookedTokenTime,
  ) {
    DateTime today = DateTime.now();

    if (bookedTokenDate.add(Duration(days: 1)).isBefore(today) == false) {
      return true;
    } else {
      return false;
    }
  }

  bool checkContactDoctorEnability() {
    if (widget.tokenInfo.bookedTokenDate.day == DateTime.now().day &&
        widget.tokenInfo.bookedTokenDate.month == DateTime.now().month &&
        widget.tokenInfo.bookedTokenDate.year == DateTime.now().year) {
      int currTime = DateTime.now().hour * 60 + DateTime.now().minute;
      int regTime = widget.tokenInfo.bookedTokenTime.hour * 60 +
          widget.tokenInfo.bookedTokenTime.minute;

      if (currTime >= regTime - 15 && currTime <= regTime + 45) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
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
