import 'package:flutter/cupertino.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/SmallText.dart';
class IconAndText extends StatelessWidget {

  final IconData icon;
  final String text;
  final double size;
  final Color?color;
  final Color?iconColor;
  final double iconSize;
  const IconAndText({ Key? key, 
    this.size =15,
    required this.icon, 
    required this.text, 
    this.iconSize = 7.0,
    this.color , 
    this.iconColor = const Color(0xFF697A98)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: iconColor,size: iconSize,),
        const SizedBox(width : 5,),
        SmallText(text: text, color: color,size: size,),
      ],
    );
  }
}