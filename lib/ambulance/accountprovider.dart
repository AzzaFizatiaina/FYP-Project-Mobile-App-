import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_project/ambulance/admininformation.dart';
import 'package:fyp_project/ambulance/profileprovider.dart';

class AccountProvider extends StatefulWidget {
  const AccountProvider({Key? key}) : super(key: key);

  @override
  State<AccountProvider> createState() => _AccountProviderState();
}

class _AccountProviderState extends State<AccountProvider> {
  final user = FirebaseAuth.instance.currentUser!;

  final dbRef = FirebaseDatabase.instance.reference().child("Admin");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: Text("Admin Account"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileProvider()),
              );
            },
          ),
        ),
        body: SafeArea(
            child: FirebaseAnimatedList(
                query: dbRef,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map m = Map.from((snapshot.value ?? {}) as Map);
                  if (m.values == null) {
                    return Text("No Data Found");
                  } else {
                    return Card(
                      elevation: 20,
                      shadowColor: Colors.orangeAccent,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.all(25),
                      child: Container(
                          height: 450,
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
                                  Text("Services : ",
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
                                  Text(m["admin"],
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
                                  Text("Contact No : ",
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
                                  Text(m["adminno"],
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
                                  Text("Email : ",
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
                                  Text(m["email"],
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
                                  Text("Details : ",
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
                                  Expanded(
                                      child: Text(m['details'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: TextStyle(fontSize: 15))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: GestureDetector(
                              onTap: () {
                                updateDialog(
                                    m['admin'],
                                    m['email'],
                                    m['adminno'],
                                    m['details'],
                                    context,
                                    snapshot.key);
                              },
                              child: Container(
                                height: 50,
                                width: 280,
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ))
                          ])),
                    );
                  }
                })));
  }

  Future<void> updateDialog(String admin, String adminno, String email,
      String details, BuildContext context, var key) async {
    var adminController = TextEditingController(text: admin);
    var emailController = TextEditingController(text: email);
    var detailsController = TextEditingController(text: details);
    var adminnoController = TextEditingController(text: adminno);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update Profile"),
            content: Column(
              children: [
                TextFormField(
                  controller: adminController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Admin Services"),
                ),
                TextFormField(
                  controller: adminnoController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Contact no"),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Email"),
                ),
                TextFormField(
                  controller: detailsController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(), labelText: "Details"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    UpdateData(adminController.text, adminnoController.text,
                        emailController.text, detailsController.text, key);
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

  void UpdateData(
      String admin, String adminno, String email, String details, var key) {
    Map<String, String> x = {
      "admin": admin,
      "adminno": adminno,
      "email": email,
      "details": details
    };
    dbRef.child(key).update(x);
  }
}
