import 'dart:io';
import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final Function(String? value)? onChange;
  final TextEditingController? controller;
  final String? label;
  final bool? obscureText;
  final int? maxLength;

  const LoginTextField({
    super.key,
    this.controller,
    this.label,
    this.onChange,
    this.obscureText,
    this.maxLength
  });

  @override
  State<LoginTextField> createState() => _LoginTexFieldState();
}

class _LoginTexFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.black,
        keyboardType:
            Platform.isIOS
                ? const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                )
                : TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.done,
        maxLength: widget.maxLength,
        maxLines: 1,
        obscureText: widget.obscureText ?? false,
        style: const TextStyle(
          fontSize: 16,
          letterSpacing: 1,
          color: Colors.black,
        ),
        expands: false,
        decoration: InputDecoration(
          labelText: widget.label,
          hintStyle: const TextStyle(
            fontSize: 14,
            height: 6.5,
            letterSpacing: 4,
          ),
          counter: const Offstage(),
          border: const OutlineInputBorder(),
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
