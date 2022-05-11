class Reservation {

  bool? isLunch ;
  int? partyNumber ;

  // constructor 
  Reservation({this.isLunch,this.partyNumber});

  // getting data from server
  factory Reservation.fromMap(map)
  {
    return Reservation(
      isLunch: map['isLunch'],
      partyNumber : map['partyNumber'],
    );
  } 

  // sending data to server 
  Map<String, dynamic> toMap()
  {
    return {
      "isLunch" : isLunch ,
      "partyNumber"    : partyNumber,
    };
  }
}