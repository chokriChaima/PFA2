import 'package:flutter/material.dart' ;
import 'package:hexcolor/hexcolor.dart';
class StudentProfile extends StatefulWidget {
  const StudentProfile({ Key? key }) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: HexColor("#697A98"),
      
      body: SafeArea(
        child: Center(
          child: Column(

            children: [
              /*const SizedBox(height: 40),
              Image.asset(
                'assets/images/img_profpic.png',
                width: 100,
                height: 100,
              ),*/
              const SizedBox(height: 80),
              Text(
                'Harun Nurahman',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                'Mobile Developer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-200,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Friends', ),
                     SizedBox(height: 16),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}