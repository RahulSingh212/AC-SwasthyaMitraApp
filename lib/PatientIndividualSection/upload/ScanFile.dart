// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
// ignore_for_file: unused_import, unused_field, unused_element, deprecated_member_use

import 'dart:io';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class Scanfile extends StatefulWidget {
  const Scanfile({Key? key}) : super(key: key);

  @override
  _ScanfileState createState() => _ScanfileState();
}

class _ScanfileState extends State<Scanfile> {
  File? image;
  late File _storedImage;
  late DateTime _picTiming;
  late var _savedImageFilePath;

  Future<void> _takePicture(BuildContext context) async {
    _picTiming = DateTime.now();
    print(_picTiming);
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 480,
      maxWidth: 640,
    );

    if (imageFile == null) {
      String titleText = "Camera Application Turned Off";
      String contextText = "Please Re-Try Again!";
      _checkForError(context, titleText, contextText);
      // setState(() {
      //   _isFloatingButtonActive = true;
      //   _isSpinnerLoading = false;
      // });
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final _savedImageFile =
    await File(imageFile.path).copy('${appDir.path}/${fileName}');

    _savedImageFilePath = _savedImageFile.toString();
  }


  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}






// class Scanile {
//
//
//   Future getImagefromcamera(String userid,String doctorid) async {
//     ImagePicker  imagetake=ImagePicker();
//     XFile? pickedFile=await imagetake.pickImage(source: ImageSource.camera);
//     if(pickedFile != null){
//
//       image = File(pickedFile.path);
//       print(image );
//       if(image!=null){
//
//
//         //TODO puchana ha unsa ki la ya na la es ko
//
//
//         await uploadImage(userid,doctorid);
//
//
//
//
//
//       }
//       else{
//         print("""abscjd
//         hjhjhjcgcgjcjgcgjcgjcg
//         sbvvvvjhv
//         sdjvcdvdcvc
//         dscvudlvy""");
//       }
//     }
//     else{
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//       print("hvvhjcjgcghfxhxhxxgxhxkhxx");
//     }
//
//   }
//   Future uploadImage(String userid,String doctorid) async {
//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     var reference=FirebaseStorage.instance.ref().child(fileName);
//     if(reference==null){
//       print("""Reference
//         hjhjhjcgcgjcjgcgjcgjcg
//         sbvvvvjhv
//         sdjvcdvdcvc
//         Reference""");
//     }
//     UploadTask uploadTask= reference.putFile(image!);
//     TaskSnapshot snapshot = await uploadTask;
//     String imageUrl = await snapshot.ref.getDownloadURL();
//     print(imageUrl);
//
//
//   }
//
//
//
//
//
//


//   // ),
//   // ),
//
// }
//

