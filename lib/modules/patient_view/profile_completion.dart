
import 'dart:io';

import 'package:eclinic_mobile/modules/auth/login/login_screen.dart';
import 'package:eclinic_mobile/shared/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:eclinic_mobile/shared/components.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';


class PatienProfiletScreeen extends StatefulWidget {
  String email;
  String password1;
  String password2;

  PatienProfiletScreeen(
      {required this.email, required this.password1, required this.password2});
  @override
  _PatienProfiletScreeenState createState() => _PatienProfiletScreeenState();
}


class _PatienProfiletScreeenState extends State<PatienProfiletScreeen> {
  Object? _groupValue = -1;
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
  String selectedType = 'ATP';
  List<String> selectedElList = [];
  String? selectedEL = 'NONE';
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String userSex='Male';
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateBirthController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();

  File? image;
  Future getimagefrom(imagesource)async{
    try{final image = await ImagePicker().pickImage(source: imagesource);
    
    if (image==null) return null;
    setState(() {
      this.image= File(image.path);
    });}on PlatformException catch(e){

      print('failed loading image with error: $e');
    }
    
  }

  @override
  Widget build(BuildContext context) {
    emailController.text=widget.email;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person,color: Colors.black,size:35),
        elevation: 8.00,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'complete your profile',
          style: GoogleFonts.oswald(color: Colors.black,fontSize: 28),
        ),
        
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
                      image!=null? 
                      CircleAvatar(backgroundImage :new  FileImage(image!),radius: 60,):
                      CircleAvatar(backgroundImage: AssetImage('assets/images/default_profile.png'), radius: 60,),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo_rounded,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context, 
                              builder: (BuildContext context){
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading:Icon(Icons.camera),
                                      title: Text('camera'),
                                      onLongPress: (){
                                        Navigator.pop(context);
                                        getimagefrom(ImageSource.camera);
                                      },
                                    ),
                                    ListTile(
                                      leading:Icon(Icons.folder_open_rounded),
                                      title: Text('gallery'),
                                      onLongPress: (){
                                        Navigator.pop(context);
                                        getimagefrom(ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                );
                              }
                            );
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
                            controller: firstNameController,
                            type: TextInputType.text,
                            label: 'First Name',
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
                          width: 20,
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: 0,
                            groupValue: _groupValue,
                            title: Text("Male"),
                            onChanged: (newValue) =>
                                setState(()  {_groupValue = newValue;userSex='Male';}),
                            activeColor: Colors.blueAccent,
                            selected: false,
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
                            selected: false,
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
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          readOnly: true,
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
                      padding: const EdgeInsetsDirectional.only(end: 200),
                      child: defaultFormField(
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
                          'Select Your Type:',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 15,
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
                                selectedEL = '1CPI';
                              } else {
                                selectedElList = teacherEL;
                                selectedEL = 'MA-A';
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
                          'You Eduational Level:',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 15,
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
                            ApiProvider.usersignup(
                              password1:widget.password1 ,
                              password2: widget.password2,
                              firstName: firstNameController.text,
                              lasttName: lastNameController.text,
                              sex: userSex,
                              email: emailController.text,
                              phone: phoneNumberController.text,
                              dateOfBirth: dateBirthController.text,
                              city: cityController.text,
                              address: addressController.text,
                              type: selectedType,
                              educationLevel: selectedEL,
                            ).then((value){
                              
                            if (value.statusCode == 201) {
                          
                              print('SignUp YOLO!!');
                              print(value.body);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => buildPopupDialog(
                                  context,title:'Sign UP completed, Welcome',
                                  msg: 'A confirmation Email was sent to you ,please verify your email and login again',),
                              );
                            }else {
                              print(value.body);
                              print('error');
                              final snackBar = SnackBar(content: Text(value.body));   
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }

                            });
                          }
                        },
                        text: 'complete your profile',
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
    );
  }
}
