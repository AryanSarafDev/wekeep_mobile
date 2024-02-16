import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wekeep_mobile/cubits/login_cubit/login_cubit.dart';
import 'package:wekeep_mobile/cubits/login_cubit/login_state.dart';
import 'package:wekeep_mobile/login_screen.dart';
import 'package:wekeep_mobile/screens/selection_load.dart';
import 'package:wekeep_mobile/screens/serviceproviders/service_screen.dart';
import 'package:wekeep_mobile/service/auth.dart';

class Register_Form extends StatefulWidget {
  const Register_Form({super.key});

  @override
  State<Register_Form> createState() => _Register_FormState();
}

class _Register_FormState extends State<Register_Form> {
  int index = 0;
  List L = [];

  TextEditingController key = TextEditingController();
  TextEditingController key1 = TextEditingController();
  TextEditingController key2 = TextEditingController();
  TextEditingController key3 = TextEditingController();
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Stack(children: [
          Center(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: width * 0.8,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.09),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/login.svg',
                                height: 180,
                                width: 180,
                              )),
                            ),
                            SizedBox(
                              height: height * 0.001,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Enter username",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            TextField(
                              controller: key2,
                              cursorColor: Colors.blue,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                fillColor: Color.fromRGBO(255, 255, 255, 0.09),
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'Enter username',
                                hintStyle: TextStyle(color: Colors.white54),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Enter e-mail",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            TextField(
                              controller: key,
                              cursorColor: Colors.blue,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                fillColor: Color.fromRGBO(255, 255, 255, 0.09),
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'Enter e-mail',
                                hintStyle: TextStyle(color: Colors.white54),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Enter Password",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            TextField(
                              controller: key1,
                              cursorColor: Colors.blue,
                              keyboardType: TextInputType.visiblePassword,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                fillColor: Color.fromRGBO(255, 255, 255, 0.09),
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'Enter Password',
                                hintStyle: TextStyle(color: Colors.white54),
                              ),
                            ),

                            _value?const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Enter Service type",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ):Container(),
                            _value? TextField(
                              controller: key3,
                              cursorColor: Colors.blue,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                fillColor: Color.fromRGBO(255, 255, 255, 0.09),
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'Less than 10 words',
                                hintStyle: TextStyle(color: Colors.white54),
                              ),
                            ):Container(),
                            Center(
                              child: CheckboxListTile(
                                value: _value,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _value = newValue!;
                                  });
                                },
                                title: Text(
                                  'Are you a service Provider?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                activeColor: Colors.purple,
                                checkColor: Colors.white,
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _submit(key.text, key1.text, _value,key3.text??" ");
                                  },
                                  child: const Text('Register'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Login_Form(),
                                  ),
                                );
                              },
                              child: Text("Login!",
                                  style: TextStyle(color: Colors.purple)))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ))
        ]),
      ),
    );
  }

  void _submit(String email, String pass, bool isorg, String type) async {
    AuthManagement auth = AuthManagement();
    var user = await auth.signup(email, pass, isorg,key2.text,type);
    print("apple banana $user");
    if (user != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SelectionLoad()), (route) => false,
      );
    }
  }
}
