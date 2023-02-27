import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_project/models/ambulance.dart';

class AuthenticationService {
// registration with email and password

  Future createNewAmbulance(String drivername, String driverno, String location,
      String noplat) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final user = FirebaseAuth.instance.currentUser!;
      await DatabaseManager()
          .createUserData(drivername, driverno, location, noplat, user.uid);
    } catch (e) {
      print(e.toString());
    }
  }
}
