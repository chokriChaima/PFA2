import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedWidgets/reservationCard.dart';
import 'package:pfa2_mobile_app/models/client.dart';
import 'package:pfa2_mobile_app/models/reservation.dart';
import 'package:pfa2_mobile_app/models/student.dart';
import 'package:pfa2_mobile_app/models/teacher.dart';
import 'package:pfa2_mobile_app/services/reservation_service.dart';

import '../customs/sharedElements.dart/AppColors.dart';
import '../services/user_service.dart';

class UserReservations extends StatefulWidget {
  const UserReservations({ Key? key }) : super(key: key);

  @override
  State<UserReservations> createState() => _UserReservationsState();
}

class _UserReservationsState extends State<UserReservations> {

  UserService userService = UserService( database: FirebaseFirestore.instance, user: FirebaseAuth.instance.currentUser );
  String? _userName = "";
  List<Reservation> _reservationList = [];
  @override
  void initState() {
    super.initState();
   
  }

  
  Future getReservationList() async{

    String userType = await userService.getUserType() ;
    var data ;
    var userInfo ;

    if(userType == "teacher")
    {
      data = await ReservationService(userService: userService).getReservationsTeacher();
      userInfo = await userService.getUserTeacher();
      userInfo = Teacher.fromMap(userInfo);
    }
    else {
      data = await ReservationService(userService: userService).getReservationsStudent();
      userInfo = await userService.getUserStudent();
      userInfo = Student.fromMap(userInfo);
    }

    setState(() {
      _reservationList = List.from(
        data.docs.map((doc) => Reservation.fromMap(doc))
      );
      _userName = (userInfo as Client).userName ;
    });
  }
  
  // didchange will unwrap the future and once it return with set the state
  // nice way to get future valus the whithout using a futurebuilder
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getReservationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Your Reservations",),
        leading: BackButton(
            color : AppColors.textColor,
        ),
      ),
      
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height : 40,),
            
            _reservationList.isNotEmpty ? 
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount : _reservationList.length,
              itemBuilder: (context,index){
                
                return ReservationCard(_reservationList[index],_userName);
              },
            ): BigText(text: "No reservation have been made")
          ]
        ),
      )
    );
  }

  
}