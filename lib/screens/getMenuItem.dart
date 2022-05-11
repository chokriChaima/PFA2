import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/AppIcon.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/BigText.dart';
import 'package:pfa2_mobile_app/models/reservation.dart';
import 'package:pfa2_mobile_app/services/reservation_service.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

import '../customs/sharedElements.dart/IconAndText.dart';
import '../customs/sharedElements.dart/SmallText.dart';

class GetMenuItem extends StatefulWidget {
  const GetMenuItem({ Key? key }) : super(key: key);

  @override
  State<GetMenuItem> createState() => _GetMenuItemState();
}

class _GetMenuItemState extends State<GetMenuItem> {

  UserService userService = UserService( database: FirebaseFirestore.instance, user: FirebaseAuth.instance.currentUser );

  @override
  void initState() {
    super.initState();
    print(userService.user!.uid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Today's Lunch",size: 20,),
        leading:
         IconButton(
            padding: const EdgeInsets.all(2),
            onPressed: (){
              Navigator.pop(context);
            },
           icon :const Icon(Icons.close,size: 25,color: AppColors.textColor,),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 700,
          child: Stack(
          children: [
            Positioned(
              child: Container(
                width: double.maxFinite,
                height: 65,
                color: Colors.white,
              ),
            ),
            Positioned(
              child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(top:25),
                height: 230,
                decoration: const BoxDecoration(
                  
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                    image: AssetImage(
                      "assets/images/lunch3.jpg"
                    )
                  )
                ),
                 ),
            ),
            
           
            Positioned(
              top:300,
              left:0,
              right: 0,
              child: Container(
                height: 400,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                  ),
                  color: AppColors.backgroundWhite,
                ),
                child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             BigText(text: "Lunch",size: 32,),
                             SmallText(text: "10/04/2022",size: 16,),
                           ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        IconAndText(icon: Icons.brightness_1, text: "Chocolate Milk", iconColor: AppColors.mainColor),
                        const SizedBox(height: 4.0),
                        IconAndText(icon: Icons.brightness_1, text: "Sandwich", iconColor: AppColors.mainColor),
                        const SizedBox(height: 4.0),
                        IconAndText(icon: Icons.brightness_1, text: "Donnut", iconColor: AppColors.mainColor),
                        const SizedBox(height: 4.0),
                        IconAndText(icon: Icons.brightness_1, text: "Tart", iconColor:AppColors.mainColor),
                      
                      ],
                    ),
             )
            ) 
          ]  
        ),
        ),
      ),
      
      bottomNavigationBar: Container(
        height: 120,
        padding: const EdgeInsets.only(top:30,bottom : 30,left:20,right:20),
        decoration:  BoxDecoration(
          color: AppColors.mainColor,
          borderRadius:const  BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),

          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.remove, color: AppColors.textColor,),
                  const SizedBox(width: 10,),
                  BigText(text: "0"),
                  const SizedBox(width: 10,),
                  const Icon(Icons.add, color:AppColors.textColor),

                ],
              ),
            ),*/
            Container(
              padding: const EdgeInsets.all(5),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color :Colors.white
              ),
              child: MaterialButton(
               padding: const EdgeInsets.fromLTRB(20, 15, 20,15),
                onPressed: ()  {
                  Reservation reservation = Reservation(isLunch: true, partyNumber: 1);
                  ReservationService reservationService = ReservationService(userService : userService);
                  reservationService.makeReservation(reservation);
                },
                child: BigText(text: "Make reservation",fontweight: FontWeight.normal)
              ),
            )
            
          ],
        ),
      ),
    );
  }
}