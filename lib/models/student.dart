import 'package:pfa2_mobile_app/models/client.dart';

class Student extends Client{
  String? studentUID;
  String? major;
  String? education ;

  // constuctor
  Student(String? userName, String? gendre, String? email, String? password,{this.studentUID,this.major, this.education}): super(email: email,gender: gendre, password: password,userName: userName);

  // getting data from server
  factory Student.fromMap(map)
  {
    return Student(
      map['userName'],
      map['gender'],
      map['email'],
      map['password'],
      studentUID: map['studentUID'], 
      major:  map['major'],
      education:  map['education'],
 
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
      "userName": userName, 
    };
  }

}