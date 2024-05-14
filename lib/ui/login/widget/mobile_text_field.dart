import 'dart:io';

import 'package:flutter/material.dart';

class MobileTextField extends StatefulWidget {
  final Function(String? value) onSave;
  final Function(String? value) onChange;

  const MobileTextField(
      {super.key, required this.onSave, required this.onChange});

  @override
  State<MobileTextField> createState() => _MobileTextFieldState();
}

class _MobileTextFieldState extends State<MobileTextField> {
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            child: const Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.flag,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("+91"),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            onTap: () {},
          ),
          Container(
            width: 2,
            color: Colors.black,
          ),
          Expanded(
            child: TextFormField(
              controller: _editingController,
              keyboardType: Platform.isIOS?
              const TextInputType.numberWithOptions(signed: true, decimal: true)
                  : TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.done,
              maxLength: 10,
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 14, letterSpacing: 4, color: Colors.black),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "******1234",
                hintStyle:
                    TextStyle(fontSize: 14, height: 6.5, letterSpacing: 4),
                counter: Offstage(),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
              ),

              onChanged: widget.onChange,
              onSaved: widget.onSave,
              validator: (value) {
                if (value == null) {
                  return "Please enter mobile number";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
