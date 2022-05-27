import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfa2_mobile_app/models/menu_item.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

class MenuItemService {

  String staticMenuId = "MenuID";
  String menuItems = "menuItems";
  UserService userService;
  MenuItemService({required this.userService});


  void addMultipleMenuItem(List<MenuItem> menuItemsList,String menuId) {

    for (var menuItem in menuItemsList) {
      addMenuItem(menuItem, menuId);
    }
  }
  Future<void> addMenuItem(MenuItem menuItem,String menuId) async {
    await userService
        .getMenusCollection()
        // this will become dynamic
        .doc(menuId)
        .collection(menuItems)
        .add(menuItem.toMap());
  }

  Future<void> updateReservationNumber(String menuItemID, int value) async {
    await userService
        .getMenusCollection()
        .doc(staticMenuId)
        .collection("menuItems")
        .doc("menuItemID")
        .update({'maxReservationNumber': value});
  }

  // get menu item via a static id
  Future<DocumentSnapshot<Object?>> getMenuItem() async {
    return await userService
        .getMenusCollection()
        .doc(staticMenuId)
        .collection("menuItems")
        .doc("menuItemID")
        .get();
  }


  DateTime getCurrentDate() {
    DateTime _now = DateTime.now();
    return DateTime(_now.year, _now.month, _now.day);
  }

  // get menuItems for a specific date
  Future<QuerySnapshot<Object?>> getMenuItemByDate() async {
    return await userService
        .getMenusCollection()
        .doc(staticMenuId)
        .collection("menuItems")
        .where('availabilityDate', isEqualTo: getCurrentDate())
        .get();
  }
}
