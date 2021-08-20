import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import "package:eclinic_mobile/shared/components.dart";
import 'package:eclinic_mobile/modules/auth/sign_up/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:eclinic_mobile/modules/patient_view/home_screen.dart';
import 'package:eclinic_mobile/models/patient_model.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen> {

  
  final  emailController= TextEditingController();
  final  passwordController= TextEditingController();

  var formKey = GlobalKey<FormState>();
  late PatientModel patientModel;
  bool isObsecure=true;

  Future userlogin()async{

    Uri url=Uri.parse('http://10.0.2.2:8000/rest-auth/login/'); 

    var data = {
    "username": "",
    "email": emailController.text,
    "password": passwordController.text,
    };

    final http.Response response= await  http.post(url,headers:{ "Accept": "application/json","content-type": "application/json"
      } ,body: json.encode(data));

    final Map<String, dynamic> responseData = json.decode(response.body);
    

    if(response.statusCode==200)
    {
      patientModel=new PatientModel(
        email: emailController.text,
        token: responseData['key'],
        cookie: response.headers['set-cookie']
        );
        
      print(patientModel.cookie);
      print('login YOLO!!');
      print('Token:'+patientModel.token!);
      Navigator.push(
        context, 
        MaterialPageRoute(builder :(context)=> PatientHomeScreeen(patientModel: patientModel ,password1: passwordController.text,)));
      final snackBar = SnackBar(content: Text('Loged IN succesfuly ,Welcome!'));   
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    else if (response.statusCode==400)
    {
      print('can\'t login');
      print(response.body);
      showDialog(
              context: context,
              builder: (BuildContext context) => buildPopupDialog(
                context,title:'invalid credentials',
                msg: 'email or password are wrong!',),
            );
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Image(
                      image: AssetImage('assets/images/shape.png'),
                    ),
                    Positioned(
                      width: 180,
                      top: 80.00,
                      left: 20.00,
                      child: Text(
                        'Welcome Back,',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.00,
                          fontWeight: FontWeight.w600,
                          ),
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                    ),
                    Positioned(
                      top: 110.00,
                      left: 40.00,
                      child:Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30.00,
                          ),
                      ),
                    ),
                    Positioned (
                      height: 225.00,
                      width: 225.00,
                      top: 120.00,
                      left: 180.00,
                      child: Image(
                        image: AssetImage('assets/images/logoBW.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.00,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.00,
                  vertical: 20.00,
                ),
                child: defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email',
                  prefix: Icons.email_rounded,
                  validate: (value){
                    if(value.toString().isEmpty){
                      return 'Email must not be empty';
                    }
                    return null;
                  }
                  
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.00,
                   vertical: 20.00,
                 ),
                child: defaultFormField(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  label: 'Password',
                  prefix: Icons.lock_clock_rounded,
                  isPassword: isObsecure,
                  suffix: IconButton(
                    icon:isObsecure? Icon(Icons.visibility_rounded):Icon(Icons.visibility_off_rounded,),
                    onPressed: (){
                      setState(() {
                        isObsecure=!isObsecure;
                      });
                    },
                    ),
                  validate: (value){
                    if(value.toString().isEmpty){
                      return 'password must not be empty';
                    }else if(value.toString().length<6) {return 'Password too short';}

                    return null;
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.00,
                   vertical: 20.00,
                 ),
                child: defaultButton(
                  function: (){
                    if(formKey.currentState!.validate())
                    {
                    userlogin();
                    }
                   
                  },
                  text: 'sign in',
                  radius: 20.00,
                  background: Colors.blue[800],
                  ),
      
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You don't have an account?",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[700],
      
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Sing UP',
                      style:TextStyle(
                        fontSize: 18.00,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue
                      ) ,
                    ),
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>SignUpScreen()));
                    },
                  ),
                ],
              ),
            ],
        
          ),
        ),
      ),

    );
    
  }
}