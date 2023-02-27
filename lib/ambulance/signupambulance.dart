import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_project/reusable_widget.dart';
import 'package:ndialog/ndialog.dart';

class SignUpAmbulance extends StatefulWidget {
  const SignUpAmbulance({Key? key}) : super(key: key);

  @override
  State<SignUpAmbulance> createState() => _SignUpAmbulanceState();
}

class _SignUpAmbulanceState extends State<SignUpAmbulance> {
  var _passwordTextController = TextEditingController();
  var _repasswordTextController = TextEditingController();
  var _emailTextController = TextEditingController();
  var _companynameTextController = TextEditingController();
  var _companynoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Sign Up",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
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
                    padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 600,
                          width: 325,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Hello',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Please Create Account First',
                                  style: TextStyle(
                                      fontSize: 15, color: Color(0xFF263238)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                reusableTextField(
                                    "Enter Username",
                                    Icons.person_outline,
                                    false,
                                    _companynameTextController),
                                const SizedBox(
                                  height: 20,
                                ),
                                reusableTextField(
                                    "Enter Company No",
                                    Icons.phone_android,
                                    false,
                                    _companynoTextController),
                                const SizedBox(
                                  height: 20,
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
                                    Icons.lock_outlined,
                                    true,
                                    _passwordTextController),
                                const SizedBox(
                                  height: 20,
                                ),
                                reusableTextField(
                                    "Enter Password Again",
                                    Icons.lock_outline,
                                    true,
                                    _repasswordTextController),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        fixedSize: Size(300, 50),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    onPressed: () async {
                                      var password =
                                          _passwordTextController.text.trim();
                                      var repassword =
                                          _repasswordTextController.text.trim();
                                      var email =
                                          _emailTextController.text.trim();
                                      var companyname =
                                          _companynameTextController.text
                                              .trim();
                                      var companyno =
                                          _companynoTextController.text.trim();

                                      if (companyname.isEmpty ||
                                          companyno.isEmpty ||
                                          email.isEmpty ||
                                          password.isEmpty ||
                                          repassword.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: 'Please fill all fields');
                                        return;
                                      }

                                      if (password.length < 6) {
                                        // show error toast
                                        Fluttertoast.showToast(
                                            msg:
                                                'Weak Password, at least 6 characters are required');

                                        return;
                                      }

                                      if (password != repassword) {
                                        // show error toast
                                        Fluttertoast.showToast(
                                            msg: 'Passwords do not match');

                                        return;
                                      }

                                      ProgressDialog progressDialog =
                                          ProgressDialog(
                                        context,
                                        title: const Text('Signing Up'),
                                        message: const Text('Please wait'),
                                      );

                                      progressDialog.show();
                                      try {
                                        FirebaseAuth auth =
                                            FirebaseAuth.instance;

                                        UserCredential userCredential =
                                            await auth
                                                .createUserWithEmailAndPassword(
                                                    email: email,
                                                    password: password);

                                        if (userCredential.user != null) {
                                          DatabaseReference userRef =
                                              FirebaseDatabase.instance
                                                  .reference()
                                                  .child('Admin');

                                          String uid = userCredential.user!.uid;

                                          await userRef.child(uid).set({
                                            'company name': companyname,
                                            'company no': companyno,
                                            'email': email,
                                            'password': password,
                                            're-password': repassword,
                                            'uid': uid,
                                          });

                                          Fluttertoast.showToast(
                                              msg: 'Success');

                                          Navigator.of(context).pop();
                                        } else {
                                          Fluttertoast.showToast(msg: 'Failed');
                                        }

                                        progressDialog.dismiss();
                                      } on FirebaseAuthException catch (e) {
                                        progressDialog.dismiss();
                                        if (e.code == 'email-already-in-use') {
                                          Fluttertoast.showToast(
                                              msg: 'Email is already in Use');
                                        } else if (e.code == 'weak-password') {
                                          Fluttertoast.showToast(
                                              msg: 'Password is weak');
                                        }
                                      } catch (e) {
                                        progressDialog.dismiss();
                                        Fluttertoast.showToast(
                                            msg: 'Something went wrong');
                                      }
                                    },
                                    child: const Text('Sign Up',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16))),
                                const SizedBox(
                                  height: 10,
                                )
                              ]))
                    ])))));
  }
}
