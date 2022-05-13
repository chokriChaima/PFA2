import 'package:pfa2_mobile_app/models/client.dart';

class Staff extends Client{
  String? staffUID ;
  String? workPlace ;
  bool? isAdministrative ;

  Staff(String? userName, String? gendre, String? email, String? password,{this.staffUID,this.workPlace,this.isAdministrative}): super(email: email,gender: gendre, password: password,userName: userName);

  // getting data from server
  factory Staff.fromMap(map)
  {
    return Staff(
      map['userName'],
      map['gendre'],
      map['email'],
      map['password'],
      staffUID: map['staffUID'], 
      isAdministrative:  map['isAdministrative'],
      workPlace:  map['workPlace'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap()
  {
    return {
      "staffUID": staffUID, 
      "work place":  workPlace,
      "administration" : isAdministrative,
      "email":  email,
      "gender": gender,
      "password":  password,
      "userName": userName, 
    };
  }
}