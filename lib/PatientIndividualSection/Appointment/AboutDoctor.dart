import 'package:flutter/material.dart';

import '../Helper/constants.dart';

class AboutDoctor extends StatelessWidget {
  AboutDoctor({Key? key}) : super(key: key);

  List qualification = [
    "MBBS",
    "Diploma In Clinical Diabetology",
    "Fellowship In Diabetology",
    "Fellowship In Family Medicine"
  ];

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height = (MediaQuery.of(context).size.height) - _padding.top;
    return Material(
      child: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    height: _height * 0.25,
                    color: const Color(0xff42CCC3),
                  ),
                ),
                Positioned(
                  top: 0.03836 * _height,
                  width: _width,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 0.05555 * _width, right: 0.05555 * _width),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 0.08055 * _width / 2,
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.AppmainColor,
                          ),
                        ),
                        const Icon(
                          Icons.library_add_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0.109974 * _height,
                  right: 0.027777 * _width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          child: Text(
                            "Dr. Ram Singh",
                          )),
                      SizedBox(
                        height: 0.01534 * _height,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 0.013888 * _width,
                            top: 0.006393 * _height,
                            bottom: 0.006393 * _height,
                            right: 0.013888 * _width),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                            child: DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.AppmainColor),
                                child: Text(
                                  "Diabetologist",
                                ))),
                      ),
                      SizedBox(
                        height: 0.011508 * _height,
                      ),
                      const DefaultTextStyle(
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          child: Text(
                            "4.2/5 Rating",
                          ))
                    ],
                  ),
                ),
                Positioned(
                    left: 0.0555555 * _width,
                    bottom: 0,
                    child: const Image(
                      image: AssetImage("assets/images/DoctorBac.png"),
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 0.025575 * _height,
                  left: 0.0555555 * _width,
                  right: 0.0555555 * _width,
                  bottom: 0.012787 * _height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dr. Ram Singh is a trained medical practitioner for the past 12 years with expertise in Diabetes management and preventive health care.",
                    style: TextStyle(
                        color: Color(0xff929292),
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 0.023017 * _height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      charBox(text: "162", char: "Paitents"),
                      charBox(text: "10+", char: "Exp. Years"),
                      charBox(text: "4.5/5", char: "Rating"),
                    ],
                  ),
                  SizedBox(
                    height: 0.023017 * _height,
                  ),
                  const Text(
                    "Dr. Ram Singh is skilled in providing complete end to end care in the diagnosis, management, and treatment of common infections, and chronic lifestyle diseases",
                    style: TextStyle(
                        color: Color(0xff929292),
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 0.023017 * _height,
                  ),
                  const Text(
                    "Qualifications:",
                    style: TextStyle(
                        color: Color(0xff2c2c2c),
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 0.005115 * _height,
                  ),
                  Wrap(
                    children: List.generate(4, (index) {
                      return Row(
                        children: [
                          const CircleAvatar(
                            radius: 2,
                            backgroundColor: Colors.black,
                          ),
                          SizedBox(
                            width: 0.011111 * _width,
                          ),
                          Text(
                            qualification[index],
                            style: const TextStyle(
                                color: Color(0xff929292),
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class charBox extends StatelessWidget {
  String char;
  String text;
  charBox({Key? key, required this.text, required this.char}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Color(0xffEBFAF9), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(text,
              style: TextStyle(
                  color: AppColors.AppmainColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24)),
          SizedBox(
            height: 2,
          ),
          Text(char,
              style: TextStyle(
                  color: Color(0xff929292),
                  fontWeight: FontWeight.w500,
                  fontSize: 12))
        ],
      ),
    );
  }
}
