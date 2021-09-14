import 'package:eclinic_mobile/models/patient_model.dart';
import 'package:eclinic_mobile/modules/patient_view/appoinments.dart';
import 'package:eclinic_mobile/modules/patient_view/medical_record.dart';
import 'package:eclinic_mobile/shared/api_provider.dart';
import 'package:eclinic_mobile/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart'; 
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
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Icon(Icons.home_rounded,color: Colors.black,size: 45,),
        title: CircleAvatar(
          radius:56 ,
          backgroundImage: AssetImage('assets/images/logo.png'),
          backgroundColor: Colors.transparent,
          ),
        actions: [
          
          CircleAvatar(
            radius: 23.00,
            foregroundImage:AssetImage('assets/images/default_profile.png'),),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      const SizedBox(height: 20,),
      InkWell(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => DisplayProfiletScreeen(patientModel: widget.patientModel)));              
        },
      child: Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blue[50],
        ),
        
        child: Row(
        
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'My Profile',
                    style: GoogleFonts.oswald(fontSize: 28),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    'Check your informations and update them ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(fontSize: 15),
            
                  ),
                ],
              ),
            ),
            //SizedBox(width: 5,),
            Expanded(
              
              child: Image(
                image: AssetImage('assets/images/hospital.png'),
              ),
            )
        
            
          ],
        ),
      ),
                  ),             
      const SizedBox(height: 20,),
      InkWell(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => MedicalRecordcreen(patientModel: widget.patientModel)));              
        },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.pink[50],
        ),
        child: Row(
        
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Medical record',
                    style: GoogleFonts.oswald(fontSize: 28),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    'keep on track with your medical history',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(fontSize: 15),
            
                  ),
                ],
              ),
            ),
            //SizedBox(width: 5,),
            Expanded(
              
              child: Image(
                image: AssetImage('assets/images/medical-tools.png'),
              ),
            )
          ],
        ),
      ),
                  ),             
      const SizedBox(height: 20,),
      InkWell(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => AppointmentsScreen(patientModel: widget.patientModel,)));              
        },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.orange[100],
        ),
        child: Row(
        
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Appointments',
                    style: GoogleFonts.oswald(fontSize: 28),
                  ),
                  SizedBox(height: 2,),
                  Text(
                    'book and track ur appointments',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(fontSize: 15),
            
                  ),
                ],
              ),
            ),
            //SizedBox(width: 5,),
            Expanded(
              
              child: Image(
                image: AssetImage('assets/images/heart.png'),
              ),
            )
          ],
        ),
      ),
                  ),                         
      const SizedBox(height: 20,),
      Align(
      alignment: Alignment.bottomRight,
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
          color: Colors.grey.shade200.withOpacity(0.8),
          child: Row(
            
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Logout  ',
                style:  GoogleFonts.oswald(fontSize: 25)
              ),
              Image(
                image: AssetImage('assets/images/logout.png'),
                height: 55,
                width: 55,
              ),
              
              
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