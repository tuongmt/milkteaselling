import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String title;
  const MyTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return (Text(
      title,
      style: const TextStyle(fontSize: 22, color: Colors.black),
    ));
  }
}
