import 'package:flutter/material.dart' ;
import 'package:pfa2_mobile_app/customs/sharedElements.dart/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/SmallText.dart';
import 'package:pfa2_mobile_app/customs/sharedWidgets/UserOption.dart';
import 'package:pfa2_mobile_app/screens/buyTickets.dart';
import 'package:pfa2_mobile_app/screens/menuItemBody.dart';
import 'package:pfa2_mobile_app/screens/userReservations.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Home"),
        leading: IconButton(icon: Icon(Icons.segment),
        color : AppColors.textColor,
        
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserReservations() ));
        }
        )
      ),
      body:SafeArea(
        child: SingleChildScrollView(
        child:SizedBox(
        child: Column(
          children: <Widget>[
            // HEADER
            Container(
              margin: const EdgeInsets.only(top:45, bottom :15),
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
        
                children: <Widget>[
                  BigText(text:"University Restaurant", size: 30,color: AppColors.mainColor,),
                  const SizedBox(height:6.0),
                  SmallText(text:"Make your reservation today",size : 16,color: const Color(0xFF332D2B),),
                ]
              ),
            ),
            // BODY
            const MenuItemBody(),
            // More Options
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30,left: 40,) ,
                  child: BigText(text: "More Options")
                ),
              ],
            ),
           const SizedBox(height: 10,),
            //List of user options 
            SizedBox(
              height: 300,
              child: Column(
                children:  <Widget>[
                  Expanded(
                    child: UserOption(title: "Buy Tickets",
                    text:"To successfully reserve your meal a certain amount of tickets must be aquired",
                    direction:  BuyTickets(),),
                  ),
                  Expanded(
                    child: UserOption(title: "Give Us Your Feedback",
                    text :"We are always looking for your opinion to help ameliorate our app",
                    direction: const Home(),),
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ],
          ),
        ),
      )
      )
    );
  }
}

