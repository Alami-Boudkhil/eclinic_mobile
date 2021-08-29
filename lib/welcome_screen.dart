import 'package:eclinic_mobile/modules/auth/sign_up/signup_screen.dart';
import 'package:eclinic_mobile/modules/auth/login/login_screen.dart';
import 'package:eclinic_mobile/shared/components.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.white70,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  
                 child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    ),
                
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Sign UP ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35.00,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'we will take care of you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize:20.00
                      ),
                    ),
                    defaultButton(
                      function: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      },
                      text: 'get started',
                      radius:20.00 ,
                      background: Colors.blue[800],
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Have An Account?',
                        style: TextStyle(
                        fontSize: 18.00,
                        color: Colors.grey[700]
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18.00,
                            color: Colors.blue[700]
                          ),
                        ),
                        onPressed: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>LoginScreen()));      
                        },
                      ),
                    ],)
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
