import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wekeep_mobile/models/Users.dart' as use;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wekeep_mobile/service/presisting_data.dart';
import 'package:geolocator/geolocator.dart';

class AuthManagement {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future signup(String email, String password, bool isorg, String username,
      String type) async {
    try {
      final UserCredential user =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String uid = user.user!.uid;
      use.Users profile = use.Users(
          email: email,
          type: type,
          isorg: isorg,
          id: uid,
          lat: position.latitude,
          long: position.longitude,
          username: username);
      await db.collection('users').doc(uid).set(profile.toJson());
      SharedPref _pref = SharedPref();
      _pref.storeUser(user);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }

  }

  Future logout() async {
    await auth.signOut();
  }

  Future login(String email, String password) async {
    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      SharedPref _pref = SharedPref();
      _pref.storeUser(user);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
