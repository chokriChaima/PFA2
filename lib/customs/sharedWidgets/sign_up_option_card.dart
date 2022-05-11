import 'package:flutter/material.dart';

import '../sharedElements.dart/AppColors.dart';

class SignUpOptionCard  extends StatelessWidget {
  final Widget optionRoute ;
  final String optionMessage ;

   SignUpOptionCard ( this.optionMessage, this.optionRoute) ;

  @override
  Widget build(BuildContext context) {
    return Card(
                  elevation : 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color:  AppColors.backgroundWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding (
                          padding: const EdgeInsets.all(20.0),
                          child: Text(optionMessage, style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 19,
                            fontFamily: "Poppins-Regular",
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  optionRoute ),
                        );}
                        ,icon: const Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                  )
    );
  }
}