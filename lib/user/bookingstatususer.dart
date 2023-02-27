import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_project/user/homepageuser.dart';

class BookingStatusUser extends StatefulWidget {
  const BookingStatusUser({Key? key}) : super(key: key);

  @override
  State<BookingStatusUser> createState() => _BookingStatusUserState();
}

class _BookingStatusUserState extends State<BookingStatusUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: const Text(
            "Booking Status",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePageUser()),
              );
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(children: [
          SizedBox(
            height: 200,
          ),
          Center(
            child: Icon(
              Icons.celebration_outlined,
              size: 90,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Thank You For Your Booking!",
            style: TextStyle(fontSize: 28, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Your Booking Was Completed Successfully.",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: FlatButton(
              color: Colors.black,
              height: 50,
              child: Text(
                "Continue",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePageUser()),
                );
              },
            ),
          )
        ]));
  }
}
