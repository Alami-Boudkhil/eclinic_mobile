
import 'package:flutter/cupertino.dart';

class PatientModel{
  String firstName;
  String lastName;
  String sex;
  String email;
  Image image;
  String phoneNumber;
  DateTime dateOfBirth;
  int city;
  String address;
  String type;
  String educationalLevel;


  PatientModel(
    {required this.firstName,
    required this.lastName,
    required this.sex,
    required this.email,
    required this.image,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.city,
    required this.address,
    required this.type,
    required this.educationalLevel,
    }
  );

  PatientModel? fromJson(Map<String, dynamic> json) {
    firstName= json['first_name'];
    lastName= json['last_name'];
    sex= json['sex'];
    email=json['email'];
    image=json['image'];
    phoneNumber=json['phone'];
    dateOfBirth=json['date_of_birth'];
    city=json['city'];
    address=json['address'];
    type=json['type'];
    educationalLevel=json['education_level'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name']=this.firstName;
    data['last_name']=this.lastName;
    data['sex']=this.sex;
    data['email']=this.email;
    data['image']=this.image;
    data['phone']=this.phoneNumber;
    data['date_of_birth']=this.dateOfBirth;
    data['city']=this.city;
    data['address']=this.address;
    data['type']=this.type;
    data['education_level']=this.educationalLevel;

    return data;
  }
}