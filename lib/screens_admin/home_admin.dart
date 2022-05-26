import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements/BigText.dart';
import 'package:pfa2_mobile_app/screens_admin/menu_form.dart';

import '../customs/sharedElements/AppColors.dart';
import '../customs/sharedElements/SmallText.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BigText(
          text: "Home",
          color: AppColors.mainColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              BigText(text: "No available Menus", underline: true,size: 28, fontweight: FontWeight.normal,),
              const SizedBox(height: 40),
              Container(
                width: 300,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MenuForm() )
                      );
                    },
                    child: BigText(
                      text: "Add New Menu",
                      color: AppColors.backgroundWhite,
                      size: 25,
                      fontweight: FontWeight.normal,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
