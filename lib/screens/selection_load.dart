import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wekeep_mobile/screens/customer/customer_screen.dart';
import 'package:wekeep_mobile/screens/serviceproviders/service_screen.dart';

import '../cubits/login_cubit/login_cubit.dart';
import '../service/database.dart';

class SelectionLoad extends StatefulWidget {
  const SelectionLoad({super.key});

  @override
  State<SelectionLoad> createState() => _SelectionLoadState();
}

class _SelectionLoadState extends State<SelectionLoad> {
  bool isorg = false;
  FetchData data = FetchData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    data.model().then((value) {
      setState(() {
        isorg = value.isorg;
        if(isorg){
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) =>ServiceScreen(user:value),
            ),(Route route) => false
          );
        }
        else
          {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>CustomerScreen(user:value),
              ),(Route route) => false
            );
          }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
