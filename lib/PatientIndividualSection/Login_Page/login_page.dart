// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_new, unused_field, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_import, avoid_unnecessary_containers, unused_local_variable, import_of_legacy_library_into_null_safe, prefer_final_fields, use_key_in_widget_constructors, must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Helper/circle_painter.dart';
import '../Helper/rounded_rectangle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> Country_code = [
    'assets/images/India.png',
    'assets/images/India2.png',
    // 'assets/images/Am.png',
  ];
  String selectedItem = 'assets/images/India2.png';
  String selected_ccode = "91";
  //Image selectedImage = Image.asset('assets/images/USA.png');

  int phoneno=-1;
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);
    return Scaffold(
      backgroundColor: const Color(0xFFfbfcff),
      body: Stack(
        children: [
          CustomPaint(
            size: Size(width, height),
            painter: CirclePainter(),
          ),
          CustomPaint(
            size: Size(0.7805 * width, 0.476982 * height),
            painter: RoundedRectangle(),
          ),
          Positioned(
            left: 0.216666 * width,
            top: 0.088235 * height,
            child: SizedBox(
              width: 0.5666666 * width,
              child: const Text(
                "AURIGACARE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                  // height: ,
                ),
              ),
            ),
          ),
          Positioned(
              left: 0.16111111 * width,
              top: 0.15984 * height,
              child: SizedBox(
                width: 0.675 * width,
                child: const Text(
                  "24/7 Video consultations,\n  exclusively on app",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFFfbfcff),
                  ),
                ),
              ),),
          Positioned(
              left: 0.25833 * width,
              top: 0.30434 * height,
              child: SizedBox(
                width: 0.4861111 * width,
                child: const Text(
                  "Enter your phone\n number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: Color(0xff2c2c2c),
                  ),
                ),
              )),
          Positioned(
            left: 0.1916666 * width,
            top: 0.413043 * height,
            child: Container(
              width: 0.61388 * width,
              child: const Text(
                "Use the phone number to\n register or login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.1916666 * width,
            top: 0.4961636 * height,
            child: Container(
              width: 0.613888 * width,
              height: 0.0421994 * height,
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffebebeb)),
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xfff9fafb),),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 0.045248 * 0.613888 * width,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedItem,
                        elevation: 0,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onChanged: (newValue) {
                          setState(() {
                            selectedItem = (newValue) as String;
                          });
                        },
                        items: Country_code.map((country) {
                          return DropdownMenuItem(
                              value: country,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: Image.asset(country),
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.only(left: 0.0678733 * 0.613888 * width),
                    child: Text(
                      "+$selected_ccode",
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        color: Color(0xff2c2c2c),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 0.02557 * 0.613888 * width,),
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      width: 0.416289 * 0.613888 * width,
                      height: 0.6363636 * 0.4961636 * height,
                      child: TextField(
                        onChanged: (value){
                          setState(() {
                            if(value=='0'){

                            }
                            else{
                              phoneno=int.parse(value);
                            }

                          });

                          print(value);
                          print(phoneno);
                        },
                        maxLines: 1,
                        minLines: 1,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFfbfcff))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFfbfcff))),
                          hintText: "Enter number",
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            color: Color(0xffB0B0B0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0.1944444 * width,
            top: 0.5754475 * height,
            child: TextButton(
              onPressed: () {
                // if(phoneno>=1000000000){
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage2(phoneno: phoneno,)));
                // }


              },
              style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff42ccc3),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(27.5),),),
                  side: const BorderSide(color: Color(0xffebebeb), width: 1),
                  padding: EdgeInsets.fromLTRB(0.25277777 * width,
                      0.014066 * height, 0.25277777 * width, 0.014066 * height),
                  // minimumSize: const Size(221, 55),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center),
              child: const Text(
                "NEXT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
