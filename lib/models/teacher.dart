import 'package:pfa2_mobile_app/models/client.dart';

class Teacher extends Client {

  String? teacherUID;
  String? department;
  String? workPlace;

  Teacher(String? userName, String? gendre, String? email, String? password,{this.teacherUID,this.department,this.workPlace}): super(email: email,gender: gendre, password: password,userName: userName);
  
  // getting data from server
  factory Teacher.fromMap(map)
  {
    return Teacher(
      map['userName'],
      map['gendre'],
      map['email'],
      map['password'],
      teacherUID: map['teacherUID'], 
      department:  map['department'],
      workPlace:  map['workPlace'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap()
  {
    return {
      "teacherUID": teacherUID, 
      "departement":  department,
      "workPlace":  workPlace,
      "email":  email,
      "gender": gender,
      "password":  password,
      "userName": userName, 
    };
  }

}