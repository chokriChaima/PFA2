
import 'menu_item.dart';

class Menu{
 
 List<MenuItem> menuItems ;
  bool isVerified; 
  int maxMenuItem ;
  String menuTitle ;
   

  Menu({required this.maxMenuItem,required this.menuTitle,required this.isVerified, this.menuItems = const []});

  

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