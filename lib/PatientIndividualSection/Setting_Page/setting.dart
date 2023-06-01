import 'package:flutter/material.dart';
import '../Helper/constants.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    return Material(
      child: Container(
        color: AppColors.backgroundColor,
        padding: EdgeInsets.only(
            top: 0.03836 * _height,
            left: 0.0694444 * _width,
            right: 0.055555 * _width),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: const CircleAvatar(
                    backgroundColor: AppColors.AppmainColor,
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.white,

                    ),
                  ),
                ),
                SizedBox(
                  width: 0.22222 * _width,
                ),
                const Center(
                  child: Text(
                    "Settings",
                    style: TextStyle(
                        color: Color(0xff2C2C2C),
                        fontSize: 26,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 0.063938 * _height,
            ),
            Container(
                height: 0.8333333 * _height,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: const Color(0xffD8D8D8)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: 0.012787 * _height,
                              bottom: 0.012787 * _height,
                              left: 0.027777 * _width),
                          child: GestureDetector(
                            onTap: () {
                              print("clicked");
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/Shield.png"),
                                SizedBox(
                                  width: 0.055555 * _width,
                                ),
                                const Text(
                                  "Privacy Policies",
                                  style: TextStyle(
                                      color: Color(0xff2C2C2C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Color(0xffD8D8D8),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 0.012787 * _height,
                              bottom: 0.012787 * _height,
                              left: 0.027777 * _width),
                          child: GestureDetector(
                            onTap: () {
                              print("clicked");
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/Add_User.png"),
                                SizedBox(
                                  width: 0.055555 * _width,
                                ),
                                const Text(
                                  "Share App",
                                  style: TextStyle(
                                      color: Color(0xff2C2C2C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Color(0xffD8D8D8),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 0.012787 * _height,
                              bottom: 0.012787 * _height,
                              left: 0.027777 * _width),
                          child: GestureDetector(
                            onTap: () {
                              print("clicked");
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/Support_Icon.png"),
                                SizedBox(
                                  width: 0.055555 * _width,
                                ),
                                const Text(
                                  "Customer Care",
                                  style: TextStyle(
                                      color: Color(0xff2C2C2C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Color(0xffD8D8D8),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 0.012787 * _height,
                              bottom: 0.012787 * _height,
                              left: 0.027777 * _width),
                          child: GestureDetector(
                            onTap: () {
                              print("clicked");
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/images/User.png"),
                                SizedBox(
                                  width: 0.055555 * _width,
                                ),
                                const Text(
                                  "Manage Account",
                                  style: TextStyle(
                                      color: Color(0xff2C2C2C),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                          color: Color(0xffD8D8D8),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Divider(
                          thickness: 1,
                          color: Color(0xffD8D8D8),
                        ),
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.only(top: 0.010230*_height, bottom: 0.010230*_height),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "Log Out",
                              style: TextStyle(
                                  color: Color(0xffD13639),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
