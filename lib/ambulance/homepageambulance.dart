import 'package:flutter/material.dart';
import 'package:fyp_project/ambulance/addambulance.dart';
import 'package:fyp_project/ambulance/griddashboardprovider.dart';
import 'package:fyp_project/ambulance/profileprovider.dart';
import 'package:fyp_project/firstpage.dart';

class HomePageAmbulance extends StatefulWidget {
  const HomePageAmbulance({Key? key}) : super(key: key);

  @override
  State<HomePageAmbulance> createState() => _HomePageAmbulanceState();
}

class _HomePageAmbulanceState extends State<HomePageAmbulance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: Text("Welcome Provider"),
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.person,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileProvider()),
                );
              },
            ),
          ]),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          GridDashboardProvider()
        ],
      ),
    );
  }
}
