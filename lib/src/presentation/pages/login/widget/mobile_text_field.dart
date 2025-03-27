import 'dart:io';
import 'package:flutter/material.dart';

class MobileTextField extends StatefulWidget {
  final Function(String? value) onChange;
  final TextEditingController? controller;

  const MobileTextField({super.key, required this.onChange, this.controller});

  @override
  State<MobileTextField> createState() => _MobileTextFieldState();
}

class _MobileTextFieldState extends State<MobileTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.black,
        keyboardType: Platform.isIOS
            ? const TextInputType.numberWithOptions(signed: true, decimal: true)
            : TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.done,
        maxLength: 10,
        maxLines: 1,
        style: const TextStyle(
            fontSize: 16, letterSpacing: 1, color: Colors.black),
        expands: false,
        decoration: const InputDecoration(
          // filled: true,
          //  hintText: "******1234",
          labelText: "Mobile Number",
          hintStyle: TextStyle(fontSize: 14, height: 6.5, letterSpacing: 4),
          counter: Offstage(),
          border: OutlineInputBorder(),
        ),
        onChanged: widget.onChange,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter mobile number";
          }
          return null;
        },
      ),
    );
  }
}
