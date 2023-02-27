import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_project/user/addfeebackuser.dart';
import 'package:fyp_project/user/profileuser.dart';

class FeedbackUser extends StatefulWidget {
  const FeedbackUser({Key? key}) : super(key: key);

  @override
  State<FeedbackUser> createState() => _FeedbackUserState();
}

class _FeedbackUserState extends State<FeedbackUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 181, 164),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: Text("Feedback"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileUser()),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddFeedbackUser(),
                ));
          },
          backgroundColor: Color(0xFFF4511E),
          child: Icon(Icons.add),
        ),
        body: SafeArea(
            child: FirebaseAnimatedList(
                query: FirebaseDatabase.instance.reference().child('Feedback'),
                itemBuilder: (context, snapshot, animation, index) {
                  Map m = Map.from((snapshot.value ?? {}) as Map);

                  return ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: Text(
                      m['name'],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(m['feedback'],
                        style: TextStyle(color: Colors.black)),
                  );
                })));
  }
}
