import 'dart:convert';

import 'package:eclinic_mobile/models/patient_model.dart';
import 'package:eclinic_mobile/models/medical_record_model.dart';
import 'package:eclinic_mobile/modules/patient_view/appoinments.dart';
import 'package:eclinic_mobile/modules/patient_view/home_screen.dart';
import 'package:eclinic_mobile/modules/patient_view/profile_display.dart';
import 'package:eclinic_mobile/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MedicalRecordcreen extends StatefulWidget{
  final PatientModel? patientModel;
  final String? password;
  MedicalRecordcreen({required this.patientModel,this.password});

  @override
  _MedicalRecordcreenState createState() => _MedicalRecordcreenState();
}

class _MedicalRecordcreenState extends State<MedicalRecordcreen> {
  MedicalRecordModel? medicalRecordModel;

  Future userlogout()async{

    Uri url=Uri.parse('http://10.0.2.2:8000/rest-auth/logout/'); 

    var data = {
    "key":widget.patientModel!.token,

    };

    final http.Response response= await  http.post(url,headers:{ "Accept": "application/json","content-type": "application/json"
      } ,body: json.encode(data));

    if(response.statusCode==200){
      print('logout YOLO!!');
      Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => WelcomeScreen())); 
}
  }
  Future getMedicalRecord()async{

    Uri url=Uri.parse('http://10.0.2.2:8000/api-medical/patient_medical_record/'); 
    String cookie=widget.patientModel!.cookie!;
    String? sessionid;
    
    if (cookie.contains('sessionid')) {
      List at = RegExp(r'(sessionid)(.*?)[^;]+').stringMatch(cookie)!.split('=');
      sessionid = at[1];
    }
    print(widget.patientModel!.cookie);
    print(widget.patientModel!.token);
    print(sessionid);
    final http.Response response = await http.get(
      url,
      headers: {'Authorization':widget.patientModel!.token!,'Cookie': 'sessionid=$sessionid;'}
      );

    if(response.statusCode==200){
      print('YOLO');
      medicalRecordModel= new MedicalRecordModel();
      medicalRecordModel!.fromJson(jsonDecode(response.body));
    }else{
      print('error');
      print(response.body);

    }
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        iconTheme:  IconThemeData(color: Colors.black),
        elevation: 8.00,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Your Medical Record',
          style: GoogleFonts.oswald(color: Colors.black,fontSize: 26),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: (){}, 
            icon: Icon(Icons.notification_important_rounded)),
          SizedBox(width: 8,),
          
        ],
      ),
      body:Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'your informations:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'First name:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Last Name:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Educational level:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Social Id:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Biometric ID:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )
                        ],
                      ),
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Substences consumption:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      Divider(
                        height: 8,
                        thickness: 5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'tobaco consumption:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.check_circle),
                          Icon(Icons.indeterminate_check_box_rounded),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Tobaco taken as:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Number of Units:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )
                        ],
                      ),
                      Divider(
                        thickness: 5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Alcohol consumption:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.check_circle),
                          Icon(Icons.indeterminate_check_box_rounded),
                        ],
                      ),
                      Divider(
                        height: 8,
                        thickness: 5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'medication consumption:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.check_circle),
                          Icon(Icons.indeterminate_check_box_rounded),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Type of medication:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Text(
                                "placeholder",
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.roboto(fontSize: 20),
                                maxLines: 10,),
                          )
                        ],
                      ),
                      Divider(
                        height: 8,
                        thickness: 5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Others:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Text(
                              'placeholder :',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(fontSize: 20),
                            ),
                          ),
                        ],
                      ),


                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'General diseases:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Surgical intervention:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Congenital condition :',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Allergic reactions:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'General:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      Divider(
                        height: 8,
                        thickness: 5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Wieght:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Height:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )
                        ],
                      ),
                      
                      Divider(
                        thickness: 5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hearing:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                        ]
                      ),
                      SizedBox(height: 8,),
                      Row(
                        
                        children: [
                          Text(
                            'Right:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )

                        ]
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Left:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            'placeHolder ',
                            style:GoogleFonts.roboto(fontSize: 20), 
                          )

                        ]
                      ),
                      Divider(
                        height: 8,
                        thickness: 5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Visual acuity without correction:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Right:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                              "placeholder",
                              style: GoogleFonts.roboto(fontSize: 20),
                              )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Left:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                              "placeholder",
                              style: GoogleFonts.roboto(fontSize: 20),
                              )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Visual acuity with correction:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Right:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                              "placeholder",
                              style: GoogleFonts.roboto(fontSize: 20),
                              )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Left:',
                            style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(width: 5,),
                          Text(
                              "placeholder",
                              style: GoogleFonts.roboto(fontSize: 20),
                              )
                        ],
                      ),  
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Skin state:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Skin exam:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ophtalmological state:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ophtalmological exam:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Orl state:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Orl exam:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Locomotor state:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Locomotor exam:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Respiratory state:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Respiratory exam:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cardiovascular state:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cardiovascular exam:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Digestive state:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Digestive exam:',
                            style: GoogleFonts.oswald(fontSize: 25),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      
                      
                  ],),
                ),
              ),
              SizedBox(height: 16,),
              Card(
                elevation: 5,
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // if you need this
                side: BorderSide(
                color: Colors.blue.withOpacity(0.2),
                width: 2,
                ),
                  ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 8,
                    bottom: 8
                  ),
                  child: Column(
                    
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Aptitude:',
                            style: GoogleFonts.oswald(fontSize:25 ),
                          ),
                          Icon(Icons.check_circle),
                          Icon(Icons.indeterminate_check_box_rounded),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Reason:',
                            style:GoogleFonts.roboto(fontSize: 20,fontWeight:FontWeight.w800), 
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffolder ',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Orientation specialist:',
                            style:GoogleFonts.roboto(fontSize: 20,fontWeight:FontWeight.w800), 
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffff',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Orientation cause:',
                            style:GoogleFonts.roboto(fontSize: 20,fontWeight:FontWeight.w800), 
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffff',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            'Orientation response:',
                            style:GoogleFonts.roboto(fontSize: 20,fontWeight:FontWeight.w800), 
                          ),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Text(
                              'placeHffffffffffffffff',
                              textAlign: TextAlign.justify,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style:GoogleFonts.roboto(fontSize: 20), 
                            ),
                          )
                        ],
                      ),

                      
                  ],),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            
            DrawerHeader(
              
              child: CircleAvatar(
                radius:40,
                foregroundImage: AssetImage('assets/images/logo.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.green[600]),
              title: Text(
                'Home page',
                style: TextStyle(fontSize: 20,color: Colors.green[600]),
                ),
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                 builder: (context) => PatientHomeScreeen(patientModel: widget.patientModel!, password1: widget.password!))); 
              },
            ),
            ListTile(
              leading: Icon(Icons.person,color: Colors.green[600]),
              title: Text(
                'Your Profile',
                style: TextStyle(fontSize: 20,color: Colors.green[600]),
                ),
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => DisplayProfiletScreeen(patientModel: widget.patientModel!, password1: widget.password!)));

              },
            ),
            ListTile(
              leading: Icon(Icons.date_range_rounded,color: Colors.green[600]),
              title: Text(
                'Appointments',
                style: TextStyle(fontSize: 20,color: Colors.green[600]),
                ),
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => AppointmentsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded,color: Colors.redAccent[400],),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 20,color: Colors.redAccent[400]),
                ),
              onTap: (){
                userlogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}