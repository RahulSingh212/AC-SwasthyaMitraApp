import 'package:flutter/material.dart';

import '../Helper/constants.dart';

class PaynmentMethord extends StatefulWidget {
  const PaynmentMethord({Key? key}) : super(key: key);

  @override
  _PaynmentMethordState createState() => _PaynmentMethordState();
}

class _PaynmentMethordState extends State<PaynmentMethord> {
  bool visamethord = true;

  onchanged(bool value, int val) {
    setState(() {
      if (val == 0) {
        visamethord = true;
      } else {
        visamethord = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: CircleAvatar(
                      backgroundColor: AppColors.AppmainColor,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.white,
                        ),
                      )),
                ),
                SizedBox(
                  width: 50,
                ),
                Center(
                  child: Text(
                    "Payment Methods",
                    style: TextStyle(
                        color: Color(0xff2C2C2C),
                        fontSize: 26,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 27,
            ),
            Text(
              "Please select a payment option to complete the the process for appointment registration.",
              style: TextStyle(
                  color: Color(0xff2C2C2C),
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 22,
            ),
            paynmentContainer(
              onchanged: onchanged,
              image: "assets/images/Visa.png",
              text: "Naguten Huu Yeen",
              accountno: "**** **** **** 2445",
              otherno: "8234",
              date: "12/18",
              day: "thru",
              checkbox: visamethord,
            ),
            SizedBox(
              height: 35,
            ),
            paynmentContainer(
              isvisa: false,
              image: "assets/images/mastercard.png",
              text: "Naguten Huu Yeen",
              accountno: "**** **** **** 2445",
              otherno: "8234",
              date: "12/18",
              day: "thru",
              checkbox: !visamethord,
              onchanged: onchanged,
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.only(
                top: 12,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 20,
                    width: 22,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/otherpaynment.png"),
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    "Add a different payment method",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff929292)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 15, bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.AppmainColor),
              child: Center(
                child: Text(
                  "Pay",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class paynmentContainer extends StatelessWidget {
  String text;
  String image;
  String accountno;
  String otherno;
  String date;
  String day;
  bool isvisa;
  bool checkbox;
  Function(bool, int) onchanged;
  paynmentContainer(
      {Key? key,
      required this.text,
      required this.checkbox,
      required this.onchanged,
      required this.date,
      required this.image,
      required this.accountno,
      required this.otherno,
      required this.day,
      this.isvisa = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 15,
            right: 15,
            child: Checkbox(
              shape: CircleBorder(),
              onChanged: (value) {
                onchanged(value!, isvisa ? 0 : 1);
              },
              value: this.checkbox,
            ),
          ),
          Positioned(
              top: 20,
              left: 14,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: isvisa ? 60 : 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    accountno,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff929292)),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    otherno,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff929292)),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff929292)),
                  ),
                ],
              )),
          Positioned(
            right: 15,
            bottom: 15,
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "valid",
                      style: TextStyle(
                          fontSize: 6.23,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff929292)),
                    ),
                    Text(
                      day,
                      style: TextStyle(
                          fontSize: 6.23,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff929292)),
                    ),
                  ],
                ),
                Text(
                  date,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff929292)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
