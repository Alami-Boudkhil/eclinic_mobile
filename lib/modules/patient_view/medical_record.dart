import 'dart:convert';

import 'package:eclinic_mobile/models/patient_model.dart';
import 'package:eclinic_mobile/models/medical_record_model.dart';
import 'package:eclinic_mobile/modules/patient_view/appoinments.dart';
import 'package:eclinic_mobile/modules/patient_view/home_screen.dart';
import 'package:eclinic_mobile/modules/patient_view/profile_display.dart';
import 'package:eclinic_mobile/shared/api_provider.dart';
import 'package:eclinic_mobile/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalRecordcreen extends StatefulWidget{
  
  final PatientModel patientModel;
  MedicalRecordcreen({required this.patientModel});

  @override
  _MedicalRecordcreenState createState() => _MedicalRecordcreenState();
}

class _MedicalRecordcreenState extends State<MedicalRecordcreen> {
  MedicalRecordModel? medicalRecordModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiProvider.getMedicalRecord(token: widget.patientModel.token!).then((value) {
      if(value.statusCode==200){
        setState(() {
          final Map<String, dynamic> responseData = json.decode(value.body);
          print('YOLO getGedicalRecord');
          //print(widget.patientModel.token);
          //print(responseData["patient_data"]);
          medicalRecordModel = new MedicalRecordModel();
          medicalRecordModel!.fromJson(responseData);
      
          //print("inside: "+medicalRecordModel!.patientData.toString());
        });
      
    }else{
      print('error');
      print(value.body);

    }
    });
  }
  @override
  Widget build(BuildContext context) {
    
    if(medicalRecordModel==null){
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Network error"),
        ),
        body:Center(
          child: TextButton(
            child: Text('Try again'),
            onPressed: (){
              setState(() {
                
              });
             }),
        ),
      );
    }else{
    //print("debug:"+medicalRecordModel!.allergicReaction.toString() );
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
                            medicalRecordModel!.patientData!["user"]["first_name"],
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
                            medicalRecordModel?.patientData?["user"]["last_name"],
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
                            medicalRecordModel?.patientData?["education_level"],
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
                            medicalRecordModel!.socialID.toString(),
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
                            medicalRecordModel!.biometricID!,
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
                          medicalRecordModel?.tobacoConsumption==true?Icon(Icons.check_circle):Icon(Icons.indeterminate_check_box_rounded),                      
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
                            medicalRecordModel!.tobacoTakenAs!,
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
                            medicalRecordModel!.numberUnits.toString(),
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
                          medicalRecordModel!.alcoholConsumption==true?Icon(Icons.check_circle):Icon(Icons.indeterminate_check_box_rounded),
                          
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
                          medicalRecordModel!.medicationConsumption==true?Icon(Icons.check_circle):Icon(Icons.indeterminate_check_box_rounded),
                          
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
                                medicalRecordModel!.medications!,
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
                              medicalRecordModel!.other!,
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
                borderRadius: BorderRadius.circular(20), 
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Expanded(
                            child: Text(
                              medicalRecordModel!.generalDiseases!,
                              textAlign: TextAlign.center,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Expanded(
                            child: Text(
                              medicalRecordModel!.surgicalIntervention!,
                              textAlign: TextAlign.center,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Expanded(
                            child: Text(
                              medicalRecordModel!.congenitalCondition!,
                              textAlign: TextAlign.center,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Expanded(
                            child: Text(
                              
                              medicalRecordModel!.allergicReaction!,
                              textAlign: TextAlign.center,
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
                            medicalRecordModel!.wieght!.substring(0,5)+" Kg",
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
                            medicalRecordModel!.height!.substring(0,5)+" cm",
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
                            medicalRecordModel!.hearingRight!,
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
                            medicalRecordModel!.hearingLeft!,
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
                              medicalRecordModel!.visualAcuityWithoutCorrectionRight!,
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
                              medicalRecordModel!.visualAcuityWithoutCorrectionLeft!,
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
                              medicalRecordModel!.visualAcuityWithCorrectionRight!,
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
                              medicalRecordModel!.visualAcuityWithCorrectionLeft!,
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
                              "- "+medicalRecordModel!.skinState!,
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
                              medicalRecordModel!.skinExam!,
                              textAlign: TextAlign.center,
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
                              '- '+medicalRecordModel!.ophtalmologicalState!,
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
                              medicalRecordModel!.ophtalmologicalExam!,
                              textAlign: TextAlign.center,
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
                              '- '+medicalRecordModel!.orlState!,
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
                              medicalRecordModel!.orlExam!,
                              textAlign: TextAlign.center,
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
                              '- '+medicalRecordModel!.locomotorCase!,
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
                              medicalRecordModel!.locomotorExam!,
                              textAlign: TextAlign.center,
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
                borderRadius: BorderRadius.circular(20), 
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
                              '- '+medicalRecordModel!.respiratoryState!,
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
                              medicalRecordModel!.respiratoryExam!,
                              textAlign: TextAlign.center,
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
                              '- '+medicalRecordModel!.cardiovascularState!,
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
                              medicalRecordModel!.cardiovascularExam!,
                              textAlign: TextAlign.center,
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
                              '- '+medicalRecordModel!.digestiveState!,
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
                              medicalRecordModel!.digestiveExam!,
                              textAlign: TextAlign.center,
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
                          medicalRecordModel!.aptitude==true?Icon(Icons.check_circle):Icon(Icons.indeterminate_check_box_rounded),
                          
                          
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
                              medicalRecordModel!.reason!,
                              
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
                              medicalRecordModel!.orientationSpecialist!,
                              
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
                              "- "+medicalRecordModel!.orientationCause!,
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
                              medicalRecordModel!.orientationResponse!,
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
                 builder: (context) => PatientHomeScreeen(patientModel: widget.patientModel))); 
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
                builder: (context) => DisplayProfiletScreeen(patientModel: widget.patientModel)));

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
                builder: (context) => AppointmentsScreen(patientModel: widget.patientModel,)));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_rounded,color: Colors.redAccent[400],),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 20,color: Colors.redAccent[400]),
                ),
              onTap: (){
                ApiProvider.userlogout(token: widget.patientModel.token!).then((value) {
                  if(value.statusCode==200){
                      print(widget.patientModel.token);
                      print('logout YOLO!!');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen())); 
                    }
                });
              },
            ),
          ],
        ),
      ),
    );
    }
    }
   
  
}