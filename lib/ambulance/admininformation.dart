import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_project/ambulance/accountprovider.dart';

class Admininformation extends StatefulWidget {
  const Admininformation({Key? key}) : super(key: key);

  @override
  State<Admininformation> createState() => _AdmininformationState();
}

class _AdmininformationState extends State<Admininformation> {
  final user = FirebaseAuth.instance.currentUser!;
  var adminController = new TextEditingController();
  var adminnoController = new TextEditingController();
  var detailController = new TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: Text("Create Admin Profile"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccountProvider()),
              );
            },
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            TextFormField(
              controller: adminController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                labelText: "Enter Admin Service",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: adminnoController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                labelText: "Enter Contact Number",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: detailController,
              decoration: InputDecoration(
                hintMaxLines: 1,
                prefixIcon: Icon(
                  Icons.info_rounded,
                  color: Colors.black,
                ),
                labelText: "Enter Details",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white.withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  var admin = adminController.text.trim();
                  var adminno = adminnoController.text.trim();
                  var details = detailController.text.trim();

                  if (admin.isEmpty || adminno.isEmpty || details.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please fill all fields');
                    return;
                  }

                  final user = User(
                      admin: adminController.text,
                      adminno: adminnoController.text,
                      details: detailController.text);

                  createAmbulance(user);

                  if (adminController.text.isNotEmpty &&
                      adminnoController.text.isNotEmpty &&
                      detailController.text.isNotEmpty) {
                    addProvider(
                      adminController.text,
                      adminnoController.text,
                      detailController.text,
                    );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountProvider()),
                  );
                },
                child: Container(
                  height: 50,
                  width: 280,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Add Profile',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            )
          ],
        )));
  }

  void addProvider(String admin, String adminno, String details) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = user.uid;
    if (user.uid == user.uid) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('Admin');

      String? key = userRef.push().key;

      await userRef.child(key!).set({
        'admin': admin,
        'adminno': adminno,
        'email': user.email,
        'details': details,
        'uid': user.uid,
      });
      Fluttertoast.showToast(msg: 'Success');
    } else {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }
}

Future createAmbulance(User user) async {
  final docAmbulance = FirebaseFirestore.instance.collection('Admin').doc();
  user.id = docAmbulance.id;

  final json = user.toJson();

  await docAmbulance.set(json);
}

class User {
  String id;
  final String admin;
  final String adminno;
  final String details;

  User({
    this.id = '',
    required this.admin,
    required this.adminno,
    required this.details,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'provider': admin,
        'providerno': adminno,
        'details': details,
      };
}
