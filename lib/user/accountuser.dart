import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_project/user/profileuser.dart';

class Accountuser extends StatefulWidget {
  const Accountuser({
    Key? key,
  }) : super(key: key);

  @override
  State<Accountuser> createState() => _AccountuserState();
}

class _AccountuserState extends State<Accountuser> {
  final user = FirebaseAuth.instance.currentUser!;

  final dbRef = FirebaseDatabase.instance.reference().child("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 181, 164),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: Text("Account"),
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
            child: FirebaseAnimatedList(
                query: FirebaseDatabase.instance
                    .reference()
                    .child('users')
                    .orderByChild(user.uid),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map m = Map.from((snapshot.value ?? {}) as Map);
                  return Card(
                      elevation: 8,
                      shadowColor: Colors.orangeAccent,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.all(25),
                      child: Container(
                          height: 670,
                          child: Column(children: [
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "PROFILE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Text("Name : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Text(m["username"],
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Text("Address : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Text(m["address"],
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Text("Email: ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Text(m['email'],
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                                child: GestureDetector(
                                    onTap: () {
                                      updateDialog(m['username'], m['address'],
                                          m['email'], context, snapshot.key);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 280,
                                      color: Colors.black,
                                      child: Center(
                                        child: Text(
                                          'Edit Profile',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    )))
                          ])));
                })));
  }

  Future<void> updateDialog(String username, String address, String email,
      BuildContext context, var key) async {
    var usernameController = TextEditingController(text: username);
    var emailController = TextEditingController(text: email);
    var addressController = TextEditingController(text: address);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update Profile"),
            content: Column(
              children: [
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Username"),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Address"),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Email"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    UpdateData(usernameController.text, addressController.text,
                        emailController.text, key);
                    Navigator.of(context).pop();
                  },
                  child: Text("Update")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel")),
            ],
          );
        });
  }

  void UpdateData(String username, String address, String email, var key) {
    Map<String, String> x = {
      "username": username,
      "address": address,
      "email": email,
    };
    dbRef.child(key).update(x);
  }
}
