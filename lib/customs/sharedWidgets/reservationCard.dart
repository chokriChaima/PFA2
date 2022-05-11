import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/SmallText.dart';
import 'package:pfa2_mobile_app/models/reservation.dart';

class ReservationCard extends StatelessWidget {
  final Reservation _reservation ;
  final String? madeBy ;
  ReservationCard(this._reservation, this.madeBy);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
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
                const Spacer(),
                BigText(text: "Party Number : ${_reservation.partyNumber}",size: 12,),
                const Spacer(),
                SmallText(text: "Date : 23/04/2022"),
              ],
            )
            ]
           
          )
        )
      )
    );
  }
}