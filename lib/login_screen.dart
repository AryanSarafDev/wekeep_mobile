import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wekeep_mobile/register_screen.dart';
import 'package:wekeep_mobile/screens/selection_load.dart';
import 'package:wekeep_mobile/service/auth.dart';

import 'cubits/login_cubit/login_cubit.dart';
import 'cubits/login_cubit/login_state.dart';

class Login_Form extends StatefulWidget {
  const Login_Form({super.key});

  @override
  State<Login_Form> createState() => _Login_FormState();
}

class _Login_FormState extends State<Login_Form> {
  int index = 0;
  List L = [];

  TextEditingController key = TextEditingController();
  TextEditingController key1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<LoginCubit, Login>(listener: (context, state) {
      if (state is LoginFalse) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login_Form()),
            (Route<dynamic> route) => false);
      } else if (state is LoginTrue) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SelectionLoad()),
            (Route<dynamic> route) => false);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 84, 0, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "We",
                        style: TextStyle(
                            color: Colors.white, fontSize: height * 0.04),
                      ),
                      Text(
                        "keep",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: height * 0.04,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
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
                            height: 200,
                            width: 200,
                          )),
                        ),
                        SizedBox(
                          height: height * 0.001,
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
                            hintText: 'Enter e-mail address',
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
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(255, 255, 255, 0.09),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(color: Colors.white54),
                          ),
                        ),
                        Text(key.text.toString()),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                _submit();
                              },
                              child: const Text('Login'),
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
                        "Dont have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Register_Form(),
                                ),
                                (route) => false);
                          },
                          child: Text("Register!",
                              style: TextStyle(color: Colors.purple)))
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      );
    });
  }

  void _submit() async {
    AuthManagement auth = AuthManagement();
    await auth
        .login(key.text, key1.text)
        .then((value) => BlocProvider.of<LoginCubit>(context).login(value));
  }
}
