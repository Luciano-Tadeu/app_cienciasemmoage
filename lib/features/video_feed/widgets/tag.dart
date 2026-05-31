import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;

  const Tag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(102, 30, 30, 30),
        borderRadius: BorderRadius.all(Radius.circular(999))
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 6, horizontal: 12),
        child: Text(
          text,
          style: TextStyle(fontSize: 14)
        ),
      ),
    );
  }

}