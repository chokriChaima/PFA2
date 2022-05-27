import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:pfa2_mobile_app/customs/sharedWidgets/second_main_admin.dart';
import 'package:pfa2_mobile_app/customs/sharedWidgets/second_main_client.dart';

import '../../services/user_service.dart';
class SecondMain extends StatefulWidget {
  const SecondMain({ Key? key }) : super(key: key);

  @override
  State<SecondMain> createState() => _SecondMainState();
}

class _SecondMainState extends State<SecondMain> {
  String userType = "";
  UserService userService = UserService(database: FirebaseFirestore.instance,user: FirebaseAuth.instance.currentUser);
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
  bool checkIsAdmin(){
    return userType == "director" || userType == "nutritionist" ;
  }
  @override
  Widget build(BuildContext context) {
    if(checkIsAdmin()){
      return const SecondMainAdmin();
    }
    else {
      return const SecondMainClient();
    }
  }
}