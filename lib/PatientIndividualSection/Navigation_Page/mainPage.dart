import 'package:flutter/material.dart';

import '../Helper/constants.dart';
import 'SearchPage.dart';
import 'TestDetail.dart';
import 'homepage.dart';

class MainPage extends StatefulWidget {
  String name;
  MainPage({Key? key,required this.name}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  List navigationpages = [
    HomePage(name: "harsh",),
    AllTestDetail(),
    SearchPage(),
    SafeArea(
      child: Center(child: Text("not given in figma")),
    ),
    SafeArea(
      child: Center(child: Text("not given in figma")),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: navigationpages[index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.08333*_width),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 0.02777*_width),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0.08333*_width),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            currentIndex: index,
            elevation: 12,
            selectedItemColor: AppColors.AppmainColor,
            unselectedItemColor: AppColors.unpressednavigation,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items:  [
              BottomNavigationBarItem(icon: Image.asset("assets/images/Home(BW).png",color: index==0?AppColors.AppmainColor:null,), label: "Home"),
              BottomNavigationBarItem(icon: Image.asset("assets/images/Test(BW).png",color: index==1?AppColors.AppmainColor:null), label: "Test"),
              BottomNavigationBarItem(icon: Image.asset("assets/images/Search(BW).png",color: index==2?AppColors.AppmainColor:null), label: "Search"),
              BottomNavigationBarItem(icon: Image.asset("assets/images/Capsule(BW).png",color: index==3?AppColors.AppmainColor:null), label: "Medicine"),
              BottomNavigationBarItem(icon: Image.asset("assets/images/Heart(BW).png",color: index==4?AppColors.AppmainColor:null), label: "Heart"),
            ],
          ),
        ),
      ),
    );
  }
}
