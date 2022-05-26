import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pfa2_mobile_app/screens_client/logIn.dart';
import '../customs/customModels/gender.dart';
import '../customs/customRadioGender.dart';
import '../models/student.dart';




class SignUpStudent extends StatefulWidget {
  const SignUpStudent({ Key? key }) : super(key: key);

  @override
  State<SignUpStudent> createState() => _SignUpStudentState();
}

class _SignUpStudentState extends State<SignUpStudent> {
 final _formKey = GlobalKey<FormState>();

  //editing controller
  final userNameEditingController = TextEditingController();
  final majorController =  TextEditingController();
  final educationController =  TextEditingController() ;
  final passwordController =  TextEditingController();
  final confirmPasswordController =  TextEditingController();
  final emailController =  TextEditingController();

 

  // custom radio options
  List<Gender> genders = <Gender>[
    new Gender("Male", MdiIcons.genderMale, false),
    new Gender("Female", MdiIcons.genderFemale, false),
  ];
  
  // Firebase auth
  final _auth = FirebaseAuth.instance ;

  @override
  Widget build(BuildContext context) {

    // User Name Field
     final userNameField = TextFormField (
      autofocus: false,
      controller: userNameEditingController,
       validator: (value){
         if(value!.isEmpty)
         {
           return ("Please enter a user name");
         }
         return null;
       },
      onSaved: (value) => userNameEditingController.text = value!,
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
        //you may add icons here
        contentPadding:const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "User Name",
        border:  OutlineInputBorder(borderSide:BorderSide( color: HexColor("#697A98"))),           
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide( color:  HexColor("#697A98") )
         )
      ),
    );

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
      decoration:  InputDecoration(
        //you may add icons here
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border:  OutlineInputBorder(borderSide:BorderSide( color: HexColor("#697A98"))),           
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide( color:  HexColor("#697A98") )
         )
      ),
    );

    //Major  => preferably an option-directed list
    final majorField = TextFormField (
      autofocus: false,
      controller: majorController,
      validator: (value){
        if(value!.isEmpty)
        {
          return("Please enter a major");
        }
        
        return null;
      },
      onSaved: (value) => majorController.text = value!,
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
        //you may add icons here
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Major",
        border:  OutlineInputBorder(borderSide:BorderSide( color: HexColor("#697A98"))),           
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide( color:  HexColor("#697A98") )
         )
      ),
    );

    // Education Field
    final educationField = TextFormField (
      autofocus: false,
      controller: educationController,
      validator: (value){
        if(value!.isEmpty)
        {
          return("Please enter your eductaion. school name");
        }
        return null;
      },
      onSaved: (value) => educationController.text = value!,
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
        //you may add icons here
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "University",
        border:  OutlineInputBorder(borderSide:BorderSide( color: HexColor("#697A98"))),           
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide( color:  HexColor("#697A98") )
         )
      ),
    );

    

    //Password Field
     final passwordField = TextFormField (
      obscureText: true,
      autofocus: false,
      controller: passwordController,
      validator: (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) => passwordController.text = value!,
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
        //you may add icons here
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border:  OutlineInputBorder(borderSide:BorderSide( color: HexColor("#697A98"))),           
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide( color:  HexColor("#697A98") )
         )
      ),
    );

    //Confirm Password 
    final confirmPasswordField = TextFormField (
      obscureText: true,
      autofocus: false,
      controller: confirmPasswordController,
      validator : (value){
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
        if(passwordController.text!=value)
        {
          return("Password does not match ");
        }
      },
      onSaved: (value) => confirmPasswordController.text = value!,
      textInputAction: TextInputAction.done,
      decoration:  InputDecoration(
        //you may add icons here
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
       border:  OutlineInputBorder(borderSide:BorderSide( color: HexColor("#697A98"))),           
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide( color:  HexColor("#697A98") )
         )
      ),
    );

    
    
  final genderOptions = ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemCount: genders.length,
    itemBuilder: (context, index) {
      return InkWell(
        splashColor: Colors.white,
        
        onTap: () {
          setState(() {
            genders.forEach((gender) => gender.isSelected = false);
            genders[index].isSelected = true;
          });
        },
        child: CustomRadio(genders[index]
        ),
        
      );
    });

        
   
    //SignUpStudent  button
    final SignUpStudentButton = Material(
      elevation: 8,
      shadowColor: HexColor('#697A98'),
      color: HexColor('#697A98'),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          SignUpStudent(emailController.text, passwordController.text);
        },
        child: const Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style : TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          )
        ),
      ),
    );

    // Main Page
    return Scaffold(
      backgroundColor: Colors.white,
      appBar : AppBar(
        title:  Text("Sign Up Student", style : TextStyle(color: HexColor("#697A98"), fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: BackButton(
          color: HexColor("#697A98"),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     userNameField,
                      
                    const SizedBox(height: 10),
                     majorField,
                     
                    const SizedBox(height: 10),
                     educationField,
                     
                    const SizedBox(height: 10),
                    emailField,
                          
                    /*SizedBox(height: 10),
                    Material(
                      child: genderOptions,
                      elevation: 8,
	                    shadowColor: Colors.white,
                      ),*/
                    const SizedBox(height: 10),
                     passwordField,
                      
                     const SizedBox(height: 10),
                     confirmPasswordField,
                      
                  
                     const SizedBox(height: 10),
                    Container(
                      height: 100,
                      padding: const EdgeInsets.all(5),
                      child: genderOptions, ),
                    const SizedBox(height: 25),
                    SignUpStudentButton
                  ],
                )
              ),
            )

          )
        ),
        )
    );
  }
  Future<void> SignUpStudent(String email,String password) async{
    if(_formKey.currentState!.validate())
    {
      await _auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => 
      {
        // custom function
        postDetailsToFirestore() 
        
      })
      .catchError( (e) {
        Fluttertoast.showToast(msg: e.message);
      }) ;
    }
  }

  postDetailsToFirestore() async{
    // calling our firestore
    // calling our user model 
    // sending values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance ;
    
    // User is a predefined class type courtesy of firebase 
    User? user = _auth.currentUser;

    Gender userGender = genders.firstWhere((element) => element.isSelected);
    // writing all the values 
    // user.uid is never null 
    Student student = Student(
      userNameEditingController.text,
      userGender.name,
      user!.email,
      passwordController.text,
      studentUID: user.uid,
      education : educationController.text ,
      major : majorController.text,
    );
   
    await firebaseFirestore
          .collection("students")
          .doc(user.uid)
          .set(student.toMap());
    Fluttertoast.showToast(msg: "Account successfully created") ;

    // Push the given route onto the navigator that most tightly encloses the given context,
    // and then remove all the previous routes until the predicate returns true
    Navigator.pushAndRemoveUntil(context, 
    MaterialPageRoute (builder: (context) => const LogIn()) , (route) => false)   ;    
  }
}