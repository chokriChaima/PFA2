import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/SmallText.dart';
import 'package:pfa2_mobile_app/models/reservation.dart';
import 'package:pfa2_mobile_app/services/reservation_service.dart';
import 'package:pfa2_mobile_app/services/user_service.dart';

class ReservationCard extends StatelessWidget {
  final Reservation _reservation ;
  final String? madeBy ;
  int index;
  ReservationCard(this._reservation, this.madeBy, this.index);

  UserService userService = UserService( database: FirebaseFirestore.instance, user: FirebaseAuth.instance.currentUser );

  
  
  void onDeleteResrvation() async{
    ReservationService reservationService = ReservationService(userService: userService);
    await reservationService.deleteReservationStudent(index);
    Fluttertoast.showToast(msg: "Your reservation has been deleted ") ;
    
  }  
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children : <Widget>[
                Row(
                  children: <Widget>[
                  Padding(
                    padding:  const EdgeInsets.only(bottom: 10.0),
                    child: BigText(text: "Reservation made by ${madeBy}",size: 18,fontweight: FontWeight.w600,),
                    ),
                ],
              ),
              Row(
                children: <Widget>[
                  _reservation.isLunch! ? BigText(text: "Lunch Reservation",size: 14,fontweight: FontWeight.normal): BigText(text: "Dinner reservation",size: 14,fontweight: FontWeight.normal) ,
                  const SizedBox(width: 20,),
                  BigText(text: "Party Number : ${_reservation.partyNumber}",size: 12,),
                 
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: <Widget>[

                  SmallText(text: "${_reservation.date?.day.toString()} / ${_reservation.date?.month.toString()} / ${_reservation.date?.year.toString()}"),
                ],
              ),
              ]
             
            ),
             
             //const  SizedBox(width: 20,),
              Material(
              color: Colors.white,
              child: Ink(
                decoration:  ShapeDecoration(
                  color: AppColors.mainColor,
                  shape: const CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  color: Colors.white,
                  onPressed: () {
                    onDeleteResrvation();
                  },
                ),
              ),
            )
          ],
          
        )
      )
    );
  }
}