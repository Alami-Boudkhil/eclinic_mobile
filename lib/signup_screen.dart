import 'package:flutter/material.dart';
import 'package:eclinic_mobile/shared/components.dart';
import 'package:eclinic_mobile/login_screen.dart';
 
class SignUpScreen extends StatelessWidget{
  var userNameController= TextEditingController();
  var emailController= TextEditingController();
  var passwordController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                    child:Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.00,
                        ),
                    ),
                  ),
                  Positioned (
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
                controller: userNameController,
                type: TextInputType.emailAddress,
                label: 'Username',
                prefix: Icons.supervised_user_circle
                
                
              ),
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
                isPassword: true,
                suffix: Icons.visibility,
            
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.00,
                 vertical: 20.00,
               ),
              child: defaultButton(
                function: (){

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
                    style:TextStyle(
                      fontSize: 18.00,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue
                    ) ,
                  ),
                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                ),
              ],
            ),
          ],
      
        ),
      ),
     
    );
  }
}