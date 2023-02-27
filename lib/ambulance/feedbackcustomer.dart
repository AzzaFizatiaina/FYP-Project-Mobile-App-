import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_project/ambulance/homepageambulance.dart';

class FeedbackCustomer extends StatefulWidget {
  const FeedbackCustomer({Key? key}) : super(key: key);

  @override
  State<FeedbackCustomer> createState() => _FeedbackCustomerState();
}

class _FeedbackCustomerState extends State<FeedbackCustomer> {
  final user = FirebaseAuth.instance.currentUser!;
  final databaseRef = FirebaseDatabase.instance.reference().child('Feedback');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: Text("Customer Feedback"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomePageAmbulance()),
              );
            },
          ),
        ),
        body: SafeArea(
            child: FirebaseAnimatedList(
                query: databaseRef,
                itemBuilder: (context, snapshot, animation, index) {
                  Map m = Map.from((snapshot.value ?? {}) as Map);

                  return ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 24,
                      ),
                      title: Text(
                        m['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(m['feedback'],
                          style: TextStyle(color: Colors.black)),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            databaseRef.child(snapshot.key!).remove();
                          },
                        ),
                      ]));
                })));
  }
}
