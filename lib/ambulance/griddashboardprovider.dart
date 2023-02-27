import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:fyp_project/ambulance/detailsambulanceprovider.dart';
import 'package:fyp_project/ambulance/detailscustomer.dart';
import 'package:fyp_project/ambulance/feedbackcustomer.dart';

class GridDashboardProvider extends StatefulWidget {
  const GridDashboardProvider({Key? key}) : super(key: key);

  @override
  State<GridDashboardProvider> createState() => _GridDashboardProviderState();
}

class _GridDashboardProviderState extends State<GridDashboardProvider> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.count(
        crossAxisCount: 1,
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DetailsAmbulanceProvider()),
                );
              },
              splashColor: Colors.black,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      TablerIcons.ambulance,
                      size: 100.0,
                    ),
                    Text("Ambulance", style: new TextStyle(fontSize: 17.0))
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DtailsCust()),
                );
              },
              splashColor: Colors.black,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 90.0,
                    ),
                    Text("Customer", style: new TextStyle(fontSize: 17.0))
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FeedbackCustomer()),
                );
              },
              splashColor: Colors.black,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.thumb_up,
                      size: 90.0,
                    ),
                    Text("Feedback", style: new TextStyle(fontSize: 17.0))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
