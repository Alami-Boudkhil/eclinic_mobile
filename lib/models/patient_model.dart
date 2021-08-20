
import 'package:flutter/cupertino.dart';

class PatientModel{
  String? pid;
  String? token;
  String? cookie;
  String? firstName;
  String? lastName;
  String? sex;
  String email;
  Image? image;
  String? phoneNumber;
  String? dateOfBirth;
  String? city;
  String? address;
  String? type;
  String? educationalLevel;


  PatientModel(
    {
    this.pid,
    this.token,
    this.cookie,
    this.firstName,
    this.lastName,
    this.sex,
    required this.email,
    this.image,
    this.phoneNumber,
    this.dateOfBirth,
    this.city,
    this.address,
    this.type,
    this.educationalLevel,
    }
  );

  PatientModel? fromJson(Map<String, dynamic> json) {
    pid=json['pid'];
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
    data['pid']=this.pid;
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