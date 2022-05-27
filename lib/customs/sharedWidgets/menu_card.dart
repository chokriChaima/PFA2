import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/SmallTextCentered.dart';
import 'package:pfa2_mobile_app/customs/sharedWidgets/second_main_admin.dart';
import 'package:pfa2_mobile_app/services/menu_service.dart';

import '../../models/menu.dart';
import '../../services/user_service.dart';
import '../sharedElements/AppColors.dart';
import '../sharedElements/BigText.dart';
import '../sharedElements/SmallText.dart';

class MenuCard extends StatefulWidget {
  final Menu menu;
  final int index;
  MenuCard({required this.menu, required this.index});

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  UserService userService = UserService(database: FirebaseFirestore.instance,user: FirebaseAuth.instance.currentUser);
  String userType = "";

  Future<void> setUserType() async{
    String data = await userService.getUserType() ;
    setState(() {
      userType = data ;
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setUserType();
  }
  
  @override
  Widget build(BuildContext context) {

    final validateButton = ElevatedButton(
        
        onPressed: userType == "director" ? () {
          updateIsVerified(widget.index,widget.menu.isVerified);
        }: null,
        child:
         widget.menu.isVerified ?
         SmallTextCentered(
          text: "Invalidate",
          color: AppColors.backgroundWhite,
          size: 17.4,
        ):
         SmallText(
          text: "Validate",
          color: AppColors.backgroundWhite,
          size: 17.4,
        ));

    final deleteButton = OutlinedButton(
      onPressed: () {
        deleteMenu(widget.index);
      },
      child: SmallText(
        text: "Delete",
        color: AppColors.mainColor,
        size: 17.4,
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.mainColor),
      ),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0,),
        child: Column(
          children: <Widget>[
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              BigText(
                text: widget.menu.menuTitle,size: 20,fontweight: FontWeight.w500,
              ),
             
              IconButton(
              onPressed: (){print("on see more");},
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
               )
              ],
          ),
          const SizedBox(height: 20),
          widget.menu.isVerified
            ? BigText(text: "Menu State : Validated",size: 17,fontweight: FontWeight.normal,)
            : BigText(text: "Menu State : is yet to be validated",size: 17,fontweight: FontWeight.normal,),
          const SizedBox(height: 18),
          BigText(
            text: 'Maximum number of items : ${widget.menu.maxMenuItem}',size: 17,fontweight: FontWeight.normal,
          ),
          const SizedBox(height: 28),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Spacer(),
            SizedBox(child: validateButton,width: 108,height: 40,),
            const SizedBox(width: 15,),
            SizedBox(child: deleteButton,width: 108,height: 40,),
            const Spacer(),
          ],
        )
          ],
        ),
    )
    );
      
        
        
        
        
  }

  MenuService inistializeMenuService(){
    UserService userService = UserService(
      database: FirebaseFirestore.instance,
      user: FirebaseAuth.instance.currentUser);

    return  MenuService(userService: userService);
  }

  Future<void> updateIsVerified(int index,bool isVerified) async{
    await inistializeMenuService().updateIsVerified(index, isVerified);
    Navigator.push(
        context,
       MaterialPageRoute(builder: (context) => const SecondMainAdmin() )
    );
  }

  Future<void> deleteMenu(int index) async{
    await inistializeMenuService().deleteMenu(index);
    Navigator.push(
        context,
       MaterialPageRoute(builder: (context) => const SecondMainAdmin() )
    );
  }
}
