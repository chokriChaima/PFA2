class Ticket {
 int purchasedTickets = 0 ;
 DateTime? expirationDate ;
// constuctor 
Ticket({this.expirationDate,required this.purchasedTickets });

factory Ticket.fromMap(map){
  return Ticket(
    purchasedTickets: map['purchasedTickets'],
    expirationDate:   DateTime.parse(map['expirationDate'].toDate().toString())
    ,
  );
}

Map<String,dynamic> toMap(){
  return{
    "expirationDate" : expirationDate,
    "purchasedTickets" : purchasedTickets,
  };
}

setTicketValue(int value){
  purchasedTickets = value ;
}
getTicketValue(){
  return purchasedTickets ;
}

}
