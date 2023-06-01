import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Helper/circle_painter.dart';
import '../Helper/rounded_rectangle.dart';

class RoundedRectangle2 extends RoundedRectangle {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFfbfcff)
      ..style = PaintingStyle.fill;

    Rect rect = Rect.fromLTWH(
        0.13879 * size.width, 0.906474 * size.height, size.width, size.height);
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(17.8184)), paint);
  }
}

class LangPage extends StatefulWidget {
  const LangPage({Key? key}) : super(key: key);

  @override
  State<LangPage> createState() => _LangPageState();
}

class _LangPageState extends State<LangPage> {
  bool ispressed_eng = false;
  bool ispressed_hindi = false;
  
  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - _padding.bottom;
    double _aspect_ratio = _width/_height;
    return Scaffold(
      backgroundColor: const Color(0xFFfbfcff),
      body: Container(
        child: Stack(
          children: [
            CustomPaint(
              size: Size(_width, _height),
              painter: CirclePainter(),
            ),
            Container(
              width: _width,
              padding: EdgeInsets.only(top: 0.088235 * _height),
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
            Container(
              width: _width,
              padding: EdgeInsets.only(top: 0.159846 * _height),
              child: const Text(
                "Welcome!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                  // height: ,
                ),
              ),
            ),
            CustomPaint(
              size: Size(0.7805 * _width, 0.3554 * _height),
              painter: RoundedRectangle2(),
            ),
            Container(
              width: _width,
              padding: EdgeInsets.only(top: 0.36828 * _height),
              child: const Text(
                "Select Language",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.45012 * _height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    ispressed_eng = !ispressed_eng;
                  });
                },
                style: TextButton.styleFrom(
                    backgroundColor: ispressed_eng
                        ? const Color(0xff42ccc3)
                        : const Color(0xFFfbfcff),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(27.5))),
                    side: const BorderSide(color: Color(0xffebebeb), width: 1),
                    // padding: EdgeInsets.fromLTRB(0.208333 * _width,
                    //     0.016624 * _height, 0.205555 * _width, 0.016624 * _height),
                    minimumSize: Size(0.6138888*_width, 0.0703324*_height),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: Text(
                  "English",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: ispressed_eng
                        ? const Color(0xFFfbfcff)
                        : const Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.56393 * _height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    ispressed_hindi = !ispressed_hindi;
                  });
                },
                style: TextButton.styleFrom(
                    backgroundColor: ispressed_hindi
                        ? const Color(0xff42ccc3)
                        : const Color(0xFFfbfcff),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(27.5))),
                    side: const BorderSide(color: Color(0xffebebeb), width: 1),
                    // padding: EdgeInsets.fromLTRB(0.208333 * _width,
                    //     0.016624 * _height, 0.205555 * _width, 0.016624 * _height),
                    minimumSize: Size(0.6138888*_width, 0.0703324*_height),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
                child: Text(
                  "हिन्दी",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: ispressed_hindi
                        ? const Color(0xFFfbfcff)
                        : const Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
