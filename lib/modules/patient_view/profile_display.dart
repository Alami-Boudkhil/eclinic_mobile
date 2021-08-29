import 'dart:convert';
import 'dart:io';
import 'package:eclinic_mobile/models/patient_model.dart';
import 'package:eclinic_mobile/shared/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:eclinic_mobile/shared/components.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:eclinic_mobile/modules/patient_view/home_screen.dart';
import 'package:eclinic_mobile/modules/patient_view/medical_record.dart';
import 'package:eclinic_mobile/modules/patient_view/appoinments.dart';
import 'package:eclinic_mobile/welcome_screen.dart';
import 'package:intl/intl.dart';


class DisplayProfiletScreeen extends StatefulWidget {
  PatientModel patientModel;
  

  DisplayProfiletScreeen(
      { required this.patientModel});
  @override
  _DisplayProfiletScreeenState createState() => _DisplayProfiletScreeenState();
}

class _DisplayProfiletScreeenState extends State<DisplayProfiletScreeen> {
  Object? _groupValue;
  var formKey = GlobalKey<FormState>();
  

  List<String> types = ['ATP', 'Student', 'Teacher'];
  List<String> atpEL = ['NONE'];
  List<String> studentEL = [
    '1CPI',
    '2CPI',
    '1CS',
    '2CS-ISI',
    '2CS-SIW',
    '3CS-ISI',
    '3CS-SIW'
  ];
  List<String> teacherEL = ['MA-A', 'MA-B', 'MC-A', 'MC-B', 'Professor'];
  String? selectedType;
  List<String> selectedElList = [];
  String? selectedEL;


  var firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String userSex='Male';
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateBirthController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();


  bool editFirstName=false;
  bool editLastName=false;
  bool editEmail=false;
  bool editPhoneNumber=false;
  bool editCity=false;
  bool editAddress=false;
  
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      ApiProvider.userGet(token:widget.patientModel.token!).then((value) {
        
        if(value.statusCode==200){

         print('YOLO get user');
         Map<String,dynamic> userDetails=jsonDecode(value.body);
      
         widget.patientModel.pid=userDetails['patient']['pid'];
         widget.patientModel.firstName=userDetails['first_name'];
         widget.patientModel.lastName=userDetails['last_name'];
         widget.patientModel.sex=userDetails['sex'];
         widget.patientModel.email=userDetails['email'];
         widget.patientModel.phoneNumber=userDetails['phone'];
         widget.patientModel.dateOfBirth=userDetails['date_of_birth'];
         widget.patientModel.city=userDetails['city'];
         widget.patientModel.address=userDetails['address'];
         widget.patientModel.type=userDetails['patient']['type'];
         widget.patientModel.educationalLevel=userDetails['patient']['education_level'];
      
         //print(selectedEL);
         //print(selectedType);
    

        }else{
          print('error');
          print(value.body);
        }

        firstNameController.text=widget.patientModel.firstName!;
        lastNameController.text=widget.patientModel.lastName!;
        userSex=widget.patientModel.sex!;
        _groupValue= userSex=='Male'?0:1;
        emailController.text=widget.patientModel.email;
        phoneNumberController.text=widget.patientModel.phoneNumber!;
        dateBirthController.text=widget.patientModel.dateOfBirth!;
        cityController.text=widget.patientModel.city!;
        addressController.text=widget.patientModel.address!;

        selectedType=widget.patientModel.type!;
      
        selectedEL=widget.patientModel.educationalLevel!;
        //print(selectedType);
        //print(selectedEL);
    });
    });
     
    return Scaffold(
      appBar: AppBar(
        iconTheme:  IconThemeData(color: Colors.black),
        elevation: 8.00,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Your Profile',
          style: GoogleFonts.oswald(color: Colors.black,fontSize: 28),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: (){}, 
            icon: Icon(Icons.notification_important_rounded)),
          SizedBox(width: 8,),
          
        ],
        
      ),
      body: Form(
        key:formKey ,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(children: [
                      CircleAvatar(
                        radius: 60.00,
                        foregroundImage:
                            AssetImage('assets/images/default_profile.png'),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo_outlined,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            ImagePicker();
                          },
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 40.00,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defaultFormField(
                            suffix: IconButton(
                              onPressed: (){
                                setState(() {
                                  editFirstName= !editFirstName;
                                });
                              }, 
                              icon: Icon(Icons.edit)),
                            controller: firstNameController,
                            type: TextInputType.text,
                            label: 'First Name',
                            readOnly: editFirstName,
                            validate: (value){
                              if(value.toString().isEmpty){
                               return'First Name is required';
                              }
                              return null;
                            }
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: defaultFormField(
                            suffix: IconButton(
                              onPressed: (){
                                setState(() {
                                  editLastName= !editLastName;
                                });
                              }, 
                              icon: Icon(Icons.edit)),
                            readOnly: editLastName,  
                            controller: lastNameController,
                            type: TextInputType.text,
                            label: 'Last Name',
                            validate: (value){
                              if(value.toString().isEmpty){
                               return'Last Name is required';
                              }
                              return null;
                            }
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'sex:',
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: 0,
                            groupValue: _groupValue,
                            title: Text("Male"),
                            onChanged: (newValue) =>
                                setState(()  {_groupValue = newValue;userSex='Male';}),
                            activeColor: Colors.blueAccent,
                            selected: userSex=='Male',
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: 1,
                            groupValue: _groupValue,
                            title: Text("Female"),
                            onChanged: (newValue) =>
                                setState(() {_groupValue = newValue;userSex='Female';}),
                            activeColor: Colors.blueAccent,
                            selected: userSex=='Female',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 50),
                      child: defaultFormField(
                          suffix: IconButton(
                              onPressed: (){
                                setState(() {
                                  editEmail= !editEmail;
                                });
                              }, 
                              icon: Icon(Icons.edit)),
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          readOnly: editEmail,
                          validate: (value){
                            if (value.toString().isEmpty) {
                            return 'Email must not be empty';
                            } else if (!value.toString().contains('@esi-sba')) {
                           return 'Only ESI-Sba emails are accepted';
                           }
                           return null;                           
                          }, 
                          label: 'email',
                          prefix: Icons.email_rounded,
                          
                          ),                          
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 50),
                      child: defaultFormField(
                        suffix: IconButton(
                              onPressed: (){
                                setState(() {
                                  editPhoneNumber= !editPhoneNumber;
                                });
                              }, 
                              icon: Icon(Icons.edit)),
                        readOnly: editPhoneNumber,
                        controller: phoneNumberController,
                        type: TextInputType.phone,
                        label: 'Phone number',
                        prefix: Icons.phone_android_rounded,
                        validate: (value){
                          if(value.toString().isEmpty){
                            return'Phone number is required';
                          }
                          return null;
                        }
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 50),
                      child: defaultFormField(
                        
                        controller: dateBirthController,
                        type: TextInputType.datetime,
                        label: 'date ofbirth',
                        prefix: Icons.calendar_today_rounded,
                        readOnly: true,
                        onTap: ()async{
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), 
                              firstDate: DateTime(1920), 
                              lastDate: DateTime(2100)
                              );
                            if(picked!=null){
                              setState(() {
                              dateBirthController.text=DateFormat('yyyy-MM-dd').format(picked);
                              });
                            }
                        },
                        validate: (value){
                          if(value.toString().isEmpty){
                            return'date of birth is required';
                          }
                          return null;
                        }
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 150),
                      child: defaultFormField(
                        suffix: IconButton(
                              onPressed: (){
                                setState(() {
                                  editCity= !editCity;
                                });
                              }, 
                              icon: Icon(Icons.edit)),
                        readOnly: editCity,
                        controller: cityController,
                        type: TextInputType.number,
                        label: 'city',
                        prefix: Icons.location_city_rounded,
                        validate: (value){
                          if(value.toString().isEmpty){
                            return'city is required';
                          }
                          else if(value.toString().length>2){
                            return' matricule too long';
                          }else if(int.parse(value.toString())>48){
                            return 'matricule less then 48';
                          }
                          return null;
                        }
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 50),
                      child: defaultFormField(
                        suffix: IconButton(
                              onPressed: (){
                                setState(() {
                                  editAddress= !editAddress;
                                });
                              }, 
                              icon: Icon(Icons.edit)),
                        readOnly: editAddress,
                        controller: addressController,
                        type: TextInputType.text,
                        label: 'Address',
                        prefix: Icons.home_rounded,
                        validate: (value){
                          if(value.toString().isEmpty){
                            return'Address is required';
                          }
                          return null;
                        }
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Your Type:',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        DropdownButton(
                          style:
                              const TextStyle(fontSize: 18, color: Colors.blue),
                          underline: Container(
                            height: 2,
                            color: Colors.blueAccent,
                          ),
                          elevation: 20,
                          value: selectedType,
                          onChanged: (newValue) {
                            setState(() {
                              selectedType = newValue.toString();
                              if (selectedType == 'ATP') {
                                selectedElList = atpEL;
                                selectedEL = 'NONE';
                              } else if (selectedType == 'Student') {
                                selectedElList = studentEL;
                                selectedEL = '1-CPI';
                              } else {
                                selectedElList = teacherEL;
                                selectedEL ='MA-A';
                              }
                            });
                          },
                          items: types.map((String type) {
                            return new DropdownMenuItem<String>(
                              value: type,
                              child: new Text(type),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Your Eduational Level:',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        DropdownButton(
                          style:
                              const TextStyle(fontSize: 18, color: Colors.blue),
                          underline: Container(
                            height: 2,
                            color: Colors.blueAccent,
                          ),
                          elevation: 20,
                          value: selectedEL,
                          onChanged: (newValue) {
                            setState(() {
                              selectedEL = newValue.toString();
                            });
                          },
                          items: selectedElList.map((String type) {
                            return new DropdownMenuItem<String>(
                              value: type,
                              child: new Text(type),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    defaultButton(
                        function: () {
                          if(formKey.currentState!.validate()){
                           
                             ApiProvider.userUpdate(
                                token: widget.patientModel.token!,
                                firstName: firstNameController.text,
                                lasttName: lastNameController.text,
                                sex:userSex,
                                email: emailController.text,
                                phone: phoneNumberController.text,
                                dateOfBirth: dateBirthController.text,
                                city: cityController.text,
                                address: addressController.text,
                                type: selectedType,
                                educationLevel: selectedEL,
                             ).then((value){
                                  if(value.statusCode==200){
                                    print('YOLO');
                                    print(value.body);
      
                                  }else{
                                    print('error');
                                    print(value.body);
                                  }
                             });
                           
                          }
                        },
                        text: 'update',
                        radius: 20,
                        //width: 300,
                        background: Colors.blue[800]),
                  ],
                ),
              ),
            ),
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
              leading: Icon(Icons.description_rounded,color: Colors.green[600]),
              title: Text(
                'Medical record',
                style: TextStyle(fontSize: 20,color: Colors.green[600]),
                ),
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => MedicalRecordcreen(patientModel: widget.patientModel)));

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
                      print(widget.patientModel.token!);
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
