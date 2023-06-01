// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';

import '../Helper/constants.dart';
import '../services/messagebackend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String uid='avaaff';
  String doctorid='70VjbOH7x0NBUneRNJZZ';
  late FirebaseBackend firebasebac;

  TextEditingController message = TextEditingController();

  onpressedsend(){
    FocusScope.of(context).unfocus();
    String essay=message.text ;
    message.clear();
    print(essay);
    if(essay.length!=0){
      firebasebac.uploadMessage(uid, doctorid, essay,null);
    }

  }

  onpressedImage(){
    setState(() {
      firebasebac.getImagefromgalery(uid, doctorid);
    });

  }

  onpressedcamera(){
    setState(() {
      firebasebac.getImagefromcamera(uid, doctorid);
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebasebac=FirebaseBackend(uid,doctorid);
  }
  @override
  Widget build(BuildContext context) {
    var _padding = MediaQuery.of(context).padding;
    double _width = (MediaQuery.of(context).size.width);
    double _height =
        (MediaQuery.of(context).size.height) - _padding.top - kToolbarHeight;
    double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(

        backgroundColor: AppColors.AppmainColor,
        leading: InkWell(
          onTap: () {},
          child: Row(
            children: const [
              CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.AppmainColor,
                  )),
            ],
          ),
        ),
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
              ),
              child: const CircleAvatar(
                foregroundImage: AssetImage("assets/images/Doctor.jpg"),
                radius: 17,
              ),
            ),
            SizedBox(
              width: 0.0111111 * _width,
            ),
            const DefaultTextStyle(
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                child: Text(
                  "Dr. Ram Singh",
                )),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.videocam,
                color: Colors.white,
                size: 24,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.phone,
                color: Colors.white,
                size: 23,
              )),
        ],
      ),
      body: Stack(
        children: [

          Container(
            margin: EdgeInsets.only(bottom: 30),
            height: 75*_height,
            child: StreamBuilder(
                stream:firebasebac.getMessages() ,

                builder:(context, snapshot){
                  // print(snapshot.data!);
                 dynamic Listmessage=snapshot.data;
                 if(Listmessage==null){
                   return Container();
                 }
                 // print(Listmessage.docs[0].data()!['message']);






                  return  ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: Listmessage.docs.length,
                    itemBuilder: (context,index){
                      dynamic data=Listmessage.docs[index].data()!;
                      return buildMessage(Listmessage:  data ,width:.6 *_width,ismine: (uid==data["idfrom"])?true:false,);
                    },




                  );

                }

            ),
          ),
          //

          Positioned(
            bottom: 0,
            left: 0,
            // top: _height/2,
            width: _width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _width-50,
                  child: Card(
                    //margin: EdgeInsets.only(left: 0.005555*_width, right: 0.005555*_width, bottom: 0.010230*_height),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(

                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.center,
                      // maxLength: 30,
                      controller: message,

                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Type a message",
                        hintStyle: const TextStyle(
                          color: Color(0xffD5DDF3),
                        ),
                        // contentPadding: EdgeInsets.all(5),
                        alignLabelWithHint: true,
                        suffixIconConstraints: BoxConstraints(
                          minWidth: 2,
                          minHeight: 2,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed:onpressedImage ,
                                icon: const Icon(
                                  Icons.attach_file,
                                  color: Color(0xffD5DDF3),
                                  size: 30,
                                )),
                            IconButton(
                                onPressed: onpressedcamera ,
                                icon: const Icon(Icons.camera_alt,
                                    color: Color(0xffD5DDF3), size: 30)),
                          ],
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.emoji_emotions_outlined,
                              color: Color(0xffD5DDF3), size: 30),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onpressedsend,
                  icon: const Icon(Icons.send,
                    color: Color(0xffD5DDF3),size: 35, ),
                ),
              ],
            ),
          ),



          // for chat
        ],
      ),
    );
  }
}

class buildMessage extends StatelessWidget {
  buildMessage({
    Key? key,
    required this.Listmessage,
    this.ismine=true,
    // required this.index,
    required this.width
  }) : super(key: key);

  final dynamic Listmessage;
  final bool ismine;
  // final int index;
  double width;

  @override
  Widget build(BuildContext context) {
    bool chat=Listmessage['messagechat'];
    print(Listmessage);
    return (chat==true)?ChatWidget(context):ImageWidget();
  }


  Widget ChatWidget(BuildContext context) {
    String message= Listmessage['message'];
    return Align(
      alignment: ismine?Alignment.topRight:Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(20),
        // width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.AppmainColor
        ),
        child: Text(message,style: TextStyle(fontSize: 18),),
      ),
    );
  }

  Widget ImageWidget(){
  String? imageurl=Listmessage['Imageurl'];
    return Align(
      alignment: ismine?Alignment.topRight:Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.all(10),
        width: width,
        height: width*0.8,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image:  NetworkImage(imageurl!),
            fit: BoxFit.fill
          ),
          color:Colors.green,
        ),

        // child: Image(image: NetworkImage(imageurl!),)
      ),
    );
  }

}
