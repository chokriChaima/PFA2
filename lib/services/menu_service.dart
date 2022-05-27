import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

import '../models/menu.dart';

class MenuService{

  UserService userService;
  MenuService({required this.userService});
  final String id_not_found = "Id not found" ;

  Future<void> addMenu(Menu menu) async{
    await userService.getMenusCollection().add(menu.toMap());
    Fluttertoast.showToast(msg: "Menu successfully created") ;
  }

  Future<QuerySnapshot<Object?>> getMenus() async{
    return await userService.getMenusCollection().get();
  }

 Future<String> getMenuId(int index) async{
    QuerySnapshot<Object?> data = await getMenus();
    if(data.docs.isNotEmpty){
      return data.docs[index].id ;
    }else {
      return id_not_found ;
    }
 }

 Future<void> updateIsVerified(int index, bool isVerified) async{
   String menuId = await getMenuId(index);
    if(menuId != id_not_found){
      await userService.getMenusCollection().doc(menuId).update({'isVerified': !isVerified});
      Fluttertoast.showToast(msg: "Menu Validate");
    }else {
      Fluttertoast.showToast( msg : "can't validate menu error : "+id_not_found);
    }
  
 }
  Future<void> deleteMenu(int index) async{
    String menuId = await getMenuId(index);
    if(menuId != id_not_found){
      await userService.getMenusCollection().doc(menuId).delete();
      Fluttertoast.showToast(msg: "Menu deleted");
    }else {
      Fluttertoast.showToast(msg: "can't delete menu error : "+id_not_found);
    }
  }
}