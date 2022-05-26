import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

import '../models/menu.dart';

class MenuService{

  UserService userService;
  MenuService({required this.userService});

  Future<void> addMenu(Menu menu) async{
    await userService.getMenusCollection().add(menu.toMap());
    Fluttertoast.showToast(msg: "Menu successfully created") ;

  }
}