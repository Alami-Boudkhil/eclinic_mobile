


import 'dart:convert';
import 'package:eclinic_mobile/welcome_screen.dart';
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;
import 'package:eclinic_mobile/modules/patient_view/patient_profile.dart';


class PatientHomeScreeen extends StatefulWidget {
  @override
  _PatientHomeScreeenState createState() => _PatientHomeScreeenState();
}

class _PatientHomeScreeenState extends State<PatientHomeScreeen> {
  var  userToken='';

  Future userlogout()async{

    Uri url=Uri.parse('http://10.0.2.2:8000/rest-auth/logout/'); 

    var data = {
    "key":userToken,

    };

    final http.Response response= await  http.post(url,headers:{ "Accept": "application/json","content-type": "application/json"
      } ,body: json.encode(data));

    if(response.statusCode==200){
      print('logout YOLO!!');
      Navigator.pop(context);
}
    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Patient Dashboard',
            style: TextStyle(
              fontSize: 30.00,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(
              height:20.00,
            ),
            TextButton(
              child:Text(
                'LOGOUT',
                style: TextStyle(
                  color: Colors.blue
                ),

              ),
              onPressed: (){
                userlogout();
                
              },
              ),
              SizedBox(
              height:20.00,
            ),
            TextButton(
              child:Text(
                'view profile',
                style: TextStyle(
                  color: Colors.blue
                ),

              ),
                onPressed: (){
            
              },
              ),
          ],
        ),
      )
    );
    
  }
}