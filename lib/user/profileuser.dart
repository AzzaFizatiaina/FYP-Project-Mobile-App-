import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_project/firstpage.dart';
import 'package:fyp_project/icon_widget.dart';
import 'package:fyp_project/user/accountuser.dart';
import 'package:fyp_project/user/applicationcust.dart';
import 'package:fyp_project/user/feedbackuser.dart';
import 'package:fyp_project/user/historycustomer.dart';
import 'package:fyp_project/user/homepageuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({Key? key}) : super(key: key);

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  final user = FirebaseAuth.instance.currentUser!;
  final databaseRef = FirebaseDatabase.instance.reference().child('users');

  final storage = new FlutterSecureStorage();
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Color(0xFFF4511E),
            elevation: 0,
            title: Text("Setting"),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePageUser()),
                );
              },
            ),
          ),
          body: SafeArea(
              child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              SettingsGroup(title: "GENERAL", children: <Widget>[
                buildAccount(),
                buildLogout(),
                buildDeleteAccount(),
                buildHistory(),
                buildApp(),
              ]),
              const SizedBox(
                height: 32,
              ),
              SettingsGroup(title: "FEEDBACK", children: <Widget>[
                builFeedback(context),
              ]),
            ],
          ))),
    );
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

  Widget buildHistory() => SimpleSettingsTile(
        title: 'History',
        subtitle: '',
        leading: IconWidget(icon: Icons.history, color: Colors.green),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HistoryCustomer()));
        },
      );

  Widget buildApp() => SimpleSettingsTile(
        title: 'Application',
        subtitle: '',
        leading: IconWidget(icon: Icons.history, color: Colors.yellow),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ApplicationCustomer()));
        },
      );

  Widget builFeedback(BuildContext context) => SimpleSettingsTile(
        title: 'Send Feeback',
        subtitle: '',
        leading: IconWidget(icon: Icons.thumb_up, color: Colors.purple),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FeedbackUser()));
        },
      );

  Widget buildAccount() => SimpleSettingsTile(
        title: 'Account',
        subtitle: '',
        leading: IconWidget(icon: Icons.person, color: Colors.orange),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Accountuser()));
        },
      );
}
