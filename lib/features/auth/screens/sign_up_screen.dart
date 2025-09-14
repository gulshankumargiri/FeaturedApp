import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/auth/provider/auth_provider.dart';

import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final phoneC = TextEditingController();
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sign = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('SignUp Page'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            TextFormField(
              controller: nameC,
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10.0,
                ),
              ),
            ),
            TextFormField(
              controller: emailC,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10.0,
                ),
              ),
            ),
            TextFormField(
              controller: passC,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10.0,
                ),
              ),
            ),
            TextFormField(
              controller: phoneC,
              decoration: InputDecoration(
                hintText: 'Phone',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10.0,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                final email = emailC.text.trim();
                final pass = passC.text.trim();
                final name = emailC.text.trim();
                final phone = phoneC.text.trim();

                final success = await sign.signUp(name, email, pass, phone);
                if (success) {
                  ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                    content: Text('SignuP Successful , Please Login'),
                    actions: [
                      TextButton(onPressed: (){
                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                      }, child: Text('Close'))
                    ],
                    backgroundColor: Colors.green,


                  ));
                  Future.delayed(const Duration(seconds: 2),(){
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  } );
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else {
                  // ScaffoldMessenger.of(
                  //   context,
                  // ).showSnackBar(SnackBar(content: Text('Sign Up Failed')));

                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      content: Text(
                        'Sign Up Failed / Enter all The Credential',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(
                              context,
                            ).hideCurrentMaterialBanner();
                          },
                          child: Text('Close'),
                        ),
                      ],
                      backgroundColor: Colors.grey[400],
                    ),
                  );
                }
              },
              child: Text('Sign Up'),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'already have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
