import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pfa2_mobile_app/models/teacher.dart';
import 'package:pfa2_mobile_app/screens_client/logIn.dart';
import '../customs/customModels/gender.dart';
import '../customs/customRadioGender.dart';




class SignUpTeacher extends StatefulWidget {
  const SignUpTeacher({ Key? key }) : super(key: key);

  @override
  State<SignUpTeacher> createState() => _SignUpTeacherState();
}

class _SignUpTeacherState extends State<SignUpTeacher> {
 final _formKey = GlobalKey<FormState>();

  //editing controller
  final userNameEditingController = TextEditingController();
  final workSpaceController =  TextEditingController();
  final departmentController =  TextEditingController() ;
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

    //department 
    final departmentField = TextFormField (
      autofocus: false,
      controller: departmentController,
      validator: (value){
        if(value!.isEmpty)
        {
          return("Please enter your department name");
        }
        
        return null;
      },
      onSaved: (value) => departmentController.text = value!,
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
        //you may add icons here
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "department",
        border:  OutlineInputBorder(borderSide:BorderSide( color: HexColor("#697A98"))),           
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide( color:  HexColor("#697A98") )
         )
      ),
    );

    // work space Field
    final workSpaceField = TextFormField (
      autofocus: false,
      controller: workSpaceController,
      validator: (value){
        if(value!.isEmpty)
        {
          return("Please enter the institution name");
        }
        return null;
      },
      onSaved: (value) => workSpaceController.text = value!,
      textInputAction: TextInputAction.next,
      decoration:  InputDecoration(
        //you may add icons here
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Institution",
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

        
   
    //SignUpTeacher  button
    final SignUpTeacherButton = Material(
      elevation: 8,
      shadowColor: HexColor('#697A98'),
      color: HexColor('#697A98'),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          SignUpTeacher(emailController.text, passwordController.text);
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
        title:  Text("Sign Up Teacher", style : TextStyle(color: HexColor("#697A98"), fontWeight: FontWeight.bold)),
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
                     departmentField,
                     
                    const SizedBox(height: 10),
                     workSpaceField,
                     
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
                    SignUpTeacherButton
                  ],
                )
              ),
            )

          )
        ),
        )
    );
  }
  Future<void> SignUpTeacher(String email,String password) async{
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
    Teacher teacher = Teacher(
      userNameEditingController.text,
      userGender.name,
      user!.email,
      passwordController.text,
      teacherUID: user.uid,
      workPlace : workSpaceController.text ,
      department : departmentController.text,
    );
   
    await firebaseFirestore
          .collection("teachers")
          .doc(user.uid)
          .set(teacher.toMap());
    Fluttertoast.showToast(msg: "Account successfully created") ;

    // Push the given route onto the navigator that most tightly encloses the given context,
    // and then remove all the previous routes until the predicate returns true
    Navigator.pushAndRemoveUntil(context, 
    MaterialPageRoute (builder: (context) => const LogIn()) , (route) => false)   ;    
  }
}