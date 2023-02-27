import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_project/user/feedbackuser.dart';
import 'package:fyp_project/user/profileuser.dart';

class AddFeedbackUser extends StatefulWidget {
  const AddFeedbackUser({Key? key}) : super(key: key);

  @override
  State<AddFeedbackUser> createState() => _AddFeedbackUserState();
}

class _AddFeedbackUserState extends State<AddFeedbackUser> {
  final user = FirebaseAuth.instance.currentUser!;

  var nameController = new TextEditingController();
  var feedbackController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 181, 164),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: Text("Add Your Feedback"),
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
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Enter Name",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Color.fromARGB(255, 79, 78, 78).withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: feedbackController,
              decoration: InputDecoration(
                labelText: "Enter Feedback",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Color.fromARGB(255, 79, 78, 78).withOpacity(0.3),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  var name = nameController.text.trim();
                  var feedback = feedbackController.text.trim();

                  if (name.isEmpty || feedback.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please fill all fields');
                    return;
                  }

                  final user = User(
                      name: nameController.text,
                      feedback: feedbackController.text);

                  createFeedback(user);

                  if (nameController.text.isNotEmpty &&
                      feedbackController.text.isNotEmpty) {
                    addFeedback(
                      nameController.text,
                      feedbackController.text,
                    );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FeedbackUser()),
                  );
                },
                child: Container(
                  height: 50,
                  width: 280,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            )
          ],
        )));
  }

  void addFeedback(String name, String feedback) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = user.uid;
    if (user.uid == user.uid) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('Feedback');

      String? key = userRef.push().key;

      await userRef.child(key!).set({
        'name': name,
        'feedback': feedback,
        'uid': user.uid,
      });
      Fluttertoast.showToast(msg: 'Success');
    } else {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }
}

Future createFeedback(User user) async {
  final docAmbulance = FirebaseFirestore.instance.collection('Feedback').doc();
  user.id = docAmbulance.id;

  final json = user.toJson();

  await docAmbulance.set(json);
}

class User {
  String id;
  final String name;
  final String feedback;

  User({
    this.id = '',
    required this.name,
    required this.feedback,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'feedback+': feedback,
      };
}
