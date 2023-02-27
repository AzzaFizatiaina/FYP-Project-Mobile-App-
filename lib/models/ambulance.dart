import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference ambulance =
      FirebaseFirestore.instance.collection('ambulance');

  Future<void> createUserData(String drivername, String driverno,
      String location, String platno, String uid) async {
    return await ambulance.doc(uid).set({
      'driver name': drivername,
      'driverno': driverno,
      'location': location,
      'platno': platno
    });
  }
}
