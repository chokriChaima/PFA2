import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pfa2_mobile_app/firebase_options.dart';
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
            primary: HexColor("#697A98"),
          ),
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,

          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
              elevation: 5,
              shadowColor: Colors.white,
            )
        ),
      home: const LogIn(),
    );
  }
}
