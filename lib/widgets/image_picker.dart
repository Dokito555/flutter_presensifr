import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:presensifr/constants/constants.dart';
import 'package:presensifr/provider/image_picker_provider.dart';
import 'package:provider/provider.dart';

class PickImage extends StatefulWidget {
  PickImage({Key? key}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {

  // File? image;

  @override
  Widget build(BuildContext context) {

    var imagePickerProvider = Provider.of<ImagePickerProvider>(context);
    var imageProvider = imagePickerProvider.image!;

    Future pickImage(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      // setState(() {
      //   this.image = imageTemporary;
      // });
      imageProvider = imageTemporary;
      Navigator.pop(context);
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
      return showCupertinoModalBottomSheet(
      context: context, 
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () => pickImage(ImageSource.camera, context)
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () => pickImage(ImageSource.gallery, context)
          )
        ],
      )
    );
  }

    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 20)),
        InkWell(
          child: imageProvider != null
          ? ClipOval(
            child: Image.file(
              imageProvider,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          )
          : Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: const Center(
              child: Icon(Icons.photo_camera, color: Colors.white,),
            ),
            width: 120, 
            height: 120,
          ),
          onTap: () {
            showImageSource(context);
          }
        ),
      ],
    );
  }
}