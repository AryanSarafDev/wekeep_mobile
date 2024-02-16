import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SharedPref {
  storeUser(UserCredential user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userid', user.user!.uid);
    prefs.setString('email', user.user!.email!);
  }
  Future<String?> getid() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('userid');
    return id;
  }
}
