class Reservation {

  String? reservationUID ;
  int? partyNumber ;

  // constructor 
  Reservation({this.reservationUID,this.partyNumber});

  // getting data from server
  factory Reservation.fromMap(map)
  {
    return Reservation(
      reservationUID :map ['reservationUID'],
      partyNumber : map['partyNumber'],
    );
  } 

  // sending data to server 
  Map<String, dynamic> toMap()
  {
    return {
      "reservationUID" : reservationUID ,
      "partyNumber"    : partyNumber,
    };
  }
}