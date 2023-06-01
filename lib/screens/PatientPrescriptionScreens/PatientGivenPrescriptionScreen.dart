// ignore_for_file: unnecessary_this, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use, unused_import, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unused_element, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/PatientIndividualSection/providers/patientAuth_details.dart';
import 'package:swasthyamitra/PatientIndividualSection/providers/patientUser_details.dart';
import 'package:swasthyamitra/PatientIndividualSection/screens/SignUp_Screens/SelectLanguage_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/patient_Info.dart';
import '../../providers/SM_User_Details.dart';

class PatientGivenPresciptionScreenSwasthyaMitra extends StatefulWidget {
  static const routeName = 'swasthya-mitra-patient-given-prescription-screen';

  PatientDetailsInformation patientDetails;
  PatientGivenPresciptionScreenSwasthyaMitra(this.patientDetails);

  @override
  State<PatientGivenPresciptionScreenSwasthyaMitra> createState() =>
      _PatientGivenPresciptionScreenSwasthyaMitraState();
}

class _PatientGivenPresciptionScreenSwasthyaMitraState
    extends State<PatientGivenPresciptionScreenSwasthyaMitra> {
  bool isLangEnglish = true;

  File _prescriptionPicture = new File("");
  bool _isPrescriptionTaken = false;
  final pdf = pw.Document();

  late Future<ListResult> futureFilesSM;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();

    isLangEnglish =
        Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
            .isReadingLangEnglish;

    futureFilesSM = FirebaseStorage.instance
        .ref(
            '/SwasthyaMitraReportsAndPrescriptionsDetails/${widget.patientDetails.patient_personalUniqueIdentificationId}')
        .listAll();
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
      backgroundColor: Color(0xFFf2f3f4),
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
          isLangEnglish ? "Prescriptions" : "नुस्खे",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
      ),
      body: Align(
        child: futureFilesSM.toString() == null
            ? Container(
                alignment: Alignment.center,
                height: screenHeight * 0.85,
                width: screenWidth * 0.95,
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
                height: screenHeight * 0.85,
                width: screenWidth * 0.95,
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
                      future: futureFilesSM,
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
                                  onPressed: () => downloadFiles(file, index),
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff42ccc3),
        onPressed: () async {
          final picker = ImagePicker();
          final imageFile = await picker.getImage(
            source: ImageSource.camera,
            // imageQuality: 80,
            // maxHeight: 650,
            // maxWidth: 650,
          );

          if (imageFile == null) {
            return;
          }

          setState(() {
            _prescriptionPicture = File(imageFile.path);
            _isPrescriptionTaken = true;
          });

          _saveUploadedImage(context);
        },
        label: Text(isLangEnglish ? "Add" : "जोड़ें"),
        icon: Icon(Icons.add),
      ),
    );
  }

  Future<void> _saveUploadedImage(
    BuildContext context,
  ) async {
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
                  child: Image.file(
                    _prescriptionPicture,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          InkWell(
            onTap: () async {
              createPDFfromImage();
              final bytes = await pdf.save();
              final dir = await getApplicationDocumentsDirectory();
              final file = File('${dir.path}/prescription_${DateTime.now()}');
              await file.writeAsBytes(bytes);

              print("1");
              Provider.of<SwasthyaMitraUserDetails>(context, listen: false)
                  .uploadPatientPrescription(
                context,
                widget.patientDetails,
                file,
              );

              // savePrescriptionPDF();
              Navigator.pop(context);
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
                      isLangEnglish ? "Save Prescription" : "पर्चे सेव करे",
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

  createPDFfromImage() async {
    final imageData = pw.MemoryImage(_prescriptionPicture.readAsBytesSync());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(imageData),
          );
        },
      ),
    );
  }

  savePrescriptionPDF() async {
    try {
      // final dir = await getApplicationDocumentsDirectory();
      // final dir = await getExternalStorageDirectory();
      final dir = await getApplicationDocumentsDirectory();
      final file = File(
          "${dir.path}/PatientPrescriptions/${widget.patientDetails.patient_personalUniqueIdentificationId}/file_${DateTime.now()}.pdf");
      await file.writeAsBytes(await pdf.save());

      showPrintedMessage(
        isLangEnglish ? "Successful" : "सफल",
        isLangEnglish
            ? "Prescription successfully saved."
            : "प्रिस्क्रिप्शन सफलतापूर्वक सहेजा गया।",
      );
    } catch (errorVal) {
      print(errorVal);
      showPrintedMessage("Error", errorVal.toString());
    }
  }

  showPrintedMessage(String title, String msg) {
    Flushbar(
      title: title,
      message: msg,
      duration: Duration(seconds: 3),
      icon: Icon(
        Icons.info,
        color: Colors.pink.shade50,
      ),
    )..show(context);
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
    } 
    else if (url.contains('.pdf')) {
      openPrescription(context, url);
    }
    else if (url.contains('.jpg')) {
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
}
