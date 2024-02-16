import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wekeep_mobile/service/auth.dart';
import 'package:wekeep_mobile/service/database.dart';
import 'package:wekeep_mobile/service/presisting_data.dart';

import '../../cubits/login_cubit/login_cubit.dart';
import '../../cubits/login_cubit/login_state.dart';
import '../../login_screen.dart';
import '../../models/Users.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key, required this.user});
  final Users user;

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String name = "";
  List services = [];
  FetchData data = FetchData();
  List Registered = [];
  int on = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data.getusername().then((value) {
      setState(() {
        name = value!;
      });
    });
    data.getRegisteredlist().then((value) {
      setState(() {
        Registered = value;
      });
    });
    data.getservicelist().then((value) {
      setState(() {
        services = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController key1 = TextEditingController();
    TextEditingController key2 = TextEditingController();
    TextEditingController key3 = TextEditingController();
    TextEditingController key4 = TextEditingController();
    AuthManagement auth = AuthManagement();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SharedPref pref = SharedPref();
    SendData send = SendData();

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
                                    "Welcome!",
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: key1,
                                                cursorColor: Colors.purple,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  fillColor: Color.fromRGBO(
                                                      255, 255, 255, 0.09),
                                                  filled: true,
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'Enter Service name',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                minLines: 4,
                                                maxLines: 5,
                                                controller: key2,
                                                cursorColor: Colors.purple,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  fillColor: Color.fromRGBO(
                                                      255, 255, 255, 0.09),
                                                  filled: true,
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'Enter Service details',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: key3,
                                                cursorColor: Colors.purple,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  fillColor: Color.fromRGBO(
                                                      255, 255, 255, 0.09),
                                                  filled: true,
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'Enter Price for service',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: key4,
                                                cursorColor: Colors.purple,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration:
                                                    const InputDecoration(
                                                  fillColor: Color.fromRGBO(
                                                      255, 255, 255, 0.09),
                                                  filled: true,
                                                  border: InputBorder.none,
                                                  hintText: 'Enter UPI id',
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                send.addservice(
                                                    key1.text,
                                                    key2.text,
                                                    int.parse(key3.text),
                                                    key4.text);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Submit"),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                Color.fromRGBO(
                                                    255, 255, 255, 0.09),
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Text(
                              "Add a Service +",
                              style: TextStyle(
                                  color: Colors.white, fontSize: height * 0.04),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black45)),
                          ),
                        )
                      ],
                    )),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          print(on);
                          if (on != 1) {
                            on = 1;
                            print(on);
                          } else
                            on = 0;
                        });
                      },
                      child: Container(
                        width: width * 0.45,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.09),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "5",
                                    style: TextStyle(
                                        fontSize: height * 0.05,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "🛠️ Bookings",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.03),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (on != 2) {
                            on = 2;
                          } else
                            on = 0;
                        });
                      },
                      child: Container(
                        width: width * 0.46,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.09),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "5",
                                style: TextStyle(
                                    fontSize: height * 0.05,
                                    color: Colors.white),
                              ),
                              Text(
                                "📃 Registered",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.03),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              on == 1
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.09),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(32, 8, 8, 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        Text(
                                          "Review Warranty",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: height * 0.04),
                                        ),
                                        Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                data
                                                    .getRegisteredlist()
                                                    .then((value) {
                                                  setState(() {
                                                    Registered = value;
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
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.09),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                height: height * 0.36,
                                child: ListView.builder(
                                    itemCount: Registered.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  insetPadding:
                                                      EdgeInsets.all(0),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                        height: height * 0.9,
                                                        width: width,
                                                        child: Image.network(
                                                          Registered[index]
                                                              ["imageurl"],
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        right: 0,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all(Colors
                                                                              .red)),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "Reject",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            height *
                                                                                0.02),
                                                                  )),
                                                              ElevatedButton(
                                                                  style:
                                                                      ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all(
                                                                    Colors
                                                                        .green,
                                                                  )),
                                                                  onPressed: () {
                                                                    send.updateWarranty(
                                                                        Registered[index]
                                                                            [
                                                                            "id"]);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "Accept",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            height *
                                                                                0.02),
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Model: ${Registered[index]['modelno']}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: height * 0.03,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  Registered[index]
                                                      ['startdate'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: height * 0.025),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          )),
                    )
                  : SizedBox(),
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
                                    "Your Services",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.04),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          data.getservicelist().then((value) {
                                            setState(() {
                                              services = value;
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
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.09),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: height * 0.36,
                          child: ListView.builder(
                              itemCount: services.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Service: ${services[index]['name']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: height * 0.03,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          services[index]['details'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: height * 0.025),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
