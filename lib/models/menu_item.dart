
class MenuItem{
  //String? id ;
  int? maxReservationNumber ;
  String? title;
  String? imageURL;
  DateTime? availabilityDate ;
  List<String> components ;
  bool isLunch ;

  MenuItem({required this.isLunch,this.availabilityDate,required this.components,this.maxReservationNumber,this.title,this.imageURL});

  setReservatioNumber(int value){
    maxReservationNumber = maxReservationNumber! + value;
  }
  
  // from fb
  factory MenuItem.fromMap(map){
    return MenuItem(
     // id: map['id'],
      maxReservationNumber : map['maxReservationNumber'],
      title : map['title'],
      imageURL : map['imageURL'],
      availabilityDate : DateTime.parse(map['availabilityDate'].toDate().toString()),
      // after testing return to components with a miniscule c.
      components : List.from(map['Components']),
      isLunch: map['isLunch'],
    );
  }

  Map<String,dynamic> toMap(){
    return{
      "Components" : components,
      "availabilityDate" : availabilityDate,
      "imageURL" : "",
      "isLunch" : isLunch,
      "maxReservationNumber": maxReservationNumber,
      "title" : title,
    };
  }

  // to fb
}

