import 'package:flutter/cupertino.dart' ;
import 'package:flutter/material.dart';


// Reusable Text widget
class BigText extends StatelessWidget {
  // a dynamic color ;
   Color? color;
  final String text ;
  double size ;

  //TextOverflow overFlow ; 
  // this.overFlow = TextOverflow.ellipsis ;

  BigText({ Key? key, 
  this.color =const Color(0xFF332D2B), 
  required this.text,
  this.size = 20,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color : color,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: size,
      )
    );
  }
}