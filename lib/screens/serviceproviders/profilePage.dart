import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_india.dart';
import 'package:wekeep_mobile/screens/ChatScreen.dart';
import 'package:wekeep_mobile/screens/customer/submitWarranty.dart';
import 'package:wekeep_mobile/service/database.dart';

import '../../cubits/login_cubit/login_cubit.dart';
import '../../cubits/login_cubit/login_state.dart';
import '../../login_screen.dart';
import '../../service/auth.dart';
import '../../service/presisting_data.dart';
import '../payment_screen.dart';

class StationPage extends StatefulWidget {
  final Map details;

  StationPage({super.key, required this.details});

  @override
  State<StationPage> createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  List servs = [];
  FetchData data = FetchData();


  List<UpiApp>? apps;
  UpiIndia _upiIndia = UpiIndia();
  SharedPref pref = SharedPref();
  String uid = " ";
  List wars = [];
  @override
  void initState() {
    print(widget.details);
    FetchData().getUserWarranty(widget.details['id']).then((value) {
      setState(() {
        wars = value;
      });
    });
    data.getnearservicelist().then((value) {
      setState(() {
        servs = value;
      });
    });

    pref.getid().then((value) {
      setState(() {
        uid = value!;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen(details: widget.details),
              ),
            );
          },
          backgroundColor: Color(0xFFf07900),
          child: Icon(
            Icons.chat_bubble,
            color: Colors.white,
          ),
        ),
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
                                    "Welcome to",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.04),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.store,
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
                                "${widget.details["username"]}",
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
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Warrantyform(
                          orgid: widget.details['id'],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Add a Warranty +",
                    style:
                        TextStyle(color: Colors.white, fontSize: height * 0.04),
                  ),
                  style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(Color(0xFFf07900)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(255, 255, 255, 0.09))),
                ),
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
                                    "📝 Your Warranties",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.025),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          pref.getid().then((value) {
                                            setState(() {
                                              uid = value!;
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
                        yourWarranty()
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
                                    "🛠️ Services",
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

  Widget yourWarranty() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.09),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: height * 0.3,
      child: ListView.builder(
          itemCount: wars.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
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
                              "${wars[index]['modelno']}",
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
                                  "days left : ${wars[index]['daysremaining']}",
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
                          "Verified : ${wars[index]['pending']}",
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
                              itemBuilder: (context, index) {
                                print(apps![index].name);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UpiLanding(
                                              app: apps![index],
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
                                          child: Text(apps![index].name,
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
}
