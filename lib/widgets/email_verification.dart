import 'package:flutter/material.dart';
import 'package:presensifr/constants/constants.dart';

class BuildSheet extends StatefulWidget {
  BuildSheet({Key? key}) : super(key: key);

  @override
  State<BuildSheet> createState() => _BuildSheetState();
}

final GlobalKey<FormState> _addPointKey = GlobalKey<FormState>();
Map<String, dynamic> emaildata = {"email" : null};

class _BuildSheetState extends State<BuildSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorPalette.secondaryColor
      ),
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                _closeIcon(context),
                _emailForm(),
                // _buildButton()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _closeIcon(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      height: 60,
      decoration: const BoxDecoration(
        color: ColorPalette.primaryColor,
      ),
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const Icon(Icons.close),
        color: ColorPalette.whiteColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _emailForm() {
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      margin: EdgeInsets.all(20),
      child: TextFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.underlineTextField, width: 1.5
            )
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white, width: 3.0
            )
          ),
          hintText: "Masukkan Email",
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: ColorPalette.hintColor)
        ),
        style: const TextStyle(color: Colors.white),
        autofocus: false,
        validator: (value) {
          if (value!.isEmpty) {
            return "Email harus diisi";
          }
          return null;
        },
        onChanged: (String value) {
          emaildata["email"] = value;
        },
        onSaved: (String? value) {
          emaildata["email"] = value;
        },
      ),
    );
  }

  Widget _buildButton() {
    return InkWell();
  }
}