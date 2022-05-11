import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfa2_mobile_app/models/student.dart';

import '../models/teacher.dart';

class UserService{

  User? user ; 
  FirebaseFirestore database ;
  
 UserService({ required this.database,  this.user}) ;
   
  CollectionReference getTicketsCollection(){
    return database.collection("tickets");
  }
  
  Future<DocumentSnapshot<Object?>> getUserTeacher() async{
    CollectionReference teachersCollection = database.collection("teachers");
    return await 
    teachersCollection
    .doc(user!.uid)
    .get();
  }

  Future<DocumentSnapshot<Object?>> getUserStudent() async{
   CollectionReference teachersCollection = database.collection("students");
   return await  teachersCollection
    .doc(user!.uid)
    .get();
  }

  Future<String> getUserType() async {
     var dataStudent = await getUserStudent() ;
     if(dataStudent.exists){
       return "student" ;
     }
     else {
       return "teacher" ;
     }
  }
}