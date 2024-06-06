import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String text;
  final Function() onPress;

  const LoadingButton({super.key, required this.text, required this.onPress});

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            fixedSize: const Size(240, 40),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        onPressed: isLoading
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                await widget.onPress();
                setState(() {
                  isLoading = false;
                });
              },
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.blue.shade900,
                ))
            : Text(
                widget.text,
                style: const TextStyle(color: Colors.white),
              ));
  }
}
