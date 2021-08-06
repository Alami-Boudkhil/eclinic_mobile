import 'dart:convert';
//import 'dart:js';


import 'package:flutter/material.dart';
import 'package:http/http.dart'; 


class PatienProfiletScreeen extends StatefulWidget {
  var response='';
  var  email='';
  PatienProfiletScreeen({  required this.response, required this.email}) : super();

  @override
  _PatienProfiletScreeenState createState() => _PatienProfiletScreeenState();
}

class _PatienProfiletScreeenState extends State<PatienProfiletScreeen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Patient profile',
            style: TextStyle(
              fontSize: 30.00,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(
              height: 20.00,
            ), 
            Text( widget.response,
            style: TextStyle(
              fontSize: 30.00,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(
              height: 20.00,
            ), 
            Text('email='+widget.email,
            style: TextStyle(
              fontSize: 30.00,
              fontWeight: FontWeight.bold,
            ),
            )
          ],
        ),
      )
    );
    
  }
}