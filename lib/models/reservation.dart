class Reservation {

  bool? isLunch ;
  //String? reservationID ;
  int? partyNumber ;


  // constructor 
  Reservation({this.isLunch,this.partyNumber,/*this.reservationID*/});

  // getting data from server
  factory Reservation.fromMap(map)
  {
    return Reservation(
      //reservationID: map['reservationID'],
      isLunch: map['isLunch'],
      partyNumber : map['partyNumber'],
    );
  } 

  // sending data to server 
  Map<String, dynamic> toMap()
  {
    return {
     // "reservationID" : reservationID,
      "isLunch" : isLunch ,
      "partyNumber"    : partyNumber,
    };
  }
}