import 'package:flutter/material.dart';
import 'package:eclinic_mobile/welcome_screen.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:pusher_beams/pusher_beams.dart';

void main() async{
  try
 { await PusherBeams.start('bf43c259-1895-47cd-83cf-82461abe58b5');
 }on Exception catch(e){
   print("pusherstart error: $e");
 }
  
  
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

