import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

import '../models/ticket.dart';

class TicketService{

  UserService userService;
  TicketService({required this.userService});
  
  Future<bool?> isExistTicket() async{
    await getTicket()
    .then((value) {
      if(value.exists){
        return true ;
      }
      else {
        return false ;
      }
      
    });
  }
  
  Future<void> updateTicket(int value)async{

    var data = await getTicket();
    Ticket updateTicket = Ticket.fromMap(data);
    updateTicket.setTicketValue(value);
    createTicket(updateTicket);
  } 
  
   Future<void> createTicket(Ticket ticket) async 
  {
    await userService.getTicketsCollection()
    .doc(userService.user!.uid)
    .set(ticket.toMap());
    Fluttertoast.showToast(msg: "Your purchase is complete") ;
  }

  Future<DocumentSnapshot<Object?>> getTicket() async{
    
    return await userService.getTicketsCollection()
    .doc(userService.user!.uid)
    .get() ;
  }

  
}