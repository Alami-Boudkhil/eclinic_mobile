import 'package:flutter/material.dart';
import 'package:eclinic_mobile/shared/components.dart';
import 'package:eclinic_mobile/modules/auth/login/login_screen.dart';
import 'package:eclinic_mobile/modules/patient_view/profile_completion.dart';

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
                  flex: 9,
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
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image(
                            height: 200,
                            width: 200,
                            image: AssetImage('assets/images/logoBW.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20) ,
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
                              setState(() {  });
                              return 'Email must not be empty';
                            } else if (!value.toString().contains('@esi-sba')) {
                              return 'Only ESI-Sba emails are accepted';
                            }
                            return null;
                            },
                          ),
                          defaultFormField(
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
                          defaultFormField(
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
                      if (passwordController.text !=
                          passwordConfirmationController.text) {
                        return 'confirmation didn\'t match password';
                      }
                      return null;
                    }),
                          defaultButton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatienProfiletScreeen(
                                email: emailController.text,
                                password1: passwordController.text,
                                password2: passwordConfirmationController.text,
                              )));
                    }
                  },
                  text: 'sign Up',
                  radius: 20.00,
                  background: Colors.blue[800],
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
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
