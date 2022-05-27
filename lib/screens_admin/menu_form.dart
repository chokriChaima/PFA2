import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/SmallText.dart';
import 'package:pfa2_mobile_app/customs/sharedWidgets/second_main_admin.dart';
import 'package:pfa2_mobile_app/models/menu_item.dart';
import 'package:pfa2_mobile_app/screens_admin/home_admin.dart';
import 'package:pfa2_mobile_app/screens_admin/menu_item_form.dart';
import 'package:pfa2_mobile_app/services/menu_service.dart';

import '../models/menu.dart';
import '../services/user_service.dart';

class MenuForm extends StatefulWidget {
  const MenuForm({Key? key}) : super(key: key);

  


  @override
  State<MenuForm> createState() => _MenuFormState();
}

class _MenuFormState extends State<MenuForm> {
  

  UserService userService = UserService(
      database: FirebaseFirestore.instance,
      user: FirebaseAuth.instance.currentUser);

  // menu item list
  List<MenuItem> _menuItemsList = [];

  //  Inputs Controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController menuTitleController = TextEditingController();
  final TextEditingController maxNumberItemsController =
      TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   if(widget.newMenuItem != null){
  //     setState(() {
  //     _menuItemsList.add(widget.newMenuItem!);
  //     });
  //   }
    
  // }
  @override
  Widget build(BuildContext context) {
    final menuItemsViewList = ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 220,
                height: 40,
                child: OutlinedButton(
                  onPressed: () {
                    print(_menuItemsList[index].toString());
                  },
                  child: SmallText(
                    text: _menuItemsList[index].title!,
                    color: AppColors.mainColor,
                    size: 18,
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.mainColor),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_rounded),
                onPressed: () {
                  deleteMenuItem(index);
                },
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => (const SizedBox(
              height: 15,
            )),
        itemCount: _menuItemsList.length);
    // Input Fields
    final menuItemField = TextFormField(
      style: const TextStyle(
        fontSize: 18,
        height: 0.4,
      ),
      textAlign: TextAlign.center,
      autofocus: false,
      controller: menuTitleController,
      validator: (value) {
        if (value!.isEmpty) return ("Please enter a title");
        return null;
      },
      onSaved: (value) => menuTitleController.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Title",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor))),
    );

    final maxNumberItemsField = TextFormField(
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        height: 0.4,
      ),
      autofocus: false,
      controller: maxNumberItemsController,
      validator: (value) {
        if (value!.isEmpty) return ("Please specify a number");
        return null;
      },
      onSaved: (value) => maxNumberItemsController.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: "Maximum number of items",
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor))),
    );

    final addMenuItemButton = OutlinedButton(
      onPressed: () async{
        addMenuItem();
        
      },
      child: SmallText(
        text: "Add menu item",
        color: AppColors.mainColor,
        size: 18,
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.mainColor),
      ),
    );

    final addButton = ElevatedButton(
        onPressed: () {
          submitForm();
        },
        child: SmallText(
          text: "Create Menu",
          color: AppColors.backgroundWhite,
          size: 18,
        ));

    return Scaffold(
     
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: "Menu Form",
            color: AppColors.mainColor,
          ),
          leading: BackButton(
            color: AppColors.mainColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: BigText(
                  text: "Create your own personalised menu",
                  fontweight: FontWeight.bold,
                ),
                padding: const EdgeInsets.only(left: 7, top: 40),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 28,
                        ),
                        menuItemField,
                        const SizedBox(
                          height: 28,
                        ),
                        maxNumberItemsField,
                        const SizedBox(
                          height: 28,
                        ),
                        SizedBox(
                            width: 330, height: 48, child: addMenuItemButton),
                        const SizedBox(
                          height: 32,
                        ),
                        BigText(text: "List of your menu Items"),
                        const SizedBox(
                          height: 10,
                        ),
                        _menuItemsList.isEmpty
                            ? SmallText(
                                text: "No Item(s) added",
                                size: 17,
                              )
                            : SmallText(
                                text: "Click on your menu item for more details",
                                size: 15.5,
                              ),const SizedBox(height: 28,), menuItemsViewList,
                        const SizedBox(
                          height: 28,
                        ),
                        SizedBox(width: 330, height: 48, child: addButton),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }

  Future<void> submitForm() async {
    MenuService menuService = MenuService(userService: userService);
    // List<MenuItem> list_test = [MenuItem(isLunch: false, components: [],title: "test")];

    if (_formKey.currentState!.validate()) {
      Menu menu = Menu(
          menuItems: _menuItemsList,
          maxMenuItem: int.parse(maxNumberItemsController.text),
          menuTitle: menuTitleController.text,
          isVerified: false);
      await menuService.addMenu(menu);
      Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SecondMainAdmin()));
    }
  }

  void deleteMenuItem(int index) {
    _menuItemsList.removeAt(index);
    setState(() {
      
    });
  }

  Future<void> addMenuItem() async{
    MenuItem result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MenuItemForm()));
    _menuItemsList.add(result);
    setState(() {
      
    });
  }
}
