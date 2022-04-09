import 'package:flutter/material.dart' ;
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
      
        elevation: 0,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            
            BackButton(
              color: HexColor("#697A98"),
            ),
            Text("Home", 
              style : TextStyle(
              color: HexColor("#697A98"), 
              fontWeight: FontWeight.bold
               )
            ),
            Icon(
              Icons.person,
              color: HexColor("#697A98"),
            )
          ],
        ),
      ),
        
        body: Padding(
          padding: const EdgeInsets.fromLTRB(36,13.0,36,0),
          child: SingleChildScrollView(
            child: Container(
              
              child: Column
              (
                children: <Widget>[
                  const Text(
                    "Today's Menu, Hope you join us",
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: "Poppins-Regular"
                      )
                    ),
                  SizedBox(height: 22,),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text (
                        "Lunch",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      TextButton(
                        child: Text(
                          "View More",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),

                        onPressed: (){
                          /*Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context){
                                return ?();
                              },
                            ),
                          );*/
                        },
                      ),
                    ],
                  ),

                SizedBox(
                  height: 258,
                  width : MediaQuery.of(context).size.width-23,
                  child: Image.asset("assets/images/d1.jpg",fit: BoxFit.fitWidth),
                ),

                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text (
                        "Dinner",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      TextButton(
                        child: Text(
                          "View More",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),

                        onPressed: (){
                          /*Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context){
                                return ?();
                              },
                            ),
                          );*/
                        },
                      ),
                    ],
                  ),

                  SizedBox(
                  height: 258,
                  width : MediaQuery.of(context).size.width-23,
                  child: Image.asset("assets/images/d4.jpg",fit: BoxFit.fitWidth),
                ),
              
               ] ,
              ),
            ),
          ),
        )
    );
  }
}