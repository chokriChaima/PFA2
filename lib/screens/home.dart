import 'package:flutter/material.dart' ;
import 'package:pfa2_mobile_app/customs/sharedElements.dart/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/SmallText.dart';
import 'package:pfa2_mobile_app/screens/menuItemBody.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              // HEADER
              Container(
                margin: EdgeInsets.only(top:45, bottom :15),
                padding: EdgeInsets.only(left: 15.0),
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
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 30,left: 40,) ,
                      child: BigText(text: "More Options")
                    ),
                  ],
                )
              )
              //List of user options 
             /* ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index){
                  return Container(
                    margin: const EdgeInsets.only(left:20,right:20,),
                    
                      
                  );
              })*/

            ],
            ),
        ),
      )
    );
  }
}