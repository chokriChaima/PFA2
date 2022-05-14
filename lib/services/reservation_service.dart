import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfa2_mobile_app/models/reservation.dart';
import 'package:pfa2_mobile_app/models/ticket.dart';
import 'package:pfa2_mobile_app/services/ticket_service.dart';
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
    String userType = await userService.getUserType();

    TicketService ticketService = TicketService(userService: userService);
    var data = await ticketService.getTicket();

    
    if(data.exists && Ticket.fromMap(data).purchasedTickets>0){
      
      if(userType == "student"){
        await makeReservationStudent(reservation);
      }
      else if (userType =="teacher")
      {
        await makeReservationTeacher(reservation);
      }
      ticketService.updateTicket(-1, data);
      Fluttertoast.showToast(msg: "Done, we hope you enjoy today's meal") ;
    }
    else {
      Fluttertoast.showToast(msg: "You dont have enough tickets") ;
    }
  
    

    
    
    
  }

    Future<void> makeReservationStudent(Reservation reservation) async{
    await userService
    .getStudentsCollection()
    .doc(userService.user!.uid)
    .collection("reservations")
    .add(reservation.toMap());
  }

  Future<void> makeReservationTeacher(Reservation reservation) async{
    await userService
    .getTeachersCollection()
    .doc(userService.user!.uid)
    .collection("reservations")
    .add(reservation.toMap());
  }

  Future<String?> getStudentReservationDocumentID(index) async{
    var data = await getReservationsStudent();
    return data.docs[index].id; 
  }
  Future<void> deleteReservationStudent(int index) async {

    TicketService ticketService =  TicketService(userService: userService);
    var ticketData = await ticketService.getTicket();

    var dataID = await getStudentReservationDocumentID(index);
    await userService
    .getStudentsCollection()
    .doc(userService.user!.uid)
    .collection("reservations")
    .doc(dataID)
    .delete();

    ticketService.updateTicket(1, ticketData);
  }
    

}