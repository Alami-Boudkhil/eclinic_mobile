

import 'package:eclinic_mobile/models/patient_model.dart';
import 'package:eclinic_mobile/modules/patient_view/profile_display.dart';
import 'package:eclinic_mobile/shared/api_provider.dart';
import 'package:eclinic_mobile/shared/components.dart';
import 'package:eclinic_mobile/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentsScreen extends StatefulWidget{

  PatientModel patientModel;
  AppointmentsScreen({required this.patientModel});
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        iconTheme:  IconThemeData(color: Colors.black),
        elevation: 8.00,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Appointments',
          style: GoogleFonts.oswald(color: Colors.black,fontSize: 26),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children:[ 
            
            Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildAppointmentItem(),
                  separatorBuilder: (context, index) => Divider(height: 20, color: Colors.grey, thickness: 4,), 
                  itemCount: 25),
            ),
          ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: ()=>showDialog(
                  context: context,
                  builder: (BuildContext context) => buildPopupDialog(
                    context, 
                    title: 'Request an appointment form', 
                    msg: 'appointment form'
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


  Widget buildAppointmentItem() => 
    InkWell(
      onTap: (){
        showDialog(
          context: context,
          builder: (BuildContext context) => buildPopupDialog(
            context, 
            title: 'Appointment number n', 
            msg: 'informations about your appointments (your discription + dctr comment+status)'
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
                '2021-05-7',
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
                    'pending...',
                    style: GoogleFonts.roboto(fontWeight:FontWeight.w300,fontSize: 18),
                  ),
                  Icon(Icons.check_box_rounded , color: Colors.green,),
                  Icon(Icons.indeterminate_check_box_rounded , color: Colors.red,)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  
  
}