import 'dart:typed_data';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upi_india/upi_app.dart';
import 'package:wekeep_mobile/service/database.dart';
import 'package:wekeep_mobile/service/imagepicker.dart';

class Warrantyform extends StatefulWidget {
  final String orgid;
  const Warrantyform({
    super.key,
    required this.orgid,
  });

  @override
  State<Warrantyform> createState() => _WarrantyformState();
}

class _WarrantyformState extends State<Warrantyform> {
  TextEditingController key1 = TextEditingController();
  TextEditingController key2 = TextEditingController();
  TextEditingController key3 = TextEditingController();
  TextEditingController key4 = TextEditingController();
  var image = null;
  var filename = " ";
  var upload;
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
                      child: Text(
                        "Receipt Picture",
                        style: TextStyle(
                            color: Colors.white, fontSize: height * 0.03),
                      ),
                    ),
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
                                  image = value["image"];
                                  filename = value["path"];
                                  upload= value["upload"];
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Enter Warranty Details",
                          style: TextStyle(
                              color: Colors.white, fontSize: height * 0.03),
                        ),
                      ),
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
                            hintText: 'Model Number',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: key2,
                          cursorColor: Colors.purple,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(255, 255, 255, 0.09),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Purchase Date: DD-MM-YYYY',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: key3,
                          cursorColor: Colors.purple,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(255, 255, 255, 0.09),
                            filled: true,
                            border: InputBorder.none,
                            hintText: 'Warranty Period (In Months)',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  SendData().addWarranty(
                      key1.text,
                      key2.text,
                      (int.parse(key3.text) * 30) - daysSince(key2.text),
                      widget.orgid,
                      upload,
                      filename);
                  Navigator.pop(context);
                },
                child: Text("Submit"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Color.fromRGBO(255, 255, 255, 0.09),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// Import the dart:core library to use the DateTime class

// A function that takes a date string as a parameter and returns the number of days between that date and today
int daysSince(String date) {
  // Split the date string by the hyphen character and store the parts in a list
  List<String> parts = date.split('-');

  // Convert the parts into integers and create a DateTime object with the year, month, and day values
  DateTime parsedDate =
      DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));

  // Get the current date as a DateTime object
  DateTime today = DateTime.now();

  // Calculate the difference between the two dates as a Duration object
  Duration difference = today.difference(parsedDate);

  // Return the difference in days as an integer
  return difference.inDays;
}
