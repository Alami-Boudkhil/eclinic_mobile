import 'dart:convert';

import 'package:http/http.dart' as http;





class ApiProvider{


  static String baseUrl = 'http://10.0.2.2:8000/';

  static Future userlogin({required String email,required String password})async{

    Uri url=Uri.parse(baseUrl+'rest-auth/login/'); 

    var data = {
    "username": "",
    "email": email,
    "password": password,
    };

    final http.Response response= await  http.post(url,headers:{ "Accept": "application/json","content-type": "application/json"
      } ,body: json.encode(data));

    return response;
  }
  
  static Future usersignup( { 
    String? password1,
    String? password2,
    String? firstName,
    String? lasttName,
    String? sex,
    String? email,
    String? phone,
    String? dateOfBirth,
    String? city,
    String? address,
    String? type,
    String? educationLevel,
  }
  ) async {

    Uri url=Uri.parse(baseUrl+'rest-auth/registration/');

    var data = {
      "user": {
        "password1": password1,
        "password2": password2,
        "last_login": null,
        "is_superuser": false,
        "first_name": firstName,
        "last_name": lasttName,
        "is_active": false,
        "date_joined": DateTime.now().toString(),
        "sex": sex,
        "email":email,
        "role": "Patient",
        "image": null,
        "phone": phone,
        "date_of_birth": dateOfBirth,
        "city": city,
        "address": address,
        "is_confirmed": false
      },
      "type": type,
      "education_level": educationLevel,
      "is_approved": false,
    };

    final http.Response response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
      body: json.encode(data));
     
    return response; 

  }
  

  
  static Future userlogout({required String token})async{

    Uri url=Uri.parse(baseUrl+'rest-auth/logout/'); 

    var data = {
    "key":token,

    };

    final http.Response response= await  http.post(url,headers:{ "Accept": "application/json","content-type": "application/json"
      } ,body: json.encode(data));

    return response;
}

  static Future userGet({required String token})async{

    Uri url = Uri.parse(baseUrl+'rest-auth/user/');

    final http.Response response = await http.get(
      url,
      headers: {"Authorization":"token "+token,}
      );

    return response;
  }

  static Future userUpdate({ 
      required String token,
      String? firstName,
      String? lasttName,
      String? sex,
      String? email,
      String? phone,
      String? dateOfBirth,
      String? city,
      String? address,
      String? type,
      String? educationLevel,
    }
  )async{

    Uri url = Uri.parse(baseUrl+'rest-auth/user/');

    var data = {
      //"uid": "a8d5ae59-700b-4e06-bfed-200ea0c17171",
      "patient": {
        //"pid": widget.patientModel.pid,
        //"deleted": null,
        "type": type,
        "education_level":educationLevel,
        //"is_approved": false
      },
      //"last_login": "2021-08-19T12:23:05.723842Z",
      //"is_superuser": false,
      "first_name": firstName,
      "last_name": lasttName,
      //"is_active": true,
      //"date_joined": "2021-08-17T23:12:45.171997Z",
      //"deleted": null,
      "sex": sex,
      "email":email,
      //"role": "Patient",
      //"image": null,
      "phone": phone,
      "date_of_birth": dateOfBirth,
      "city": city,
      "address": address,
      //"is_confirmed": false,
      //"created_on": "2021-08-17T23:12:45.172284Z"
    };

    final http.Response response = await http.put(
      url,
      headers: {'Authorization':"token "+token,"content-type": "application/json",},
      body: jsonEncode(data)
      );

    return response;
  }

  static Future getMedicalRecord({required String token})async{

    Uri url=Uri.parse(baseUrl+'api-medical/patient_medical_record/'); 
    
    
    final http.Response response = await http.get(
      url,
      headers: {"Authorization":"token "+token,}
      );

    return response;
  }
}