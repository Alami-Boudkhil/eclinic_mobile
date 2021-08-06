import 'dart:io';
import 'package:eclinic_mobile/modules/sign_up/signup_screen.dart';
import 'package:eclinic_mobile/modules/login/login_screen.dart';
import 'package:eclinic_mobile/main.dart';
import 'package:eclinic_mobile/shared/components.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  width: 350.00,
                  height: 350.00,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                    ),
                ),
              ],
            ),
            SizedBox(
              height: 20.00,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [ 
                Text(
                'Sign UP ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.00,
                  fontWeight: FontWeight.w900,
                  
                ),
                )
                ]
              ),
            SizedBox(
              height: 10.00,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'we will take care of you',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize:20.00
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.00,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultButton(
                function: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>SignUpScreen()));
                },
                text: 'get started',
                radius:30.00 ,
                background: Colors.blue[800],
              ),
            ),
            SizedBox(
              height: 20.00,
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
    );
  }
}
