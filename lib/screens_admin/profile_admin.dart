import 'package:flutter/material.dart' ;
class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({ Key? key }) : super(key: key);

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text("Inside profile admin"));
    
  }
}