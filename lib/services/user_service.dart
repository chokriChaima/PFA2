import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserService{

  User? user ; 
  FirebaseFirestore database ;
  
 UserService({ required this.database,  this.user}) ;
   
  CollectionReference getTicketsCollection(){
    return database.collection("tickets");
  }
  CollectionReference getStaffCollection(){
    return database.collection("staff");
  }

  CollectionReference getTeachersCollection(){
    return database.collection("teachers");
  }

  CollectionReference getStudentsCollection(){
    return database.collection("students");
  }


  Future<DocumentSnapshot<Object?>> getUserTeacher() async{
    return await 
    getTeachersCollection()
    .doc(user!.uid)
    .get();
  }

  Future<DocumentSnapshot<Object?>> getUserStudent() async{

   return await  getStudentsCollection()
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