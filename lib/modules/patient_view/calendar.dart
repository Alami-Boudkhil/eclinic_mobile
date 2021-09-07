import 'package:eclinic_mobile/models/appointment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';



class PatientCalendar extends StatefulWidget{
  
  final List<Appointmentmodel> appointments;

  PatientCalendar({required this.appointments});

  @override
  _PatientCalendarState createState() => _PatientCalendarState();
}

class _PatientCalendarState extends State<PatientCalendar> {

  List<DateTime> pendingAppointments=[];
  List<DateTime> acceptedAppointments=[];
  List<DateTime> refusedAppointments=[];

  
  
  @override
  Widget build(BuildContext context) {
    for (var i=0;i<widget.appointments.length;i++ ){
      if((widget.appointments[i].status=="new")|(widget.appointments[i].status=="in_progress")){
        pendingAppointments.add(DateTime.parse(widget.appointments[i].date));
      }else if(widget.appointments[i].status=="completed"){
        acceptedAppointments.add(DateTime.parse(widget.appointments[i].date));
      }else{
        refusedAppointments.add(DateTime.parse(widget.appointments[i].date));
      }
    }
    print(widget.appointments.length);
    print(pendingAppointments.length);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.black,
          onPressed: (){
            Navigator.pop(context);
            pendingAppointments=[];
            acceptedAppointments=[];
            refusedAppointments=[];
            },
        ),
        centerTitle: true,
        title: Text(
          'Your Calendar',
          style: TextStyle(fontSize:20,color: Colors.black ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.tealAccent[100]
          ),
          height: 400,
          width:250,
          child: SfDateRangePicker(
            initialSelectedDates: acceptedAppointments,
            selectionColor: Colors.green,
            selectionMode:DateRangePickerSelectionMode.multiple ,

            
          ),
        ),
      ),

    );
    
  }
  
}