import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/AppColors.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/BigText.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/SmallTextCentered.dart';

class UserOption extends StatelessWidget {
  final String text ;
  final String title;
  Widget direction;

  UserOption({ Key? key , 
  required this.text, 
  required this.title,
  required this.direction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only( top: 10,left : 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
         boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5),
                  ),
                 
                ]
      ),
      child: Padding(
        padding: EdgeInsets.only(left : 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           
            Container( 
              padding: const EdgeInsets.only(top :15, left : 20, right: 20),
              child: BigText(text: title),
            ),
           const SizedBox(height : 10),
            SmallTextCentered(text: text, color: AppColors.mainColor,),
             Container(
               margin: const EdgeInsets.only(left: 250),
               child: IconButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => direction ),
                  );}
                  ,icon: const Icon(Icons.arrow_forward_ios,size:15)
                ),
             ),
          ],
        ),
      ),
    );
  }
}