import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class pickimage {
  final ImagePicker picker = ImagePicker();
  Future clickimage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final Uint8List bytes = await image!.readAsBytes();
    return {"image": Image.memory(bytes).image, "path": basename(image.path),"upload":File(image.path)};
  }
}
