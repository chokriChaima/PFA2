import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfa2_mobile_app/models/reservation.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';
class ReservationService{

  UserService userService ; 

  ReservationService({required this.userService});
    

  Future<QuerySnapshot<Object?>> getReservationsTeacher() async {
    CollectionReference teachersCollection = userService.database.collection("teachers");
    return await 
    teachersCollection
    .doc(userService.user!.uid)
    .collection("reservations") // add order later to organize
    .get();
  }

  Future<QuerySnapshot<Object?>> getReservationsStudent() async {
    CollectionReference studentsCollection = userService.database.collection("students");
    return await 
    studentsCollection
    .doc(userService.user!.uid)
    .collection("reservations") // add order later to organize
    .get();
  }

  Future<void> makeReservation(Reservation reservation) async 
  {
    CollectionReference studentsCollection = userService.database.collection("students");
    CollectionReference teachersCollection = userService.database.collection("teachers");

      await studentsCollection
      .doc(userService.user!.uid)
      .get()
      .then
      ((DocumentSnapshot documentSnapshot) async {
        if(documentSnapshot.exists){
          await studentsCollection.
          doc(userService.user!.uid)
          .collection("reservations")
          .add(reservation.toMap());
          Fluttertoast.showToast(msg: "Successful student reservation") ;
        }
        else{
          await teachersCollection
          .doc(userService.user!.uid)
          .get()
          .then(
            (DocumentSnapshot documentSnapshot) async {
            if(documentSnapshot.exists){
              await userService
              .getTeachersCollection()
              .doc(userService.user!.uid)
              .collection("reservations")
              .add(reservation.toMap());
              Fluttertoast.showToast(msg: "Successful teacher reservation") ;
            }
          });
        }
    });
    
  }

  Future<String?> getStudentReservationDocumentID(index) async{
    var data = await getReservationsStudent();
    return data.docs[index].id; 
  }
  Future<void> deleteReservationStudent(int index) async {
    var dataID = await getStudentReservationDocumentID(index);
    await userService
    .getStudentsCollection()
    .doc(userService.user!.uid)
    .collection("reservations")
    .doc(dataID)
    .delete();
  }
    

}