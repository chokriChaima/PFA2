import 'package:flutter/foundation.dart';

class Menu{
  // may later add a list depending.
  bool? isVerified; 
  int maxMenuItem ;
  String menuTitle ;
  Menu({required this.maxMenuItem,required this.menuTitle,this.isVerified});

  factory Menu.fromMap(map){
    return Menu(
      maxMenuItem: map['maxMenuItem'],
      menuTitle: map['menuTitle'],
      isVerified: map['isVerified']
    );
  }

  Map <String,dynamic> toMap(){
    return{
      "maxMenuItem": maxMenuItem,
      "menuTitle": menuTitle,
      "isVerified": isVerified,
    };
  }
}