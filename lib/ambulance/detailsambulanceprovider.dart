import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:fyp_project/ambulance/addambulance.dart';
import 'package:fyp_project/ambulance/homepageambulance.dart';

class DetailsAmbulanceProvider extends StatefulWidget {
  const DetailsAmbulanceProvider({Key? key}) : super(key: key);

  @override
  State<DetailsAmbulanceProvider> createState() =>
      _DetailsAmbulanceProviderState();
}

class _DetailsAmbulanceProviderState extends State<DetailsAmbulanceProvider> {
  final user = FirebaseAuth.instance.currentUser!;
  final databaseRef = FirebaseDatabase.instance.reference().child('Provider');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: Text("Provider Details"),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddAmbulance(),
                ));
          },
          backgroundColor: Color(0xFFF4511E),
          child: Icon(Icons.add),
        ),
        body: SafeArea(
            child: FirebaseAnimatedList(
                query: databaseRef,
                itemBuilder: (context, snapshot, animation, index) {
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
                          height: 600,
                          child: Column(children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Company Name : ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                                  Text(m["provider"],
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
                                  Text("Company No : ",
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
                                  Text(m["providerno"],
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
                                  Text("Details: ",
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
                                      child: Text(m["details"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 15))),
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
                                  Text("Estimated Price: ",
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
                                      child: Text(m["price"],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(fontSize: 15))),
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
                                  Text("Area Cover: ",
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
                                  Text(m["location"],
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                                child: GestureDetector(
                              onTap: () {
                                updateDialog(
                                    m['provider'],
                                    m['providerno'],
                                    m['email'],
                                    m['details'],
                                    m['price'],
                                    m['location'],
                                    context,
                                    snapshot.key);
                              },
                              child: Container(
                                height: 50,
                                width: 280,
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    'Edit Provider',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            )),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: GestureDetector(
                              onTap: () {
                                databaseRef.child(snapshot.key!).remove();
                              },
                              child: Container(
                                height: 50,
                                width: 280,
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    'Delete Provider',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            )),
                          ])),
                    );
                  }
                })));
  }

  Future<void> updateDialog(
      String provider,
      String providerno,
      String email,
      String details,
      String price,
      String location,
      BuildContext context,
      var key) async {
    var providerController = TextEditingController(text: provider);
    var providernoController = TextEditingController(text: providerno);
    var emailController = TextEditingController(text: email);
    var detailsController = TextEditingController(text: details);
    var priceController = TextEditingController(text: price);
    var locationController = TextEditingController(text: location);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 300,
              child: AlertDialog(
                content: Column(
                  children: [
                    TextFormField(
                      controller: providerController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Company Name"),
                    ),
                    TextFormField(
                      controller: providernoController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Company No"),
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
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(), labelText: "Price"),
                    ),
                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Location"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        UpdateData(
                            providerController.text,
                            providernoController.text,
                            emailController.text,
                            detailsController.text,
                            priceController.text,
                            locationController.text,
                            key);
                        Navigator.of(context).pop();
                      },
                      child: Text("Update")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                ],
              ));
        });
  }

  void UpdateData(String provider, String providerno, String email,
      String details, String price, String location, var key) {
    Map<String, String> x = {"location": location, "provider": provider};
    databaseRef.child(key).update(x);
  }
}
