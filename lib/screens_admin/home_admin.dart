import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedWidgets/menu_card.dart';
import 'package:pfa2_mobile_app/screens_admin/menu_form.dart';
import 'package:pfa2_mobile_app/services/menu_service.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

import '../customs/sharedElements/AppColors.dart';
import '../customs/sharedElements/SmallText.dart';
import '../models/menu.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
 UserService userService = UserService(
      database: FirebaseFirestore.instance,
      user: FirebaseAuth.instance.currentUser);

  // List of menus
  List<Menu> _menus = [];

  Future<void> getMenus() async{
    MenuService menuService = MenuService(userService: userService);
    QuerySnapshot<Object?> data = await menuService.getMenus();
    if (data.docs.isNotEmpty){
      setState(() {
        _menus = List.from(
          data.docs.map((doc) => Menu.fromMap(doc))
        );
      });
    }else {
      print("data not found");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getMenus();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BigText(
          text: "Home",
          color: AppColors.mainColor,
        ),
      ),
      body: SingleChildScrollView(
       
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left :15.0,right: 15),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                if (_menus.isEmpty)
                  BigText(
                    text: "No available Menus",
                    underline: true,
                    size: 28,
                    fontweight: FontWeight.normal,
                  )
                else
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _menus.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MenuCard(menu: _menus[index], index: index);
                    }
                  ),
               
                const SizedBox(height: 40),
                // dont change to sizedbox.
                Container(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MenuForm()));
                      },
                      child: BigText(
                        text: "Add New Menu",
                        color: AppColors.backgroundWhite,
                        size: 25,
                        fontweight: FontWeight.normal,
                      )),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
