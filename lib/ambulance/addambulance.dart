import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_project/ambulance/detailsambulanceprovider.dart';
import 'package:fyp_project/ambulance/homepageambulance.dart';

class AddAmbulance extends StatefulWidget {
  const AddAmbulance({Key? key}) : super(key: key);

  @override
  State<AddAmbulance> createState() => _AddAmbulanceState();
}

class _AddAmbulanceState extends State<AddAmbulance> {
  final user = FirebaseAuth.instance.currentUser!;
  var providerController = new TextEditingController();
  var providernoController = new TextEditingController();
  var provideremailController = new TextEditingController();
  var detailController = new TextEditingController();
  var priceController = new TextEditingController();
  var locationController = new TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: Text("Add Provider"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailsAmbulanceProvider()),
              );
            },
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: providerController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.emoji_transportation,
                  color: Colors.black,
                ),
                labelText: "Enter Provider Company Name",
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
              height: 5,
            ),
            TextFormField(
              controller: providernoController,
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
              height: 5,
            ),
            TextFormField(
              controller: provideremailController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                labelText: "Enter Email",
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
              height: 5,
            ),
            TextFormField(
              controller: detailController,
              decoration: InputDecoration(
                hintMaxLines: 2,
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
              height: 5,
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                hintMaxLines: 1,
                prefixIcon: Icon(
                  Icons.money,
                  color: Colors.black,
                ),
                labelText: "Enter Estimated Price",
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
              height: 5,
            ),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                labelText: "Enter Area Cover",
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
                  var provider = providerController.text.trim();
                  var providerno = providernoController.text.trim();
                  var email = provideremailController.text.trim();
                  var location = locationController.text.trim();
                  var details = detailController.text.trim();
                  var price = priceController.text.trim();

                  if (provider.isEmpty ||
                      providerno.isEmpty ||
                      email.isEmpty ||
                      location.isEmpty ||
                      price.isEmpty ||
                      details.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please fill all fields');
                    return;
                  }

                  final user = User(
                      provider: providerController.text,
                      providerno: providernoController.text,
                      email: provideremailController.text,
                      location: locationController.text,
                      details: detailController.text,
                      price: priceController.text);

                  createAmbulance(user);

                  if (providerController.text.isNotEmpty &&
                      providernoController.text.isNotEmpty &&
                      provideremailController.text.isNotEmpty &&
                      detailController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      locationController.text.isNotEmpty) {
                    addProvider(
                      providerController.text,
                      providernoController.text,
                      provideremailController.text,
                      detailController.text,
                      priceController.text,
                      locationController.text,
                    );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DetailsAmbulanceProvider()),
                  );
                },
                child: Container(
                  height: 50,
                  width: 280,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Add Provider',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            )
          ],
        )));
  }

  void addProvider(String provider, String providerno, String provideremail,
      String details, String price, String location) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = user.uid;
    if (user.uid == user.uid) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('Provider');

      String? key = userRef.push().key;

      await userRef.child(key!).set({
        'provider': provider,
        'providerno': providerno,
        'email': provideremail,
        'details': details,
        'price': price,
        'location': location,
        'uid': user.uid,
      });
      Fluttertoast.showToast(msg: 'Success');
    } else {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }
}

Future createAmbulance(User user) async {
  final docAmbulance = FirebaseFirestore.instance.collection('Provider').doc();
  user.id = docAmbulance.id;

  final json = user.toJson();

  await docAmbulance.set(json);
}

class User {
  String id;
  final String provider;
  final String providerno;
  final String email;
  final String details;
  final String price;
  final String location;

  User(
      {this.id = '',
      required this.provider,
      required this.providerno,
      required this.email,
      required this.details,
      required this.price,
      required this.location});

  Map<String, dynamic> toJson() => {
        'id': id,
        'provider': provider,
        'providerno': providerno,
        'email': email,
        'details': details,
        'price': price,
        'location': location,
      };
}
