import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eclinic_mobile/shared/components.dart';
import 'package:eclinic_mobile/modules/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:eclinic_mobile/modules/patient_view/patient_profile.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isObsecure1 = true;
  bool isObsecure2 = true;

  Future usersignup() async {
    Uri url = Uri.parse('http://10.0.2.2:8000/rest-auth/registration/');

    var data = {
      "user": {
        "password1": passwordController.text,
        "password2": passwordConfirmationController.text,
        "last_login": null,
        "is_superuser": false,
        "first_name": "",
        "last_name": "",
        "is_active": false,
        "date_joined": DateTime.now().toString(),
        "sex": "Male",
        "email": emailController.text,
        "role": "Patient",
        "image": null,
        "phone": "",
        "date_of_birth": null,
        "city": "",
        "address": "",
        "is_confirmed": false
      },
      "type": "ATP",
      "education_level": "NONE",
      "is_approved": false,
    };

    final http.Response response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: json.encode(data));

    if (response.statusCode == 201) {
      //final Map<String, dynamic> responseData = json.decode(response.body);

      print('SignUp YOLO!!');
      print(response.body);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PatienProfiletScreeen(
                    response: response.body,
                    email: emailController.text,
                  )));
    } else {
      print(response.body);
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Image(
                      image: AssetImage('assets/images/shape.png'),
                    ),
                    Positioned(
                      width: 180,
                      top: 80.00,
                      left: 40.00,
                      child: Text(
                        'Hello',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.00,
                          fontWeight: FontWeight.w600,
                        ),
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                    ),
                    Positioned(
                      top: 110.00,
                      left: 40.00,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 30.00,
                        ),
                      ),
                    ),
                    Positioned(
                      height: 225.00,
                      width: 225.00,
                      top: 120.00,
                      left: 180.00,
                      child: Image(
                        image: AssetImage('assets/images/logoBW.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.00,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.00,
                  vertical: 20.00,
                ),
                child: defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email',
                  prefix: Icons.email_rounded,
                  validate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Email must not be empty';
                    } else if (!value.toString().contains('@esi-sba')) {
                      return 'Only ESI-Sba emails are accepted';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.00,
                  vertical: 20.00,
                ),
                child: defaultFormField(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  label: 'Password',
                  prefix: Icons.lock_clock_rounded,
                  isPassword: isObsecure1,
                  suffix: IconButton(
                    icon: isObsecure1
                        ? Icon(Icons.visibility_rounded)
                        : Icon(
                            Icons.visibility_off_rounded,
                          ),
                    onPressed: () {
                      setState(() {
                        isObsecure1 = !isObsecure1;
                      });
                    },
                  ),
                  validate: (value) {
                    if (value.toString().isEmpty) {
                      return 'password must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.00,
                  vertical: 20.00,
                ),
                child: defaultFormField(
                    controller: passwordConfirmationController,
                    type: TextInputType.visiblePassword,
                    label: 'Confirm Password',
                    prefix: Icons.lock_clock_rounded,
                    isPassword: isObsecure2,
                    suffix: IconButton(
                      icon: isObsecure2
                          ? Icon(Icons.visibility_rounded)
                          : Icon(
                              Icons.visibility_off_rounded,
                            ),
                      onPressed: () {
                        setState(() {
                          isObsecure2 = !isObsecure2;
                        });
                      },
                    ),
                    validate: (value) {
                      if (value.toString().isEmpty) {
                        return 'password confirmation required';
                      } else if (passwordController.text !=
                          passwordConfirmationController.text) {
                        return 'confirmation didn\'t match password';
                      }
                      return null;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.00,
                  vertical: 20.00,
                ),
                child: defaultButton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      usersignup();
                    }
                  },
                  text: 'sign Up',
                  radius: 20.00,
                  background: Colors.blue[800],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 18.00,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
