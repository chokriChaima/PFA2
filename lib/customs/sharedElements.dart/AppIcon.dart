import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final double size;
  const AppIcon({ Key? key,
   required this.icon,
   this.backgroundColor = const Color(0xFF332D2B),
   this.size =40,
   this.iconSize = 16,
   this.iconColor  =  Colors.white,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor
      ),
      child:Icon(
          icon,
          color: iconColor,
          size: iconSize,
        )
    );
  }
}