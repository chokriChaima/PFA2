class Reservation {
  DateTime? date ;
  bool? isLunch ;
  //String? reservationID ;
  int? partyNumber ;


  // constructor 
  Reservation({this.date,this.isLunch,this.partyNumber,/*this.reservationID*/});

  // getting data from server
  factory Reservation.fromMap(map)
  {
    return Reservation(
      //reservationID: map['reservationID'],
      date : DateTime.parse(map['date'].toDate().toString()),
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
      "date" : date,
      "partyNumber" : partyNumber,
    };
  }
}