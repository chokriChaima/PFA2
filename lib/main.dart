import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/customs/sharedElements.dart/AppColors.dart';
import 'package:pfa2_mobile_app/firebase_options.dart';
import 'package:pfa2_mobile_app/screens/home.dart';
import 'package:pfa2_mobile_app/screens/logIn.dart';
import 'package:hexcolor/hexcolor.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PFA2',
      theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: AppColors.mainColor,
          ),
          backgroundColor: AppColors.backgroundWhite,
          scaffoldBackgroundColor: AppColors.backgroundWhite,

          appBarTheme:  AppBarTheme(
            elevation: 0,
            backgroundColor:  AppColors.backgroundWhite ,
              shadowColor: AppColors.backgroundWhite,
            )
        ),
      home: const LogIn(),
    );
  }
}
