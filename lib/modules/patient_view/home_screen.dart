

import 'package:eclinic_mobile/models/medical_record_model.dart';
import 'package:eclinic_mobile/models/patient_model.dart';
import 'package:eclinic_mobile/modules/auth/login/login_screen.dart';
import 'package:eclinic_mobile/modules/patient_view/appoinments.dart';
import 'package:eclinic_mobile/modules/patient_view/medical_record.dart';
import 'package:eclinic_mobile/shared/api_provider.dart';
import 'package:eclinic_mobile/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;
import 'package:eclinic_mobile/modules/patient_view/profile_display.dart';


class PatientHomeScreeen extends StatefulWidget {
  
  PatientModel patientModel;
  
  PatientHomeScreeen({ required this.patientModel});
  @override
  _PatientHomeScreeenState createState() => _PatientHomeScreeenState();
}

class _PatientHomeScreeenState extends State<PatientHomeScreeen> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Colors.white,
        leading: Icon(Icons.home_rounded,color: Colors.black,size: 35,),
        title: Text('Home',style: GoogleFonts.oswald(color: Colors.black,fontSize: 28)),
        actions: [
          IconButton(
            iconSize: 30,
            color: Colors.black,
            onPressed: (){}, 
            icon: Icon(Icons.notification_important_rounded)),
          SizedBox(width: 8,),
          CircleAvatar(
            radius: 23.00,
            foregroundImage:AssetImage('assets/images/default_profile.png'),),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Padding(
        
        padding: EdgeInsetsDirectional.only(
          top: 100,
          bottom: 100,
          end: 40,
          start: 40
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => DisplayProfiletScreeen(patientModel: widget.patientModel)));              
                  },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[100],
                  ),
                  
                  child: Row(
                  
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.person,size: 70,),
                      SizedBox(width: 20,),
                      Text(
                        'Your Profile',
                        style: GoogleFonts.oswald(color: Colors.black,fontSize: 25),
                      ),
                      SizedBox(width: 50,),
                      Icon(Icons.arrow_forward_ios_rounded)
              
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => MedicalRecordcreen(patientModel: widget.patientModel)));              
                  },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[100],
                  ),
                  child: Row(
                  
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.description_rounded,size: 70,),
                      SizedBox(width: 20,),
                      Text(
                        'Medical Records',
                        style: GoogleFonts.oswald(color: Colors.black,fontSize: 25),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => AppointmentsScreen()));              
                  },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[100],
                  ),
                  child: Row(
                  
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.date_range_rounded,size: 70,),
                      SizedBox(width: 22,),
                      Text(
                        'Appointments',
                        style: GoogleFonts.oswald(color: Colors.black,fontSize: 25),
                      ),
                      SizedBox(width: 30,),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: InkWell(
                onTap: (){
                  ApiProvider.userlogout(token: widget.patientModel.token!).then((value) {
                    if(value.statusCode==200){
                      print(widget.patientModel.token!);
                      print('logout YOLO!!');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen())); 
                    }
                  });
                  },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue[100],
                  ),
                  child: Row(
                  
                    children: [
                      SizedBox(width: 15,),
                      Icon(Icons.logout_rounded,size: 70,),
                      SizedBox(width: 20,),
                      Text(
                        'Logout',
                        style: GoogleFonts.oswald(color: Colors.black,fontSize: 25),
                      ),
                      SizedBox(width: 91),
                      Icon(Icons.arrow_back_ios_rounded)
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ), 
    );
    
  }
}