import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import './models/message.dart';

class FirebaseBackend {
  late String groupChatId;

  File? image;

  getdateTime(String time) {
    return DateTime.parse(time);
  }

  FirebaseBackend(String useridId, String doctorid) {
    getchatiud(useridId, doctorid);
  }

  getchatiud(String useridId, String doctorid) {
    userexistornot(useridId);
    if (useridId.hashCode <= doctorid.hashCode) {
      groupChatId = '$useridId-$doctorid';
    } else {
      groupChatId = '$doctorid-$useridId';
    }
  }

  final _firestore = FirebaseFirestore.instance;

// Uplooad message and image
  Future uploadMessage(
      String userid, String doctorId, String? message, String? ImageUrl) async {
    String x = DateTime.now().millisecondsSinceEpoch.toString();
    final getmessagecollection =
        _firestore.collection('chats/$groupChatId/messages/').doc('$x');
    bool chat = true;
    if (message == null) {
      chat = false;
    } else {
      chat = true;
    }
    print(chat);
    var newmessage = Message(
        idfrom: userid,
        idto: doctorId,
        message: message,
        createdAt: x,
        messagechat: chat,
        Imageurl: ImageUrl);

    await _firestore.runTransaction((transaction) async {
      transaction.set(getmessagecollection, newmessage.ToJson());
    });
  }

  // Getting Messages Stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() => _firestore
      .collection('chats/$groupChatId/messages')
      .orderBy(MessageField.createdAt, descending: true)
      .limit(25)
      .snapshots();

  userexistornot(String uid) async {
    // Check is already sign up
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: uid)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 0) {
      // Update data to server if new user
      FirebaseFirestore.instance.collection('users').doc(uid).set({'id': uid});
    }
  }

  Future getImagefromgalery(String userid, String doctorid) async {
    ImagePicker imagetake = ImagePicker();
    XFile? pickedFile = await imagetake.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      print(image);
      if (image != null) {
        await uploadImage(userid, doctorid);
      } else {
        print("""abscjd
        hjhjhjcgcgjcjgcgjcgjcg
        sbvvvvjhv
        sdjvcdvdcvc
        dscvudlvy""");
      }
    } else {
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
    }
  }

  Future uploadImage(String userid, String doctorid) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance.ref().child(fileName);
    if (reference == null) {
      print("""Reference
        hjhjhjcgcgjcjgcgjcgjcg
        sbvvvvjhv
        sdjvcdvdcvc
        Reference""");
    }
    UploadTask uploadTask = reference.putFile(image!);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    print(imageUrl);
    await uploadMessage(userid, doctorid, null, imageUrl);
  }

  Future getImagefromcamera(String userid, String doctorid) async {
    ImagePicker imagetake = ImagePicker();
    XFile? pickedFile = await imagetake.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      print(image);
      if (image != null) {
        await uploadImage(userid, doctorid);
      } else {
        print("""abscjd
        hjhjhjcgcgjcjgcgjcgjcg
        sbvvvvjhv
        sdjvcdvdcvc
        dscvudlvy""");
      }
    } else {
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
      print("hvvhjcjgcghfxhxhxxgxhxkhxx");
    }
  }
}

// also do changes in manufest file in app->src->main
// <manifest xmlns:android="http://schemas.android.com/apk/res/android"
// xmlns:tools="http://schemas.android.com/tools"
// package="com.example.app">
//
//
// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />