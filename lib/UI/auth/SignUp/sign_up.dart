import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_firebase/CustomWidget/custom_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwrdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isLoading = false;

  void SignUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up ',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                controller: emailController,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: passwrdController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter Passwrd',
                  suffixIcon: Icon(Icons.password_rounded),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  auth
                      .createUserWithEmailAndPassword(
                          email: emailController.text.toString().trim(),
                          password: passwrdController.text.toString())
                      .then((v) {
                    setState(() {
                      isLoading = true;
                      emailController.clear();
                      passwrdController.clear();
                      Fluttertoast.showToast(
                        msg: 'Acount Created',
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.grey,
                        textColor: Colors.black,
                        timeInSecForIosWeb: 3,
                        toastLength: Toast.LENGTH_LONG,
                      );
                    });
                  }).onError(
                    (Error, v) {
                      setState(() {
                        isLoading = false;
                      });
                      Fluttertoast.showToast(
                        msg: Error.toString(),
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 4,
                        textColor: Colors.black,
                        backgroundColor: Colors.grey,
                        toastLength: Toast.LENGTH_LONG,
                      );
                    },
                  );
                }

                // if (emailController.text.isNotEmpty &&
                //     passwrdController.text.isNotEmpty) {
                //   print(
                //       'email: ${emailController.text}, password: ${passwrdController.text}');
                // } else if (emailController.text.isEmpty ||
                //     passwrdController.text.isEmpty) {
                //   Fluttertoast.showToast(
                //       msg: "Fill All Fields",
                //       toastLength: Toast.LENGTH_LONG,
                //       gravity: ToastGravity.TOP,
                //       timeInSecForIosWeb: 1,
                //       backgroundColor: Colors.red,
                //       textColor: Colors.white,
                //       fontSize: 16.0);
                // }
              },
              text: 'Sign Up',
              height: 50.h,
              width: 200.w,
              color: Colors.teal,
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have Already?',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 5.w,
                ),
                InkWell(
                  onTap: () {
                    
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
