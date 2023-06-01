
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}
class Message{
  final String idfrom;
  final String idto;
  String? message;
  final String createdAt;
  bool messagechat;
  String? Imageurl;

  Message({
    required this.idfrom,
    required this.idto,
    required this.message,
    required this.createdAt,
    this.messagechat=true,
    this.Imageurl,
  });


  Map<String,dynamic> ToJson(){
     if(messagechat==true){
       return {
          'messagechat':true,
         'idfrom': idfrom,
         'idto':idto,
         'message': message,
         'createdAt': createdAt,
         'Imageurl':null,

       };
     }
     else{
       return {
         'messagechat':false,
         'idfrom': idfrom,
         'idto':idto,
         'message': null,
         'createdAt': createdAt,
         'Imageurl':Imageurl!,

       };
     }
   }


}