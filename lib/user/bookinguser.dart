import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_project/user/addresssearc.dart';
import 'package:fyp_project/user/bookingstatususer.dart';
import 'package:fyp_project/user/homepageuser.dart';
import 'package:fyp_project/user/mapuser.dart';
import 'package:fyp_project/user/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class BookingUser extends StatefulWidget {
  const BookingUser({Key? key}) : super(key: key);

  @override
  State<BookingUser> createState() => _BookingUserState();
}

class _BookingUserState extends State<BookingUser> {
  final user = FirebaseAuth.instance.currentUser!;

  var nameController = new TextEditingController();
  var noController = new TextEditingController();
  var dateController = new TextEditingController();
  var timeController = new TextEditingController();
  var addressController = new TextEditingController();
  var destinationController = new TextEditingController();

  var uuid = Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placeslist = [];

  @override
  void initState() {
    super.initState();

    addressController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(addressController.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyAcW5vg5ocek09qyMRD6YdJcg1_i7rGflc";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print('data');
    print(data);

    if (response.statusCode == 200) {
      setState(() {
        _placeslist = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
            backgroundColor: Color.fromARGB(255, 240, 181, 164),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Color(0xFFF4511E),
              elevation: 0,
              title: Text("Add Booking"),
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePageUser()),
                  );
                },
              ),
            ),
            body: SafeArea(
                child: Column(children: [
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  labelText: "Enter Name",
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
                controller: noController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.black,
                  ),
                  labelText: "Enter No",
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
                controller: dateController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  labelText: "Enter Date",
                  labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),
                onTap: () async {
                  DateTime? _date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2030));

                  if (_date != null) {
                    setState(() {
                      dateController.text =
                          '${_date.day}/${_date.month}/${_date.year}';
                    });
                  }
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.access_time,
                      color: Colors.black,
                    ),
                    labelText: "Enter Time ",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  onTap: () async {
                    TimeOfDay? _time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (_time != null) {
                      setState(() {
                        timeController.text = _time.format(context).toString();
                      });
                    }
                  }),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      color: Colors.black,
                    ),
                    labelText: "Enter Address",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  onTap: () async {}),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: destinationController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.black,
                  ),
                  labelText: "Enter Destination",
                  labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),
                onTap: () {},
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                  child: GestureDetector(
                      onTap: () async {
                        var name = nameController.text.trim();
                        var date = dateController.text.trim();
                        var time = timeController.text.trim();
                        var address = addressController.text.trim();
                        var destination = destinationController.text.trim();
                        var no = noController.text.trim();

                        if (name.isEmpty ||
                            date.isEmpty ||
                            time.isEmpty ||
                            address.isEmpty ||
                            destination.isEmpty ||
                            no.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please fill all fields');
                          return;
                        }

                        final user = User(
                            name: nameController.text,
                            date: dateController.text,
                            time: timeController.text,
                            address: addressController.text,
                            destination: destinationController.text,
                            no: noController.text);

                        createBooking(user);

                        if (nameController.text.isNotEmpty &&
                            dateController.text.isNotEmpty &&
                            timeController.text.isNotEmpty &&
                            addressController.text.isNotEmpty &&
                            destinationController.text.isNotEmpty &&
                            noController.text.isNotEmpty) {
                          addBooking(
                            nameController.text,
                            dateController.text,
                            timeController.text,
                            addressController.text,
                            destinationController.text,
                            noController.text,
                          );
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageUser()));
                      },
                      child: Container(
                        height: 50,
                        width: 280,
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            'Book',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      )))
            ]))));
  }

  void addBooking(String name, String date, String time, String address,
      String destination, String no) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    String uid = user.uid;
    if (user.uid == user.uid) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('Booking').child(uid);

      String? key = userRef.push().key;

      await userRef.child(key!).set({
        'email': user.email,
        'name': name,
        'no': no,
        'date': date,
        'time': time,
        'address': address,
        'destination': destination,
        'uid': key,
      });

      Fluttertoast.showToast(msg: 'Success');
    } else {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }
}

Future createBooking(User user) async {
  final docAmbulance = FirebaseFirestore.instance.collection('Booking').doc();
  user.id = docAmbulance.id;

  final json = user.toJson();

  await docAmbulance.set(json);
}

class User {
  String id;
  final String name;
  final String date;
  final String time;
  final String address;
  final String destination;
  final String no;

  User({
    this.id = '',
    required this.name,
    required this.date,
    required this.time,
    required this.address,
    required this.destination,
    required this.no,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date,
        'time': time,
        'address': address,
        'destination': destination,
        'no': no
      };
}
