import 'dart:collection';

import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color? background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  double sizeoftext= 20.00,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed:() {function();},
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: sizeoftext,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );



Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  ValueChanged? onChange,
  bool isPassword = false,
  FormFieldValidator? validate,
  required String label,
  required IconData prefix,
  IconButton? suffix,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? suffix : null,
    border: OutlineInputBorder(),
  ),
);




Widget buildPopupDialog(
  BuildContext context,
  {required String title,
  required String msg}
  ) 
  {
  return  AlertDialog(
    title: Text(title,),
    content:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$msg"),
      ],
    ),
    actions:[TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'Close',
          style: TextStyle(color: Colors.blue),),
      ),
    ],
  );
  }