
class MenuItem{
  String? id ;
  int? maxReservationNumber ;
  String? title;
  String? imageURL;
  DateTime? availabilityDate ;
  List<String> components ;
  bool isLunch ;

  MenuItem({required this.isLunch,this.availabilityDate,required this.components,this.maxReservationNumber,this.id,this.title,this.imageURL});

  // from fb
  factory MenuItem.fromMap(map){
    return MenuItem(
      id: map['id'],
      maxReservationNumber : map['maxReservationNumber'],
      title : map['title'],
      imageURL : map['imageURL'],
      availabilityDate : DateTime.parse(map['availabilityDate'].toDate().toString()),
      // after testing return to components with a miniscule c.
      components : List.from(map['Components']),
      isLunch: map['isLunch'],
    );
  }

  // to fb
}

