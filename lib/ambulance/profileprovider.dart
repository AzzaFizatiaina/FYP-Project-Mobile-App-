import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:fyp_project/ambulance/accountprovider.dart';
import 'package:fyp_project/ambulance/homepageambulance.dart';
import 'package:fyp_project/firstpage.dart';
import 'package:fyp_project/icon_widget.dart';

class ProfileProvider extends StatefulWidget {
  const ProfileProvider({Key? key}) : super(key: key);

  @override
  State<ProfileProvider> createState() => _ProfileProviderState();
}

class _ProfileProviderState extends State<ProfileProvider> {
  final user = FirebaseAuth.instance.currentUser!;
  final databaseRef = FirebaseDatabase.instance.reference().child('provider');

  final storage = new FlutterSecureStorage();
  String email = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text("Profile"),
            backgroundColor: Color(0xFFF4511E),
            elevation: 0,
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
            actions: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FirstPage()),
                  );
                },
              ),
            ]),
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            SettingsGroup(title: "GENERAL", children: <Widget>[
              buildAccount(),
              buildLogout(),
              buildDeleteAccount(),
            ]),
            const SizedBox(
              height: 32,
            ),
          ],
        )));
  }

  Widget buildLogout() => SimpleSettingsTile(
        title: 'Logout',
        subtitle: '',
        leading: IconWidget(
          icon: Icons.logout,
          color: Colors.blueAccent,
        ),
        onTap: () async => {
          await FirebaseAuth.instance.signOut(),
          await storage.delete(key: "uid"),
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => FirstPage(),
              ),
              (route) => false)
        },
      );

  Widget buildDeleteAccount() => SimpleSettingsTile(
        title: 'Delete Account',
        subtitle: '',
        leading: IconWidget(
          icon: Icons.delete,
          color: Colors.redAccent,
        ),
        onTap: () {
          databaseRef.child(user.uid).remove();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => FirstPage(),
              ),
              (route) => false);
        },
      );

  Widget buildAccount() => SimpleSettingsTile(
        title: 'Account',
        subtitle: '',
        leading: IconWidget(icon: Icons.person, color: Colors.orange),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AccountProvider()));
        },
      );
}
