// ignore_for_file: unused_import, prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, unused_field, must_be_immutable, duplicate_import, equal_keys_in_map, unnecessary_import

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swasthyamitra/screens/FindAddPatientScreens/FindAndAddPatient_Screen.dart';
import 'package:swasthyamitra/screens/FindAddPatientScreens/PatientHome_Screen.dart';
import 'package:swasthyamitra/screens/PatientPrescriptionScreens/PatientGivenPrescriptionScreen.dart';
import 'package:swasthyamitra/screens/PatientPrescriptionScreens/PatientPrescriptionScreen.dart';
import './screens/Tab_Screen.dart';
import "package:flutter/services.dart";

import './providers/SM_FirebaseLinks_Details.dart';
import './providers/SM_Auth_Details.dart';
import './providers/SM_User_Details.dart';
import './providers/SM_FindPatients_Details.dart';
import './providers/SM_DashBoard_Details.dart';

import './screens/SignUp_Screens/SelectLanguage_Screen.dart';
import './screens/SignUp_Screens/SelectSignInSignUp.dart';
import './screens/SignUp_Screens/EnterPersonalDetailsScreen.dart';
import './screens/SignUp_Screens/EnterPhoneNumber_Screen.dart';
import './screens/SignUp_Screens/EnterPhoneOtp_Screen.dart';

import './screens/HomeScreens/Home_Screen.dart';
import './screens/DashBoardScreens/DashBoard_Screen.dart';
import './screens/FindAddPatientScreens/FindAndAddPatient_Screen.dart';
import './screens/AvailableTestsScreens/AvailableTests_Screen.dart';

import './screens/NotificationScreens/Notifications_Screen.dart';
import './screens/ProfileScreens/MyProfile_Screen.dart';
import './screens/SettingScreens/Settings_Screen.dart';
import './screens/AvailableTestsScreens/BookTestsForPaitients_Screen.dart';

import './screens/FindAddPatientScreens/PatientHome_Screen.dart';
import './PatientIndividualSection/providers/patientEmailAuth_details.dart';
import './PatientIndividualSection/providers/patientAuth_details.dart';
import './PatientIndividualSection/providers/patientUser_details.dart';
import './PatientIndividualSection/providers/patientAvailableDoctor_details.dart';
import './PatientIndividualSection/providers/doctorCalendar_details.dart';
import './PatientIndividualSection/providers/appointmentUpdation_details.dart';
import './PatientIndividualSection/providers/bookedAppointmentsAndTests_details.dart';
import './PatientIndividualSection/providers/paientHealthAndWellNess_details.dart';
import './PatientIndividualSection/providers/patientChatMessage_details.dart';
import './PatientIndividualSection/providers/patientHomeScreen_details.dart';
import './PatientIndividualSection/providers/patientTransaction_details.dart';
import './PatientIndividualSection/providers/patientTestUpdation_details.dart';

import './PatientIndividualSection/screens/AppointsAndTests_Screens/AppointmentsNTests_Screen.dart';
import './PatientIndividualSection/screens/FindDoctors_Screens/FindDoctorScreen.dart';
import './PatientIndividualSection/screens/HealthNFitness_Screens/HealthAndFitness_screen.dart';
import './PatientIndividualSection/screens/Home_Screens/Home_Screen.dart';
import './PatientIndividualSection/screens/MyProfile_Screen.dart';
import './PatientIndividualSection/screens/MySettings_Screen.dart';
import './PatientIndividualSection/screens/SignUp_Screens/SelectLanguage_Screen.dart';
import './PatientIndividualSection/screens/SignUp_Screens/SelectSignInSignUp.dart';
import './PatientIndividualSection/screens/Tabs_Screen.dart';
import './PatientIndividualSection/screens/SignUp_Screens/SelectPhoneNumberEmail_Screen.dart';
import './PatientIndividualSection/screens/SignUp_Screens/EnterPersonalDetailsScreen.dart';
import './PatientIndividualSection/screens/SignUp_Screens/EnterPhoneNumber_Screen.dart';
import './PatientIndividualSection/screens/SignUp_Screens/EnterPhoneOtp_Screen.dart';
import './PatientIndividualSection/screens/SignUp_Screens/EnterPatientEmailId_Screen.dart';
import './PatientIndividualSection/screens/SignUp_Screens/EnterPatientEmailPassword_Screen.dart';
import './PatientIndividualSection/screens/BookTests_Screen/PatientBookTest_Screen.dart';
import './providers/SM_Patient_Personal_Details.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('A bg message just showed up: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  late UserCredential userCred;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SwasthyaMitraFirebaseDetails(),
        ),
        ChangeNotifierProvider.value(
          value: SwasthyaMitraAuthDetails(),
        ),
        ChangeNotifierProvider.value(
          value: SwasthyaMitraUserDetails(),
        ),
        ChangeNotifierProvider.value(
          value: SwasthyaMitraFindPatientDetails(),
        ),
        /////////////////////////////////////////////

        ChangeNotifierProvider.value(
          value: PatientEmailAuthDetails(),
        ),
        ChangeNotifierProvider.value(
          value: PatientAuthDetails(),
        ),
        ChangeNotifierProvider.value(
          value: PatientUserDetails(),
        ),
        ChangeNotifierProvider.value(
          value: PatientAvailableDoctorDetails(),
        ),
        ChangeNotifierProvider.value(
          value: DoctorCalendarDetails(),
        ),
        ChangeNotifierProvider.value(
          value: AppointmentUpdationDetails(),
        ),
        ChangeNotifierProvider.value(
          value: BookedAppointmentsAndTestDetails(),
        ),
        ChangeNotifierProvider.value(
          value: PatientChatMessageDetails(),
        ),
        ChangeNotifierProvider.value(
          value: PatientHomeScreenrDetails(),
        ),
        ChangeNotifierProvider.value(
          value: PatientTransactionDetails(),
        ),
        ChangeNotifierProvider.value(
          value: PatientHealthAndWellNessDetails(),
        ),
        ChangeNotifierProvider.value(
          value: SwasthyaMitraDashBoardDetails(),
        ),
        ChangeNotifierProvider.value(
          value: SwasthyaMitraPatientPersonalDetails(),
        ),
        ChangeNotifierProvider.value(
          value: PatientTestAppointmentUpdationDetails(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Swasthya Mitra",
        theme: ThemeData(
          primaryColor: const Color(0xFFfbfcff),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          canvasColor: Color.fromRGBO(255, 254, 229, 0.9),
          hoverColor: Colors.transparent,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(
            secondary: Color.fromARGB(255, 84, 83, 77),
          ),
        ),
        home: StreamBuilder(
          stream: _auth.authStateChanges(),
          builder: (ctx, userSnapShot) {
            if (userSnapShot.hasData) {
              return TabsScreenSwasthyaMitra();
            } else {
              return SelectLanguageScreenSwasthyaMitra();
            }
          },
        ),
        routes: {
          SelectLanguageScreenSwasthyaMitra.routeName: (ctx) =>
              SelectLanguageScreenSwasthyaMitra(),
          SelectSignInSignUpScreenSwasthyaMitra.routeName: (ctx) =>
              SelectSignInSignUpScreenSwasthyaMitra(),
          EnterUserPersonalDetailsScreen.routeName: (ctx) =>
              EnterUserPersonalDetailsScreen(),
          EnterPhoneNumberScreen.routeName: (ctx) => EnterPhoneNumberScreen(),
          EnterPhoneOtpScreen.routeName: (ctx) => EnterPhoneOtpScreen(),

          TabsScreenSwasthyaMitra.routeName: (ctx) => TabsScreenSwasthyaMitra(),
          HomeScreenSwasthyaMitra.routeName: (ctx) => HomeScreenSwasthyaMitra(),
          BookTestForPatientSwasthyaMitra.routeName: (ctx) =>
              BookTestForPatientSwasthyaMitra(),
          DashBoardScreenSwasthyaMitra.routeName: (ctx) =>
              DashBoardScreenSwasthyaMitra(),
          FindAndAddPatientScreenSwasthyaMitra.routeName: (ctx) =>
              FindAndAddPatientScreenSwasthyaMitra(),
          AvailableTestsSwasthyaMitra.routeName: (ctx) =>
              AvailableTestsSwasthyaMitra(),

          PatientPrescriptionScreenSwasthyaMitra.routeName: (ctx) =>
              PatientPrescriptionScreenSwasthyaMitra(),

          NotificationScreenSwasthyaMitra.routeName: (ctx) =>
              NotificationScreenSwasthyaMitra(),
          MyProfileScreenSwasthyaMitra.routeName: (ctx) =>
              MyProfileScreenSwasthyaMitra(),
          SettingScreenSwasthyaMitra.routeName: (ctx) =>
              SettingScreenSwasthyaMitra(),

          // ////////////////////////////////////////////////////////////////////////////////////////////////////

          SelectLanguageScreenPatient.routeName: (ctx) =>
              SelectLanguageScreenPatient(),
          SelectSignInSignUpScreenPatient.routeName: (ctx) =>
              SelectSignInSignUpScreenPatient(),
          EnterPhoneNumberEmailSectionScreen.routeName: (ctx) =>
              EnterPhoneNumberEmailSectionScreen(),
          EnterPatientUserPersonalDetailsScreen.routeName: (ctx) =>
              EnterPatientUserPersonalDetailsScreen(),
          EnterPatientPhoneNumberScreen.routeName: (ctx) =>
              EnterPatientPhoneNumberScreen(),
          EnterPatientPhoneOtpScreen.routeName: (ctx) =>
              EnterPatientPhoneOtpScreen(),
          EnterPatientEmailIdScreen.routeName: (ctx) =>
              EnterPatientEmailIdScreen(),
          EnterPatientEmailPasswordScreen.routeName: (ctx) =>
              EnterPatientEmailPasswordScreen(),
          TabsScreenPatient.routeName: (ctx) => TabsScreenPatient(),
          HomeScreenPatient.routeName: (ctx) => HomeScreenPatient(),
          BookTestScreenPatient.routeName: (ctx) => BookTestScreenPatient(),
          AppointmentsAndTestsScreenPatient.routeName: (ctx) =>
              AppointmentsAndTestsScreenPatient(),
          FindDoctorScreenPatient.routeName: (ctx) => FindDoctorScreenPatient(),
          HealthAndFitnessScreenPatient.routeName: (ctx) =>
              HealthAndFitnessScreenPatient(),
          MyProfileScreen.routeName: (ctx) => MyProfileScreen(),
          MySettingsScreen.routeName: (ctx) => MySettingsScreen(),
        },
      ),
    );
  }
}
