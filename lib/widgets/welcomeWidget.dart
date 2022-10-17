import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      child: const Center(
        child: Text(
          "Farm 1 Data Panel",
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
