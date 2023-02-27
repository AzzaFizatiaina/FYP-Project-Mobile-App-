import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_project/ambulance/homepageambulance.dart';
import 'package:fyp_project/ambulance/signupambulance.dart';
import 'package:fyp_project/resetpassword.dart';
import 'package:fyp_project/reusable_widget.dart';

class SignInAmbulance extends StatefulWidget {
  const SignInAmbulance({Key? key}) : super(key: key);

  @override
  State<SignInAmbulance> createState() => _SignInAmbulanceState();
}

class _SignInAmbulanceState extends State<SignInAmbulance> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFFB71C1C),
              Color(0xFFFFEBEE),
              Color(0xFFF4511E),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                    child: Column(children: <Widget>[
                      Image.asset(
                        'images/logo.png',
                        fit: BoxFit.fitWidth,
                        width: 200,
                        height: 150,
                      ),
                      Text(
                        'Give The Best Services',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 400,
                          width: 325,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Hello',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Please Login to Your Account',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFF263238)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                reusableTextField(
                                    "Enter Email",
                                    Icons.person_outline,
                                    false,
                                    _emailTextController),
                                const SizedBox(
                                  height: 20,
                                ),
                                reusableTextField(
                                    "Enter Password",
                                    Icons.lock_outline,
                                    true,
                                    _passwordTextController),
                                forgetPassword(context),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        fixedSize: Size(300, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    onPressed: () async {
                                      var email =
                                          _emailTextController.text.trim();
                                      var password =
                                          _passwordTextController.text.trim();
                                      if (email.isEmpty || password.isEmpty) {
                                        // show error toast
                                        Fluttertoast.showToast(
                                            msg: 'Please fill all fields');
                                        return;
                                      }

                                      // request to firebase auth
                                      try {
                                        FirebaseAuth auth =
                                            FirebaseAuth.instance;

                                        UserCredential userCredential =
                                            await auth
                                                .signInWithEmailAndPassword(
                                                    email: email,
                                                    password: password);

                                        if (userCredential.user != null) {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const HomePageAmbulance();
                                          }));
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          Fluttertoast.showToast(
                                              msg: 'User not found');
                                        } else if (e.code == 'wrong-password') {
                                          Fluttertoast.showToast(
                                              msg: 'Wrong password');
                                        }
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: 'Something went wrong');
                                      }
                                    },
                                    child: const Text('Login',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))),
                                SizedBox(
                                  height: 10,
                                ),
                              ]))
                    ])))));
  }
}

Widget forgetPassword(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 35,
    alignment: Alignment.bottomRight,
    child: TextButton(
      child: const Text(
        "Forgot Password?",
        style: TextStyle(color: Colors.orange),
        textAlign: TextAlign.right,
      ),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResetPassword())),
    ),
  );
}
