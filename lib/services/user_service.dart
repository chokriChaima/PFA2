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

  CollectionReference getMenusCollection(){
    return database.collection("menus");
  }

  CollectionReference getNutritionistCollection(){
    return database.collection("nutritionist");
  }

  CollectionReference getDirectorsCollection(){
    return database.collection("directors");
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

  Future<DocumentSnapshot<Object?>> getUserNutritionist() async{
   return await  getNutritionistCollection()
    .doc(user!.uid)
    .get();
  }

  Future<DocumentSnapshot<Object?>> getUserDirector() async{
    return await getDirectorsCollection()
    .doc(user!.uid)
    .get();
  }

  Future<bool> isStudent() async{
    var dataStudent = await getUserStudent() ;
    if(dataStudent.exists){
      return true;
    }
    else {
      return false ;
    }
  }

  Future<bool> isTeacher() async{
    var dataTeacher = await getUserTeacher() ;
    if(dataTeacher.exists){
      return true;
    }
    else {
      return false ;
    }
  }

  Future<bool> isNutritionist() async {
    var dataNutritionist = await getUserNutritionist() ;
    if(dataNutritionist.exists){
      return true;
    }
    else {
      return false ;
    }
  }

  Future<bool> isDirector() async{
    var dataDirector = await getUserDirector();
    if(dataDirector.exists){
      return true ;
    }
    else{
      return false ;
    }
  }


  // work in progress
  Future<String> getUserType() async {
     bool check = await isNutritionist() ;
     if(check){
       return "nutritionist" ;
     }
     else {
       check = await isStudent();
       if(check){
         return "student";
       }
       else {
         check = await isTeacher();
         if(check){
            return "teacher";
         }
         else {

           check = await isDirector();
           if(check){
              return "director";
           }
           else {
              return "undefined";
           }
         }
       }
     }
  }
}