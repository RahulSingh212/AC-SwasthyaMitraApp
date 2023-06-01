import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Login_Page/login_page.dart';
import 'Login_Page/login_page3.dart';
import 'Navigation_Page/mainPage.dart';

class RoutedBasedAuth extends StatefulWidget {
  const RoutedBasedAuth({Key? key}) : super(key: key);

  @override
  _RoutedBasedAuthState createState() => _RoutedBasedAuthState();
}

class _RoutedBasedAuthState extends State<RoutedBasedAuth> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null) {
              dynamic u = snapshot.data;
              int phoneno = int.parse(u.phoneNumber.substring(3, 13));
              print(u.phoneNumber);
              print(u.displayName.runtimeType);
              if (u.displayName == "") {
                return LoginPage3(
                  phoneno: phoneno,
                );
              } else {
                return MainPage(name: u.displayName);
              }

              // LoginPage3(phoneno:snapshot.data ,)
              //  agar nam de diya ha to Main page varna  login3 page

            } else {
              return LoginPage();
            }
          }

          return LoginPage();
        });
  }
}
