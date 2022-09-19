import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerProvider extends ChangeNotifier {
  File? _image;

  File? get image => _image;
}