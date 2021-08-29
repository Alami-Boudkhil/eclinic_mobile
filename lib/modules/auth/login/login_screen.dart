import 'dart:convert';
import 'package:flutter/material.dart';
import "package:eclinic_mobile/shared/components.dart";
import "package:eclinic_mobile/shared/api_provider.dart";
import 'package:eclinic_mobile/modules/auth/sign_up/signup_screen.dart';
import 'package:eclinic_mobile/modules/patient_view/home_screen.dart';
import 'package:eclinic_mobile/models/patient_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  late PatientModel patientModel;
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Expanded(
                  child: Container(
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
                          left: 20.00,
                          child: Text(
                            'Welcome Back,',
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
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 30.00,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image(
                            width: 220,
                            height: 220,
                            image: AssetImage('assets/images/logoBW.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      
                      children: [
                        defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email',
                      prefix: Icons.email_rounded,
                      validate: (value) {
                        if (value.toString().isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      }),
                        defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      label: 'Password',
                      prefix: Icons.lock_clock_rounded,
                      isPassword: isObsecure,
                      suffix: IconButton(
                        icon: isObsecure
                            ? Icon(Icons.visibility_rounded)
                            : Icon(
                                Icons.visibility_off_rounded,
                              ),
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                      ),
                      validate: (value) {
                        if (value.toString().isEmpty) {
                          return 'password must not be empty';
                        } else if (value.toString().length < 6) {
                          return 'Password too short';
                        }
                                
                        return null;
                      }),
                        defaultButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ApiProvider.userlogin(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          final Map<String, dynamic> responseData =
                              json.decode(value.body);
                          if (value.statusCode == 200) {
                            patientModel = new PatientModel(
                                email: emailController.text,
                                token: responseData['key'],
                                cookie: value.headers['set-cookie']);
                                
                            print(patientModel.cookie);
                            print('login YOLO!!');
                            print('Token:' + patientModel.token!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PatientHomeScreeen(
                                        patientModel: patientModel)));
                            final snackBar = SnackBar(
                                content: Text('Loged IN succesfuly ,Welcome!'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else if (responseData["non_field_errors"][0] ==
                              "E-mail is not verified.") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => buildPopupDialog(
                                context,
                                title: 'Unverified Email',
                                msg:
                                    'Please verify your Email and try to login again(a confirmation email was sent to you)',
                              ),
                            );
                          } else {
                            print('can\'t login');
                            print(value.body);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => buildPopupDialog(
                                context,
                                title: 'invalid credentials',
                                msg: 'email or password are wrong!',
                              ),
                            );
                          }
                        });
                      }
                    },
                    text: 'sign in',
                    radius: 20.00,
                    background: Colors.blue[800],
                              ),
                        Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You don't have an account?",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[700],
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Sing UP',
                          style: TextStyle(
                              fontSize: 18.00,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                      ),
                    ],
                              ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
