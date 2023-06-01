import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../providers/patientUser_details.dart';

class BMI extends StatefulWidget {
  BMI({
    Key? key,
    required double width,
    required double height,
  })  : _width = width,
        _height = height,
        super(key: key);

  final double _width;
  final double _height;

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  bool isLangEnglish = true;
  double height = 180.0;
  double weight = 64;
  String blood_grp = "AB";
  Map<String, String> mp = {};

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<PatientUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    mp = Provider.of<PatientUserDetails>(context)
        .getPatientUserPersonalInformation();

    String hs = mp['patient_Height'].toString();
    String ws = mp['patient_Weight'].toString();
    height = checkIfDouble(hs)/100.0;
    weight = checkIfDouble(ws);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.0135 * widget._height),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        border: Border.all(
          width: 1,
          color: Color(0xffffffff),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.only(
          left: 0.035555 * widget._width,
          right: 0.035555 * widget._width,
          top: 0.01571739130434783 * widget._height),
      width: 0.7988888 * widget._width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //BMI
              SizedBox(
                  width: 130 * 0.00277777778 * widget._width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isLangEnglish ? "BMI" : "बीएमआई",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 12 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff4c465a),
                              // height: ,
                            ),
                          ),
                          Image(image: AssetImage("assets/images/BMI.png"))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (weight / (height * height)).toStringAsFixed(2),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff2c2c2c),
                              // height: ,
                            ),
                          ),
                          Text(
                            " kg/m²",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xFF757575),
                              // height: ,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                width: 10 * 0.00277777778 * widget._width,
              ),
              //BLOOD
              SizedBox(
                width: 130 * 0.00277777778 * widget._width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isLangEnglish ? "BLOOD" : "खून",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 12 * (0.035 / 15) * widget._width,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff4c465a),
                            // height: ,
                          ),
                        ),
                        Image(image: AssetImage("assets/images/Blood.png"))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          blood_grp,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 20 * (0.035 / 15) * widget._width,
                            fontStyle: FontStyle.normal,
                            color: Color(0xff2c2c2c),
                            // height: ,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10 * 0.00135869565 * widget._height,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //HEIGHT
              SizedBox(
                  width: 130 * 0.00277777778 * widget._width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isLangEnglish ? "HEIGHT" : "कद",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 12 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff4c465a),
                              // height: ,
                            ),
                          ),
                          Image(image: AssetImage("assets/images/Height.png"))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            (height * 100).toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff2c2c2c),
                              // height: ,
                            ),
                          ),
                          Text(
                            " cm",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xFF757575),
                              // height: ,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                width: 10 * 0.00277777778 * widget._width,
              ),
              //WEIGHT
              SizedBox(
                  width: 130 * 0.00277777778 * widget._width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isLangEnglish ? "WEIGHT" : "वज़न",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 12 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff4c465a),
                              // height: ,
                            ),
                          ),
                          Image(image: AssetImage("assets/images/Weight.png"))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            weight.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20 * (0.035 / 15) * widget._width,
                              fontStyle: FontStyle.normal,
                              color: Color(0xff2c2c2c),
                              // height: ,
                            ),
                          ),
                          Text(
                            " kg",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              color: Color(0xFF757575),
                              // height: ,
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  int checkIfInteger(String val) {
    if (val == 'null' || val == '' || int.tryParse(val).toString() == 'null') {
      return 0;
    } else {
      return int.parse(val);
    }
  }

  double checkIfDouble(String val) {
    if (val == 'null' ||
        val == '' ||
        double.tryParse(val).toString() == 'null') {
      return 0.0;
    } else {
      return double.parse(val);
    }
  }
}
