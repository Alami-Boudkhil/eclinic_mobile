import 'dart:convert';
import 'dart:io';
import 'package:eclinic_mobile/models/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:eclinic_mobile/shared/components.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:eclinic_mobile/modules/patient_view/home_screen.dart';
import 'package:intl/intl.dart';


class DisplayProfiletScreeen extends StatefulWidget {
  PatientModel patientModel;
  String password1;
  String? password2;

  DisplayProfiletScreeen(
      { required this.patientModel,  required this.password1,  this.password2});
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
  
  
  Future userGet()async{
    
    Uri url = Uri.parse('http://10.0.2.2:8000/rest-auth/user/');
    String cookie=widget.patientModel.cookie!;
    String? sessionid;
    if (cookie.contains('sessionid')) {
    List at = RegExp(r'(sessionid)(.*?)[^;]+').stringMatch(cookie)!.split('=');
    sessionid = at[1];
  }
    print(widget.patientModel.cookie);
    print(widget.patientModel.token);
    print(sessionid);
    final http.Response response = await http.get(
      url,
      headers: {'Authorization':widget.patientModel.token!,'Cookie': 'sessionid=$sessionid;'}
      );

    if(response.statusCode==200){

      print('YOLO');
      Map<String,dynamic> userDetails=jsonDecode(response.body);
      
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
      print(response.body);
    }
  }

  Future userUpdate() async{

    Uri url = Uri.parse('http://10.0.2.2:8000/rest-auth/user/');
    String cookie=widget.patientModel.cookie!;
    String? sessionid;
    String?csrfToken;
    if (cookie.contains('sessionid')) {
    List at = RegExp(r'(sessionid)(.*?)[^;]+').stringMatch(cookie)!.split('=');
    sessionid = at[1];
    }
    if (cookie.contains('csrftoken')) {
    List at = RegExp(r'(csrftoken)(.*?)[^;]+').stringMatch(cookie)!.split('=');
    csrfToken = at[1];
    }
    
    print(csrfToken);
    var data = {
    //"uid": "a8d5ae59-700b-4e06-bfed-200ea0c17171",
    "patient": {
        "pid": widget.patientModel.pid,
        //"deleted": null,
        "type": widget.patientModel.type,
        "education_level": widget.patientModel.educationalLevel,
        //"is_approved": false
    },
    //"last_login": "2021-08-19T12:23:05.723842Z",
    //"is_superuser": false,
    "first_name": "alami",
    "last_name": "boudkhil",
    //"is_active": true,
    //"date_joined": "2021-08-17T23:12:45.171997Z",
    //"deleted": null,
    "sex": widget.patientModel.sex,
    "email":widget.patientModel.email,
    //"role": "Patient",
    //"image": null,
    "phone": widget.patientModel.phoneNumber,
    "date_of_birth": widget.patientModel.dateOfBirth,
    "city": widget.patientModel.city,
    "address": widget.patientModel.address,
    //"is_confirmed": false,
    //"created_on": "2021-08-17T23:12:45.172284Z"
};
    final http.Response response = await http.put(
      url,
      headers: {'Authorization':widget.patientModel.token!,"content-type": "application/json",'Cookie': 'csrftoken=$csrfToken;sessionid=$sessionid;','X-CSRFToken':csrfToken!},
      body: jsonEncode(data)
      );
    
    if(response.statusCode==200){
      print('YOLO');
      print(response.body);
      
    }else{
      print('error');
      print(response.body);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    setState(() {
      userGet().then((value) {
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
      print(selectedType);
      print(selectedEL);
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
                      padding: const EdgeInsetsDirectional.only(end: 200),
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
                           setState(() {
                             userUpdate();
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
          ],
        ),
      ),
    );
  }
}
