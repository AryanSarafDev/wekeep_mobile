import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_india.dart';
import 'package:wekeep_mobile/login_screen.dart';
import 'package:wekeep_mobile/screens/payment_screen.dart';
import 'package:wekeep_mobile/screens/serviceproviders/profilePage.dart';
import 'package:wekeep_mobile/service/upi_pay.dart';

import '../../cubits/login_cubit/login_cubit.dart';
import '../../cubits/login_cubit/login_state.dart';
import '../../models/Users.dart';
import '../../service/auth.dart';
import '../../service/database.dart';
import '../../service/presisting_data.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key, required this.user});
  final Users user;
  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  String name = "";
  List servs = [];
  List servshop = [];
  List<UpiApp>? apps;
  UpiIndia _upiIndia = UpiIndia();

  FetchData data = FetchData();
  @override
  void initState() {
    super.initState();

    data.getusername().then((value) {
      setState(() {
        name = value!;
      });
    });
    data.getnearservicelist().then((value) {
      setState(() {
        servs = value;
      });
    });
    data.getnearStorelist().then((value) {
      setState(() {
        servshop = value;
      });
    });
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
        print(apps);
      });
    }).catchError((e) {
      apps = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthManagement auth = AuthManagement();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SharedPref pref = SharedPref();
    SendData send = SendData();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.09),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Welcome",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.06),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      auth.logout().then((value) {
                                        BlocProvider.of<LoginCubit>(context)
                                            .logout;
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            const Login_Form()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      });
                                    },
                                    child: Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black45)),
                                  ),
                                ],
                              ),
                              Text(
                                "$name",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.06),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.09),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.black45,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 8, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text(
                                    "🏪 Service Stations Nearby",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.025),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          data.getnearStorelist().then((value) {
                                            setState(() {
                                              servshop = value;
                                            });
                                          });
                                        });
                                      },
                                      icon: Icon(
                                        Icons.refresh,
                                        color: Colors.purple,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Stationsnearyou()
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.09),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.black45,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 8, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text(
                                    "🛠️ Services Near You",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.025),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          data
                                              .getnearservicelist()
                                              .then((value) {
                                            setState(() {
                                              servs = value;
                                            });
                                          });
                                        });
                                      },
                                      icon: Icon(
                                        Icons.refresh,
                                        color: Colors.purple,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Servicesnearyou()
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Servicesnearyou() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.09),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: height * 0.36,
      child: ListView.builder(
          itemCount: servs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          height: height * 0.3,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: ListView.builder(
                              itemCount: apps!.length,
                              itemBuilder: (context, index2) {
                                print(apps![index2].name);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UpiLanding(
                                              app: apps![index2],
                                              upiid: servs[index]['upi'],
                                              amount:
                                                  servs[index]['price'] + 0.0),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(apps![index2].name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.028,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Service: ${servs[index]['name']}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: height * 0.028,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "₹ ${servs[index]['price']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          servs[index]['details'],
                          style: TextStyle(
                              color: Colors.black, fontSize: height * 0.025),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget Stationsnearyou() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.09),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: height * 0.36,
      child: ListView.builder(
          itemCount: servshop.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StationPage(details: servshop[index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${servshop[index]['username']}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: height * 0.028,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "4.3 ⭐",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          servshop[index]['type'],
                          style: TextStyle(
                              color: Colors.black, fontSize: height * 0.025),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
