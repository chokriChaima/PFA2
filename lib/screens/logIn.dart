import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pfa2_mobile_app/models/student.dart';
import 'package:pfa2_mobile_app/screens/profileStudent.dart';
import 'package:pfa2_mobile_app/screens/signUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({ Key? key }) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  //a formState object can be used to save, reset and VALIDATE  
  //every FormField found in the target form.
  final _formKey = GlobalKey<FormState>() ;
 
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  // Adding Firebase to the application
  final _auth = FirebaseAuth.instance;
  
  
  @override
  Widget build(BuildContext context) {
 
    //Email Field
    final emailField = TextFormField (
      autofocus: false,
      controller: emailController,
      validator: (value){
        if(value!.isEmpty)
        {
          return ("Please enter your email"); 
        }
        // reg expression for email validation
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]") .hasMatch(value))
        {
          return ("Please enter a valid email");
        }
        return null ;
      },
      onSaved: (value) => emailController.text = value!,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        //you may add icons here
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: InputBorder.none,
      ),
    );

    //Password Field
    final passwordField = TextFormField (
      obscureText: true,
      autofocus: false,
      controller: passwordController,
      validator : (value){
        // firebase need atleast 6 characters to create an account
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) => passwordController.text = value!,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        //you may add icons here
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: InputBorder.none,
      ),
    );

    //Login button
    final logInButton = Material(
      elevation: 8,
      shadowColor: HexColor('#697A98'),
      color: HexColor('#697A98'),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          logIn(emailController.text, passwordController.text);
        },
        child:const Text(
          'Login',
          textAlign: TextAlign.center,
          style : TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          )
        ),
      ),

    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar : AppBar(
        title:  Text("Log In", style : TextStyle(color: HexColor("#697A98"), fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: BackButton(
          color: HexColor("#697A98"),
        ),
      ),
      body: Center(
       // A box in which a single widget can be scrolled
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0,20,20,20),
              child: Form(
                key: _formKey,
                child: Column(
                 // mainAxisAlignment: MainAxisAlignment.,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    const Text("Welcome back,", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        fontFamily: "Poppins-Regular",
                      )),
                      SizedBox(height: 9,),
                      const Text("please log in to your account", 
                      style: TextStyle(
                        fontSize: 14.5,
                        fontFamily: "Poppins-Regular",
                      )),
                    SizedBox(height: 60,),
                    Material(
                      child: emailField,
                      elevation: 8,
	                    shadowColor: Colors.white, ),
                    SizedBox(height: 25,),
                    Material(
                      child: passwordField,
                      elevation: 8,
	                    shadowColor: Colors.white,),
                    SizedBox(height: 65,),
                    logInButton,

                    SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account ? ",
                        style: TextStyle(
                          fontSize: 16,
                        ),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUp() )
                            );
                          },
                          child: Text("SignUp",
                          style : TextStyle(
                            fontWeight: FontWeight.w600,
                            color : HexColor("#697A98"),
                            fontSize: 17,
                          ))
                        )
                      ],
                    )
                  ],
                )
              ),
            )
          )
        ),
      ),
    );
  
  }

  
 Future<void> logIn(
    String email,
    String password,
  ) async {
    if(_formKey.currentState!.validate())
    {
      try {
            await _auth.signInWithEmailAndPassword(
            email: email,
            password: password);
            Fluttertoast.showToast(msg: "Login Successful");
            Navigator.of(context).pushReplacement(
             MaterialPageRoute(builder: (context) => StudentProfile() )
            );
      }on FirebaseAuthException  catch (e)  {
          Fluttertoast.showToast(msg: "User does not exist");
      }
    }
  }
}
