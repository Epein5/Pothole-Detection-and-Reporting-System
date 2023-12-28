import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String text;
  Color color;
  VoidCallback? onPressed;
  Button(
      {super.key,
      required this.text,
      required this.color,
       this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade200,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

