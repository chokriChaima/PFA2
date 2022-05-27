
import 'package:flutter/material.dart' ;
import 'package:pfa2_mobile_app/screens_client/home.dart' ;
import 'package:pfa2_mobile_app/screens_client/userReservations.dart' ;
import 'package:pfa2_mobile_app/screens_client/buyTickets.dart' ;
import 'package:pfa2_mobile_app/screens_client/profileStudent.dart' ;

import '../sharedElements/AppColors.dart';

class SecondMainClient extends StatefulWidget {
  const SecondMainClient({ Key? key }) : super(key: key);

  @override
  State<SecondMainClient> createState() => _SecondMainClientState();
}

class _SecondMainClientState extends State<SecondMainClient> {
  int currentIndex=0;
  final screens=[
    const Home(),
    const UserReservations(),
    const BuyTickets(),
    const StudentProfile(),
  ];
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index)=>setState(() {
          currentIndex =index;
        }),
        iconSize: 35,
        items:   [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: AppColors.mainColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant_outlined),
            label: 'Reservation',
            backgroundColor:AppColors.mainColor,
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num),
            label: 'ticket',
            backgroundColor:AppColors.mainColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor:AppColors.mainColor,
          ),
        ],
      ),
    );
  }

}