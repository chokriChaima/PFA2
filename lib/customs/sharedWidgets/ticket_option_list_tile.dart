import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/BigText.dart';
import 'package:pfa2_mobile_app/services/ticket_service.dart';

import '../../models/ticket.dart';
import '../../services/user_service.dart';
class TicketOptionListTime extends StatelessWidget {
  final int ticketValue ;
  final double ticketPrice ;
  TicketOptionListTime(this.ticketValue, this.ticketPrice, {Key? key}) : super(key: key) ;

  UserService userService = UserService( database: FirebaseFirestore.instance, user: FirebaseAuth.instance.currentUser );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BigText(text: '$ticketValue Tickets',fontweight: FontWeight.w500,size: 18,),
      trailing: TextButton(onPressed: () {
         manageTickets(ticketValue);
      }, 
      
      
      child: Text('$ticketPrice TDN', ),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: AppColors.mainColor,
        minimumSize: Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ))
      ),
    );
  }

  void manageTickets(int value) async{
    TicketService ticketService = new TicketService(userService: userService);

      bool? isExist = await ticketService.isExistTicket();
      if(isExist!){
       await ticketService.updateTicket(value);
      }
      else{
        Ticket ticket = Ticket(expirationDate: DateTime.now().add(const Duration (days:30) ), purchasedTickets: ticketValue);
        await ticketService.createTicket(ticket);
      }
        
  }
}