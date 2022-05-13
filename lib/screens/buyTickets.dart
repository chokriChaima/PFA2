import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:pfa2_mobile_app/customs/sharedElements.dart/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedWidgets/ticket_option_list_tile.dart';
import 'package:pfa2_mobile_app/models/ticket.dart';
import 'package:pfa2_mobile_app/services/ticket_service.dart';

import '../services/user_service.dart';

class BuyTickets extends StatefulWidget {
   const BuyTickets({ Key? key }) : super(key: key);
  
  @override
  State<BuyTickets> createState() => _BuyTicketsState();
}

class _BuyTicketsState extends State<BuyTickets> {
  List<TicketOptionListTime> ticketOptionList= [TicketOptionListTime(5, 2.0), 
                                                TicketOptionListTime(10, 3.5),
                                                TicketOptionListTime(15, 5.0),
                                                TicketOptionListTime(20, 7.0),
                                                TicketOptionListTime(25, 12.0),
                                                TicketOptionListTime(30, 15.0)                                              
                                              ];
  
  
  UserService userService = UserService( database: FirebaseFirestore.instance, user: FirebaseAuth.instance.currentUser );
  Ticket _currentTicket = Ticket(purchasedTickets: 0);

  @override
  void initState() {
    super.initState();
   
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCurrentTicket();
  }
  
  getCurrentTicket() async{
    TicketService ticketService = TicketService(userService: userService);
    var ticket = await ticketService.getTicket();
    if(ticket.exists){
      setState(() {
        _currentTicket = Ticket.fromMap(ticket);
      });
    }
    else{
      print("no ticket has been created for tnis user");
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold  (
      appBar: AppBar(
        title: BigText(text: "Ticket Shop"),
        leading: const BackButton(
            color : AppColors.textColor,
        ),
      ),
      body : SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              bottom:50.0,
              top: 50.0,
              left : 20,
              right :20,),
            //width: 200,
            child: Center(
              
              child: BigText(text: "Your Tickets : "+ _currentTicket.getTicketValue().toString() , fontweight: FontWeight.w500,),
            ),
          ),
          SizedBox(
            child: ListView.separated(
               scrollDirection: Axis.vertical,
               shrinkWrap: true,
               itemCount: 5,
               separatorBuilder: (BuildContext context, int index) => const Divider(),
               itemBuilder: (BuildContext context, int index) {
                 return ticketOptionList[index];
               },
             ),
          ),
        ],
              ),
      ),
    );
  }
}