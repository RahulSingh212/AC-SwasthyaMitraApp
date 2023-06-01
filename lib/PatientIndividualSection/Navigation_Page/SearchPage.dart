import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Communication_Page/MessagingPage.dart';
import '../Helper/constants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    return Container(
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  height:0.27027*_height,
                  color: Color(0xff42CCC3),
                ),
              ),
              Positioned(
                  top: 0.0383631*_height,
                  left: 0.069444*_width,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.AppmainColor,
                      ))),
              Positioned(
                  top: 0.0447570*_height,
                  right: 0.069444*_width,
                  child: Icon(
                    Icons.library_add_outlined,
                    color: Colors.white,
                  )),
              Positioned(
                top: 0.046035*_height,
                left: 0.444444*_width,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.01111111*_width, color: Colors.white),
                    borderRadius: BorderRadius.circular(0.125*_width),
                  ),
                  child: CircleAvatar(
                    foregroundImage: AssetImage("assets/images/Doctor.jpg"),
                    radius: 0.111111*_width,
                  ),
                ),
              ),
              Positioned(
                  bottom: 0.070726*_height,
                  left: 0.3888*_width,
                  child: DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 24,
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold),
                      child: Text(
                        "Dr. Ram Singh",
                      ))),
              Positioned(
                  left: 0.416666*_width,
                  bottom: 0.025575*_height,
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 0.013888*_width, top: 0.006393*_width, bottom: 0.006393*_width, right: 0.013888*_width),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.016666*_width),
                    ),
                    child: Center(
                        child: DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 15, color: AppColors.AppmainColor),
                            child: Text(
                              "Diabetologist",
                            ))),
                  )),
            ],
          ),
          SizedBox(
            height: 0.0255754*_height,
          ),
          Container(
            padding: EdgeInsets.only(left: 0.055555*_width, right: 0.055555*_width),
            child: DefaultTextStyle(
                style: TextStyle(color: Color(0xff969696), fontSize: 18),
                child: Text(
                    "A trained medical practitioner for the past 12 years with expertise in Diabetes management.")),
          ),
          SizedBox(
            height: 0.0255754*_height,
          ),
          Container(
            padding: EdgeInsets.only(left: 0.055555*_width, right: 0.055555*_width),
            child: DefaultTextStyle(
                style: TextStyle(color: Color(0xff969696), fontSize: 18),
                child:
                    Text("Appointment with Dr. Ram Singh has been booked on:")),
          ),
          SizedBox(
            height: 0.0255754*_height,
          ),
          Container(
            margin: EdgeInsets.only(left: 0.055555*_width, right: 0.055555*_width),
            padding: EdgeInsets.only(top: 0.01278*_height, bottom: 0.01278*_height, left: 0.041666*_width, right: 0.041666*_width),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0.016666*_width),
                  topLeft: Radius.circular(0.016666*_width),
                  bottomLeft: Radius.circular(0.016666*_width)),
              color: CupertinoColors.white,
              border: Border.all(
                color: Color(0xffCDCDCD),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DefaultTextStyle(
                    style:
                        TextStyle(color: AppColors.AppmainColor, fontSize: 25),
                    child: Text("05:00 PM")),
                DefaultTextStyle(
                    style:
                        TextStyle(color: AppColors.AppmainColor, fontSize: 25),
                    child: Text("28th July")),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.only(top: 0.002557*_height, bottom: 0.0012787*_height, left: 0.00833333*_width, right: 0.00833333*_width),
              margin: EdgeInsets.only(left: 0.055555*_width, right: 0.055555*_width),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0.016666*_width),
                    bottomLeft: Radius.circular(0.016666*_width)),
                color: CupertinoColors.white,
                border: Border.all(
                  color: Color(0xffCDCDCD),
                ),
              ),
              child: DefaultTextStyle(
                style: TextStyle(fontSize: 12, color: Color(0xff969696)),
                child: Text("Reschedule"),
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.fromLTRB(0.055555*_width, 0.025575*_height, 0.055555*_width, 0.025575*_height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: AppColors.backgroundColor,
                        child: Icon(
                          Icons.phone,
                          color: AppColors.AppmainColor,
                        )),
                    SizedBox(
                      height: 0.010230*_height,
                    ),
                    DefaultTextStyle(
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff5F5F5F)),
                        child: Text("Voice Call"))
                  ],
                ),
                SizedBox(
                  width: 0.055555*_width,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.041666*_width,0.0191815*_height,0.041666*_width,0.0191815*_height),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.055555*_width),
                      color: AppColors.AppmainColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.videocam_outlined,
                        color: Colors.white,
                        size: 0.0777777*_width,
                      ),
                      SizedBox(
                        width: 0.055555*_width*0.5,
                      ),
                      DefaultTextStyle(
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          child: Text("Video Call"))
                    ],
                  ),
                ),
                SizedBox(
                  width: 0.055555*_width,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MessagePage()));
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: AppColors.backgroundColor,
                          child: Icon(
                            Icons.message_outlined,
                            color: AppColors.AppmainColor,
                          )),
                      SizedBox(
                        height: 0.010230*_height,
                      ),
                      DefaultTextStyle(
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff5F5F5F)),
                          child: Text("Message"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
