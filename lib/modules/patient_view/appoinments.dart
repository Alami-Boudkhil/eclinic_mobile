import 'dart:convert';
import 'package:eclinic_mobile/models/patient_model.dart';
import 'package:eclinic_mobile/models/appointment_model.dart';
import 'package:eclinic_mobile/shared/api_provider.dart';
import 'package:eclinic_mobile/shared/components.dart';
import 'package:eclinic_mobile/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatefulWidget{

  PatientModel patientModel;
  AppointmentsScreen({required this.patientModel});
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
   
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  
  List <Appointmentmodel> appointments = [];
  @override
  void initState() {
   
    super.initState();
    ApiProvider.getPatientAppointments(token:widget.patientModel.token!).then(
      (value) {
        if(value.statusCode==200){
          List<dynamic> responseData = jsonDecode(value.body);
          for (var i=0;i<responseData.length;i++){
            print("YOLO");
            Appointmentmodel appointmentmodel= new Appointmentmodel(
              id: 0,
              loggedBy: " ",
              approved: false,
              description: " ",
              date: " ",
              comment: " ",
              status: " ",
            ) ;
            appointmentmodel.fromJson(responseData[i]);
            appointments.add(appointmentmodel);
             print(appointments[0].description);

          }
        }else{
          print('error');
          print(value.body);
        }
        setState(() {
          
        });
      }
       
    );
  }
  @override
  Widget build(BuildContext context) {
    if(appointments==[]){
      return Scaffold(
        body: Center(
          child: TextButton(
            onPressed: (){
              setState(() {
                
              });
            },
            child: Text('try again'),
          ),
        ),
      );
    }else{
    return Scaffold(
      appBar: AppBar(
        iconTheme:  IconThemeData(color: Colors.black),
        elevation: 8.00,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Appointments',
          style: GoogleFonts.roboto(fontSize: 26, color: Colors.black),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            onPressed: (){}, 
            icon: Icon(Icons.notification_important_rounded)),
          SizedBox(width: 8,),
        ]
      ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children:[ 
            
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: appointments.length,
                  itemBuilder: (context, index) => buildAppointmentItem(appointments[index]),
                  separatorBuilder: (context, index) => Divider(height: 20, color: Colors.grey, thickness: 4,), 
                  
                  ),
            ),
          ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: ()=>showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: CircleAvatar(
                                radius: 12,
                                child: Icon(Icons.close),
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Make a new appointment',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(fontWeight:FontWeight.w800,fontSize: 20),
                                ),
                                const SizedBox(height: 20,),
                                defaultFormField(
                                  raduis: 20,
                                  controller: descriptionController, 
                                  type: TextInputType.text, 
                                  label: "Add description"
                                ),
                                const SizedBox(height: 20,),
                                defaultFormField(
                                  raduis: 20,
                                  controller: dateController, 
                                  type: TextInputType.datetime, 
                                  label: "select a date ",
                                  prefix: Icons.calendar_today_rounded,
                                  readOnly: true,
                                  onTap: ()async{
                                    DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(), 
                                      firstDate: DateTime.now(), 
                                      lastDate: DateTime(2100)
                                    );
                                    if(picked!=null){
                                      setState(() {
                                        dateController.text=DateFormat('yyyy-MM-dd').format(picked);
                                      });
                                    }
                                  },
                                  validate: (value){
                                    if(value.toString().isEmpty){
                                      return'date is required';
                                    }
                                    return null;
                                  }
                                ),
                                const SizedBox(height: 20,),
                                defaultFormField(
                                  raduis: 20,
                                  controller: timeController, 
                                  type: TextInputType.datetime, 
                                  label: "select a time",
                                  prefix: Icons.watch_rounded,
                                  readOnly: true,
                                  onTap: ()async{
                                    TimeOfDay? time  = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if(time!=null){
                                      setState(() {
                                        timeController.text=time.hour.toString()+':'+time.minute.toString();
                                      });
                                    }
                                  },
                                  validate: (value){
                                    if(value.toString().isEmpty){
                                      return'time is required';
                                    }
                                    return null;
                                  }
                                ),
                                const SizedBox(height: 20,),
                                defaultButton(
                                  function: (){
                                    if(formKey.currentState!.validate()){
                                      ApiProvider.createPatientAppointment(
                                        token: widget.patientModel.token!, 
                                        description: descriptionController.text, 
                                        date: dateController.text+' '+timeController.text).then(
                                          (value) {
                                            if(value.statusCode==201){
                                              print('YOLO');
                                              Map<String,dynamic> responseData = jsonDecode(value.body);
                                              Appointmentmodel appointmentmodel= new Appointmentmodel(
                                                id: 0,
                                                loggedBy: " ",
                                                approved: false,
                                                description: " ",
                                                date: " ",
                                                comment: " ",
                                                status: " ",
                                              ) ;
                                              appointmentmodel.fromJson(responseData);
                                              appointments.add(appointmentmodel);
                                              Navigator.of(context).pop();
                                             
                                            }else{
                                              print("error");
                                              print(value.body);
                                            }
                                          });

                                          setState(() {
                                            
                                          });
                                    }
                                  }, 
                                  text: "request",
                                  radius: 20
                                )
                            
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ),
                child: Icon(Icons.plus_one_rounded),
                ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: ()=>showDialog(
                  context: context,
                  builder: (BuildContext context) => buildPopupDialog(
                    context, 
                    title: 'your calendar', 
                    msg: 'your calendar with your appointments'
                  )
                ),
                child: Icon(Icons.calendar_today_rounded),
                ),
            ),

          ]
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
                // Navigator.push(
                // context,
                // MaterialPageRoute(
                //  builder: (context) => PatientHomeScreeen(patientModel: widget.patientModel))); 
              },
            ),
            ListTile(
              leading: Icon(Icons.person,color: Colors.green[600]),
              title: Text(
                'Your Profile',
                style: TextStyle(fontSize: 20,color: Colors.green[600]),
                ),
              onTap: (){
                // Navigator.push(
                // context,
                // MaterialPageRoute(
                // builder: (context) => DisplayProfiletScreeen(patientModel: patientModel)(patientModel: widget.patientModel)));

              },
            ),
            ListTile(
              leading: Icon(Icons.date_range_rounded,color: Colors.green[600]),
              title: Text(
                'Appointments',
                style: TextStyle(fontSize: 20,color: Colors.green[600]),
                ),
              onTap: (){
                // Navigator.push(
                // context,
                // MaterialPageRoute(
                // builder: (context) => AppointmentsScreen()));
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


  Widget buildAppointmentItem(Appointmentmodel appointmentmodel) => 
    InkWell(
      onTap: (){
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Column(
              
              children:[ 
              Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      radius: 12,
                      child: Icon(Icons.close),
                        backgroundColor: Colors.red,
                    ),
                  ),
                ),
              const SizedBox(height: 8,),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [                    
                    Text(
                      'Appointment number: '+appointmentmodel.id.toString(),
                      style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w500),
                    ),
                    Divider(height: 10 ,color:Colors.blueGrey, thickness: 4,),
                    Text(
                      'Description:',
                      style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      appointmentmodel.description,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18 ),
                    ),
                    Divider(height: 10 ,color:Colors.blueGrey, thickness: 4,),
                    Text(
                      'Comment:',
                      style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8,),
                    appointmentmodel.comment==null?Text(" ") 
                      :Text(
                     appointmentmodel.comment!,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18 ),
                    ),
                    Divider(height: 10 ,color:Colors.blueGrey, thickness: 4,),
                    Text(
                      'Date:',
                      style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      appointmentmodel.date.split("T")[0],
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Hour: ',
                      style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w500),
                    ),
                    Text(   
                      appointmentmodel.date.split("T")[1],
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(height: 10 ,color:Colors.blueGrey, thickness: 4,),
                    Text(
                      'Status:',
                      style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      appointmentmodel.status,
                      style: TextStyle(fontSize: 18 ),
                    ),
              
              
              
              
              
                  ],
                ),
              ),
              ]
            ),
          )
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.teal[200],
            radius: 25,
            child: Icon(Icons.date_range_rounded),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date:',
                style: GoogleFonts.roboto(fontWeight:FontWeight.w600,fontSize: 20)
              ),
              Text(
                appointmentmodel.date.split("T")[0],
                style: GoogleFonts.roboto(fontWeight:FontWeight.w400,fontSize: 18),
              ),
            ],
          ),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status:',
                style: GoogleFonts.roboto(fontWeight:FontWeight.w600,fontSize: 20)
              ),
              Row(
                children: [
                  Text(
                    appointmentmodel.status,
                    style: GoogleFonts.roboto(fontWeight:FontWeight.w300,fontSize: 18),
                  ),
                  // Icon(Icons.check_box_rounded , color: Colors.green,),
                  // Icon(Icons.indeterminate_check_box_rounded , color: Colors.red,)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  
  
}