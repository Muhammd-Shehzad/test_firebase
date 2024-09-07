import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_firebase/CustomWidget/custom_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In ',
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
                controller: passwordController,
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
                          password: passwordController.text.toString())
                      .then((v) {
                    setState(() {
                      isLoading = true;
                      emailController.clear();
                      passwordController.clear();
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
              text: 'Sign In',
              height: 50.h,
              width: 200.w,
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
