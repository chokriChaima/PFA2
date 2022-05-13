import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

import '../models/ticket.dart';

class TicketService{

  UserService userService;
  TicketService({required this.userService});
  

  // get ticket 
  Future<DocumentSnapshot<Object?>> getTicket() async{
    return await userService.getTicketsCollection()
    .doc(userService.user!.uid)
    .get() ;
  }

  // add ticket 
  Future<void> createTicket(Ticket ticket) async 
  {
    await userService.getTicketsCollection()
    .doc(userService.user!.uid)
    .set(ticket.toMap());
    Fluttertoast.showToast(msg: "Your purchase is complete") ;
  }

  /*Future<bool> isExistTicket() async{
    DocumentSnapshot<Object?> data = await getTicket() ;
    return data.exists ;
  }*/
  
  Future<void> updateTicket(int value,DocumentSnapshot<Object?> data)async{

    
    Ticket updateTicket = Ticket.fromMap(data);
    updateTicket.setTicketValue(updateTicket.getTicketValue()+value);
    createTicket(updateTicket);
  } 
  
   

  

  
}