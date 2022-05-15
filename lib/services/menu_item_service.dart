import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

class MenuItemService{

  String staticMenuId = "MenuID";
  UserService userService;
  MenuItemService({required this.userService});

  Future<void> updateReservationNumber(String menuItemID,int value) async{
    await userService
    .getMenusCollection()
    .doc(staticMenuId)
    .collection("menuItems")
    .doc(menuItemID)
    .update({
      'maxReservationNumber': value
    });

  }
  // get menu item via a static id
  Future<DocumentSnapshot<Object?>> getMenuItem() async{
    return await userService
    .getMenusCollection()
    .doc(staticMenuId)
    .collection("menuItems")
    .doc("menuItemID")
    .get();
  }

  DateTime getCurrentDate(){
    DateTime _now = DateTime.now();
    return DateTime(_now.year,_now.month,_now.day);
  }
  // get menuItems for a specific date
  Future<QuerySnapshot<Object?>> getMenuItemByDate() async{
    return await userService
    .getMenusCollection()
    .doc(staticMenuId)
    .collection("menuItems")
    .where('availabilityDate',isEqualTo:  getCurrentDate())
    .get();
  }
}