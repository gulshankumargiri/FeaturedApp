import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/auth/provider/auth_provider.dart';
import 'package:todo_app/features/auth/screens/sign_up_screen.dart';
import 'package:todo_app/features/todos/screens/all_notes.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Login'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10.0,
                ),
              ),
            ),
            TextField(
              controller: passcontroller,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 10.0,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                final emails = emailcontroller.text.trim();
                final pass = passcontroller.text.trim();
                bool success = await authProvider.login(emails, pass);
                if (success) {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      backgroundColor: Colors.green,
                      content: Text('Login Success'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(
                              context,
                            ).hideCurrentMaterialBanner();
                          },
                          child: Text('X'),
                        ),
                      ],
                    ),
                  );
                  Future.delayed(const Duration(seconds: 1),(){
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  });
                  Future.delayed(const Duration(seconds: 2), () {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AllNotes()),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      content: Text('Login Failed / Enter Correct Credential'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(
                              context,
                            ).hideCurrentMaterialBanner();
                          },
                          child: Text('X'),
                        ),
                      ],
                    ),
                  );
                  Future.delayed(const Duration(seconds: 7), () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  });
                }
              },
              child: Text('Login'),
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: RichText(
                softWrap: true,
                overflow: TextOverflow.clip,

                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Not have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' SignUp',
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
