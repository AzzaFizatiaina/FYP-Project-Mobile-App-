import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyp_project/user/bookinguser.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

class MapUser extends StatefulWidget {
  const MapUser({Key? key}) : super(key: key);

  @override
  State<MapUser> createState() => _MapUserState();
}

class _MapUserState extends State<MapUser> {
  var addressController = new TextEditingController();
  late GoogleMapController mapController;
  Set<Marker> _makers = Set<Marker>();

  @override
  void initState() {
    super.initState();

    _setMarker(LatLng(4.2105, 101.9758));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _makers.add(Marker(markerId: MarkerId('marker'), position: point));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF4511E),
          elevation: 0,
          title: Text("Google Maps"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookingUser()));
            },
          ),
        ),
        body: Container(
            child: Column(children: [
          SizedBox(
            height: 5,
          ),
          SearchMapPlaceWidget(
              hasClearButton: true,
              placeType: PlaceType.address,
              placeholder: 'Enter the Location',
              apiKey: 'AIzaSyAcW5vg5ocek09qyMRD6YdJcg1_i7rGflc',
              onSelected: (Place place) async {
                Geolocation? geolocation = await place.geolocation;
                mapController.animateCamera(
                    CameraUpdate.newLatLng(geolocation?.coordinates));
                mapController.animateCamera(
                    CameraUpdate.newLatLngBounds(geolocation?.bounds, 0));
              }),
          Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SizedBox(
                  height: 650.0,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController googleMapController) {
                      setState(() {
                        mapController = googleMapController;
                      });
                    },
                    initialCameraPosition: CameraPosition(
                        zoom: 15.0, target: LatLng(4.2105, 101.9758)),
                    mapType: MapType.normal,
                  )))
        ])));
  }
}
