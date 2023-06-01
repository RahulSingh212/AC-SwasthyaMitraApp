import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<List<String>> _details = [
    ['Gender', 'Gender'],
    ['Blood Group', 'Blood Group'],
    ['Height', 'Height'],
    ['Allergies', 'Allergies'],
    ['Medication', 'Medication'],
    ['Injuries', 'Injuries'],
    ['Surgeries', 'Surgeries'],
  ];

  String name = "Neha Bhardwaaj";
  String number = "+91 9876745645";

  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    return Scaffold(
      backgroundColor: const Color(0xFFfbfcff),
      body: Stack(
        children: [
          Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: _width,
                height: 0.32608 * _height,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: RadialGradient(
                        colors: const [Color(0xff01839d), Color(0xd642ccc3)],
                        radius: 2.06361*(_width/_height),
                        //focal: Alignment(0.7, -0.7),
                        //tileMode: TileMode.clamp,
                      )),
                ),
              )),
          Positioned(
            top: 0.03836 * _height,
            left: 0.05555 * _width,
            width: 0.8888888 * _width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      print("Back Pressed");
                    });
                  },
                  icon: SvgPicture.asset('assets/images/Arrow.svg'),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      print("Setting Pressed");
                    });
                  },
                  icon: SvgPicture.asset('assets/images/Settings.svg'),
                )
              ],
            ),
          ),
          Positioned(
            width: _width,
            top: 0.03836 * _height,
            child: Container(
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/images/Profile.svg'),
            )
          ),
          Positioned(
            top: 0.23529 * _height,
            width: _width,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                name,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.26470 * _height,
            width: _width,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                number,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  color: Color(0xffffffff),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.33608 * _height,
            child: SizedBox(
              height: 0.67392 * _height,
              width: _width,
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 0.05115 * _height),
                scrollDirection: Axis.vertical,
                itemCount: _details.length,
                // shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: _width,
                    height: 0.10358 * _height,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 0.05555 * _width, right: 0.05555 * _width),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _details[index][0],
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff2c2c2c),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                                hintText: _details[index][1],
                                hintStyle: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff6C757D),
                                ),
                                border: UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffD8D8D8)),
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
