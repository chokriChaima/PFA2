import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/BigText.dart';
import 'package:pfa2_mobile_app/models/menu_item.dart';
import 'package:pfa2_mobile_app/models/reservation.dart';
import 'package:pfa2_mobile_app/services/reservation_service.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

import '../customs/sharedElements/IconAndText.dart';
import '../customs/sharedElements/SmallText.dart';

class GetMenuItem extends StatefulWidget {
  final MenuItem menuItem ;
  GetMenuItem({required this.menuItem});

  @override
  State<GetMenuItem> createState() => _GetMenuItemState();
}

class _GetMenuItemState extends State<GetMenuItem> {

  UserService userService = UserService( database: FirebaseFirestore.instance, user: FirebaseAuth.instance.currentUser );
  int partyNumber = 0;
  
  @override
  void initState() {
    super.initState();
    print(userService.user!.uid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        
        title: BigText(text: widget.menuItem.isLunch ? "Today's Lunch": "Today's Dinner",size: 20,),
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
                decoration:  BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage("${widget.menuItem.imageURL}")  ,
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
                             BigText(text: "${widget.menuItem.title}" ,size: 32,),
                             SmallText(text: "${widget.menuItem.availabilityDate?.day.toString()} / ${widget.menuItem.availabilityDate?.month.toString()} / ${widget.menuItem.availabilityDate?.year.toString()}",size: 16,),
                           ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                       ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.menuItem.components.length,
                        itemBuilder: (context,index){
                          return IconAndText(icon: Icons.brightness_1, text: widget.menuItem.components[index],size: 20,);
                        },
                  ),
                      
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
        decoration:  const BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),

          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color :AppColors.mainColor
              ),
              child: MaterialButton(
               padding: const EdgeInsets.fromLTRB(20, 15, 20,15),
                onPressed: ()  async{
                  Reservation reservation = Reservation(isLunch: widget.menuItem.isLunch, partyNumber: partyNumber,date: widget.menuItem.availabilityDate);
                  ReservationService reservationService = ReservationService(userService : userService);
                  await reservationService.makeReservation(reservation);
                },
                child: BigText(text: "Make reservation",fontweight: FontWeight.normal,color: Colors.white,)
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.mainColor,
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      setState(() {
                        if(partyNumber>0)
                        {
                          partyNumber--;
                        }
                        else{
                          Fluttertoast.showToast(msg :"you're already at zero");
                        }
                      });
                    }, icon:const Icon(Icons.remove, color:Colors.white)
                  ),
                  BigText(text: partyNumber.toString() ,color:Colors.white ,),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        partyNumber++;
                      });
                    }, icon:const Icon(Icons.add, color:Colors.white)
                  ),

                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

