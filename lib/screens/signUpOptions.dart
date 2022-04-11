import 'package:flutter/material.dart' ;
import 'package:hexcolor/hexcolor.dart';
import 'package:pfa2_mobile_app/screens/signUpStudent.dart';
import 'package:pfa2_mobile_app/screens/signUpTeacher.dart';


class SignUpOptions extends StatefulWidget {
  const SignUpOptions({ Key? key }) : super(key: key);

  @override
  State<SignUpOptions> createState() => _SignUpOptionsState();
}

class _SignUpOptionsState extends State<SignUpOptions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              Card(
                  elevation : 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      
                      color:  HexColor("#ECEDEF")
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Padding (
                          padding:  EdgeInsets.all(20.0),
                          child: Text("Sign up as a teacher", style:  TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 19,
                            fontFamily: "Poppins-Regular",
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpTeacher() ),
                        );}
                        ,icon: const Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                  )
              ),
              Card(
                elevation : 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(
                    color:  HexColor("#ECEDEF")
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding (
                        padding:  EdgeInsets.all(20.0),
                        child: Text("Sign up as a student", style:  TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 19,
                          fontFamily: "Poppins-Regular",
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpStudent() ),
                      );}
                      ,icon: const Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                )
              ),
            ],
          ),
      )
      
    );
  }
}
