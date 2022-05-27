import 'package:flutter/material.dart' ;
import 'package:pfa2_mobile_app/screens_admin/home_admin.dart';


import '../../screens_admin/profile_admin.dart';
import '../sharedElements/AppColors.dart';

class SecondMainAdmin extends StatefulWidget {
  const SecondMainAdmin({ Key? key }) : super(key: key);

  @override
  State<SecondMainAdmin> createState() => _SecondMainAdminState();
}

class _SecondMainAdminState extends State<SecondMainAdmin> {
  int currentIndex=0;
  final screens=[
    const HomeAdmin(),
    const ProfileAdmin(),
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
            icon: const Icon(Icons.person),
            label: 'Profile',
            backgroundColor:AppColors.mainColor,
          ),
        ],
      ),
    );
  }

}