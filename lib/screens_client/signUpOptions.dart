import 'package:flutter/material.dart' ;
import 'package:hexcolor/hexcolor.dart';
import 'package:pfa2_mobile_app/customs/sharedWidgets/sign_up_option_card.dart';
import 'package:pfa2_mobile_app/screens_client/signUpStudent.dart';
import 'package:pfa2_mobile_app/screens_client/signUpTeacher.dart';
import 'package:pfa2_mobile_app/screens_client/sign_up_staff.dart';

import '../customs/sharedElements/AppColors.dart';


class SignUpOptions extends StatefulWidget {
  const SignUpOptions({ Key? key }) : super(key: key);
  @override
  State<SignUpOptions> createState() => _SignUpOptionsState();
}

class _SignUpOptionsState extends State<SignUpOptions> {

  List<SignUpOptionCard> optionList= [SignUpOptionCard("Sign up as a student",const SignUpStudent()),
                                      SignUpOptionCard("Sign up as a teacher",const SignUpTeacher()),                              
                                      SignUpOptionCard("Sign up as a staff member",const SignUpStaff())];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title:  Text("Sign Up Options", style : TextStyle(color: HexColor("#697A98"), fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: BackButton(
          color: HexColor("#697A98"),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10,),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount : optionList.length,
              itemBuilder: (context,index){
                
                return optionList[index];
              },
            )
          ],
        ) ,
      )
      
    );
  }
}
