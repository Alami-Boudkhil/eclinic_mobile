import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
 import 'package:http_parser/http_parser.dart';




class ApiProvider{


  static String baseUrl ='http://192.168.43.157:8000/'; //'http://10.0.2.2:8000/'; 

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

  static Future getUserUid({required String token})async{

    Uri url = Uri.parse(baseUrl+'rest-auth/user/');

    final http.Response response = await http.get(
      url,
      headers: {"Authorization":"token "+token,}
      );

    if(response.statusCode==200){
      Map<String,dynamic> userDetails=jsonDecode(response.body);

      return userDetails['uid'];
    }else {
      return "error";
    }
  }
  static Future getUserImage({required String token}) async{
    Uri url = Uri.parse(baseUrl+'rest-auth/user/');

    final http.Response response = await http.get(
      url,
      headers: {"Authorization":"token "+token,}
      );

    if(response.statusCode==200){
      Map<String,dynamic> userDetails=jsonDecode(response.body);

      return userDetails['image'];
    }else {
      return "error";
    }
  }

  static Future userUpdate({ 
      required String token,
      String imagePath = "no image",
      String? firstName,
      String? lasttName,
      String? sex,
      String? phone,
      String? dateOfBirth,
      String? city,
      String? address,
      
    }
  )async{

    Uri url = Uri.parse(baseUrl+'rest-auth/user/');
      

    var request = http.MultipartRequest('PATCH', url)
    
    ..fields['first_name'] = firstName!
    ..fields['last_name'] = lasttName!
    ..fields['sex'] = sex!
    ..fields['phone'] = phone!
    ..fields['date_of_birth'] = dateOfBirth!
    ..fields['city'] = city!
    ..fields['address'] = address!;

    if(imagePath!="no image"){
    request.files.add(await http.MultipartFile.fromPath(
      'image', imagePath,
      contentType: MediaType('image','jpg')));
    }
    request.headers.addAll({"Authorization":"token "+token,});
    http.Response response = await http.Response.fromStream(await request.send());

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

  static Future getPatientAppointments({required String token})async{

    Uri url = Uri.parse(baseUrl+'api-appointment/patient-appointments/');

    final http.Response response = await http.get(
      url,
      headers: { "Authorization":"token "+token}
    );

    return response;

  }

  static Future createPatientAppointment(
    {required String token,
    required String description,
    required String date ,
    }
  )async{
    Uri url = Uri.parse(baseUrl+'api-appointment/patient-appointments/');

    var data ={      
        "description": description,  
        "date": date
        }; 
    final http.Response response = await http.post(
      url,
      headers: {"Accept": "application/json","content-type": "application/json", "Authorization":"token "+token},
      body: jsonEncode(data)
    );
    return response;
  }
}