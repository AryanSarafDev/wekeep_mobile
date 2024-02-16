import 'dart:typed_data';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upi_india/upi_app.dart';
import 'package:wekeep_mobile/service/imagepicker.dart';

import '../service/upi_pay.dart';

class UpiLanding extends StatefulWidget {
  final UpiApp app;
  final String upiid;
  final double amount;

  const UpiLanding(
      {super.key,
      required this.app,
      required this.upiid,
      required this.amount});

  @override
  State<UpiLanding> createState() => _UpiLandingState();
}

class _UpiLandingState extends State<UpiLanding> {
  TextEditingController key1 = TextEditingController();
  TextEditingController key2 = TextEditingController();
  TextEditingController key3 = TextEditingController();
  TextEditingController key4 = TextEditingController();
  var image = null;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add a picture",
                              style: TextStyle(
                                  color: Colors.white, fontSize: height * 0.03),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              pickimage im = pickimage();
                              im.clickimage().then((value) {
                                setState(() {
                                  image = value;
                                });
                              });
                            },
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.purple,
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black45)),
                          ),
                        ],
                      ),
                    ),
                    image != null
                        ? Image(
                            image: image,
                            height: height * 0.25,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.09),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Payment Details",
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.03),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Payment to: ${widget.upiid}",
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.025),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Amount : ${widget.amount}",
                            style: TextStyle(
                                color: Colors.white, fontSize: height * 0.025),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Payment mode : ${widget.app.name}",
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.025),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.09),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: key1,
                          cursorColor: Colors.purple,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(255, 255, 255, 0.09),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Enter Title',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          minLines: 4,
                          maxLines: 5,
                          controller: key2,
                          cursorColor: Colors.purple,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(255, 255, 255, 0.09),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Enter Details',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                UpiPayment upipay = UpiPayment();
                upipay.initiateTransaction(
                    widget.app, widget.upiid, widget.amount);
              },
              child: Text("Pay"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                Color.fromRGBO(255, 255, 255, 0.09),
              )),
            )
          ],
        ),
      ),
    );
  }
}
