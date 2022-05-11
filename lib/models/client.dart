import 'package:pfa2_mobile_app/models/ticket.dart';

abstract class Client{
  String? userName ;
  String? email;
  String? password;
  String? gender;
  Ticket? ticket ;
  //constructor
  Client({this.email,this.gender,this.password,this.userName});

  
}