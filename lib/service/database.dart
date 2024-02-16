import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wekeep_mobile/models/Services.dart';
import 'package:wekeep_mobile/models/Users.dart';
import 'package:wekeep_mobile/models/Warranty.dart';
import 'package:wekeep_mobile/service/presisting_data.dart';
import 'dart:math' show cos, sqrt, asin;

import '../models/Messages.dart';

class FetchData {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  Future<List> getRegisteredlist() async {
    SharedPref pref = SharedPref();
    String? id = await pref.getid();
    List data = [];
    await db.collection('Warranty').get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        var mapp = docSnapshot.data();
        mapp['id'] = docSnapshot.id;
        if (docSnapshot.data()["pending"] == false &&
            docSnapshot.data()["orguid"] == id) data.add(mapp);
      }
    });
    print(data);
    return data;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<Users> model() async {
    Users UserModel = Users(id: "", username: "", type: "", long: 0, lat: 0, email: "", isorg: false);
    db.collection('users').doc(auth.currentUser!.uid).get().then((value) {
      UserModel = Users.fromJson(value.data()!);
    });
    return UserModel;
  }

  Future<String?> getusername() async {
    SharedPref pref = SharedPref();
    String? id = await pref.getid();
    var data;

    await db.collection('users').doc(id!).get().then((DocumentSnapshot value) {
      data = value.data() as Map<String, dynamic>;
    }); //this line change

    return data['username'];
  }

  Future<bool?> gettype() async {
    SharedPref pref = SharedPref();
    String? id = await pref.getid();
    var data;
    await db.collection('users').doc(id!).get().then((DocumentSnapshot value) {
      data = value.data() as Map<String, dynamic>;
    });
    print("${data['isorg']} hahahah");
    return data['isorg'];
  }

  Future<List> getservicelist() async {
    List data = [];
    SharedPref _pref = SharedPref();
    String? id = await _pref.getid();
    var data2;
    await db.collection('services').get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        data.add(docSnapshot.data());
      }
    });
    print(data);
    return data;
  }

  Future<List> getnearservicelist() async {
    List services = [];
    SharedPref _pref = SharedPref();
    String? id = await _pref.getid();
    var data;

    await db.collection('users').doc(id!).get().then((DocumentSnapshot value) {
      data = value.data() as Map<String, dynamic>;
    }); //this line change
    print(data['long']);
    double lat1 = data['lat'];
    double long1 = data['long'];
    List serv = [];
    await db.collection('services').get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        serv.add(docSnapshot.data());
      }
    });
    print(serv);
    for (int i = 0; i < serv.length; i++) {
      double lat2 = serv[i]['lat'];
      double long2 = serv[i]['long'];
      var radius = calculateDistance(lat1, long1, lat2, long2);
      print(radius);
      if (radius <= 1) {
        services.add(serv[i]);
      }
    }
    return services;
  }

  Future<List> getUserWarranty(String orgid) async {
    List warranties = [];
    SharedPref _pref = SharedPref();
    String? id = await _pref.getid();
    db.collection("Warranty").where("useruid", isEqualTo: id).get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          warranties.add(docSnapshot.data());
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return warranties;
  }

  Future<List> getnearStorelist() async {
    SharedPref _pref = SharedPref();
    String? id = await _pref.getid();
    var data;

    await db.collection('users').doc(id!).get().then((DocumentSnapshot value) {
      data = value.data() as Map<String, dynamic>;
    }); //this line change
    print(data['long']);
    double lat1 = data['lat'];
    double long1 = data['long'];
    List serv = [];
    await db.collection('users').get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        serv.add(docSnapshot.data());
      }
    });
    print(serv);
    List services = [];
    for (int i = 0; i < serv.length; i++) {
      double lat2 = serv[i]['lat'];
      double long2 = serv[i]['long'];
      var radius = calculateDistance(lat1, long1, lat2, long2);
      print(radius);
      if (radius <= 1 && serv[i]['isorg'] == true) {
        services.add(serv[i]);
      }
    }

    return services;
  }
}

class SendData {
  final db = FirebaseFirestore.instance;

  addservice(String name, String details, int price, String upi) async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    SharedPref _pref = SharedPref();
    String? uid = await _pref.getid();
    Services services = Services(
        uid: uid!,
        name: name,
        details: details,
        lat: position.latitude,
        long: position.longitude,
        price: price,
        upi: upi);
    await db.collection('services').add(services.toJson());
  }

  updateWarranty(String id) async {
    await db.collection('Warranty').doc(id).update({"pending": true});
  }

  addWarranty(String modelno, String date, int days, String orgid, File image,
      String filename) async {
    SharedPref _pref = SharedPref();
    String? uid = await _pref.getid();
    var url;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("warranty/$filename");
    UploadTask uploadTask = ref.putFile(image);
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      Warranty warranty = Warranty(
        useruid: uid!,
        modelno: modelno,
        orguid: orgid,
        startdate: date,
        daysremaining: days,
        pending: false,
        image: url,
      );
      db.collection('Warranty').doc(uid).set(warranty.toJson());
    }).catchError((onError) {
      print(onError);
    });
  }
}
