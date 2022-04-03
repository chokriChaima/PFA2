import 'package:pfa2_mobile_app/models/client.dart';

class Student extends Client{
  String? studentUID;
  String? major;
  String? education ;
  String? studentIdentity;


  // constuctor
  Student(String? userName, String? gendre, String? email, String? password,{this.studentUID,this.major, this.education, this.studentIdentity}): super(email: email,gender: gendre, password: password,userName: userName);

  // getting data from server
  factory Student.fromMap(map)
  {
    return Student(
      map['userName'],
      map['gendre'],
      map['email'],
      map['password'],
      studentUID: map['studentUID'], 
      major:  map['major'],
      education:  map['education'],
      studentIdentity: map['studentIdentity'],
    );
  }

  // sending data to server
  Map<String, dynamic> toMap()
  {
    return {
      "studentUID": studentUID, 
      "education":  education,
      "email":  email,
      "gender": gender,
      "major":  major,
      "password":  password,
      "studentIdentity": studentIdentity,
      "userName": userName, 
    };
  }

}