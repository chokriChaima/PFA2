import 'package:flutter/cupertino.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/SmallText.dart';
class IconAndText extends StatelessWidget {

  final IconData icon;
  final String text;
  final Color?color;
  final Color?iconColor;
  final double iconSize;
  const IconAndText({ Key? key, 
    required this.icon, 
    required this.text, 
    this.iconSize = 7.0,
    this.color, 
    this.iconColor 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: iconColor,size: iconSize,),
        const SizedBox(width : 5,),
        SmallText(text: text, color: color,size: 14,),
      ],
    );
  }
}