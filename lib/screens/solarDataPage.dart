import 'package:farm/models/solarData.dart';
import 'package:flutter/material.dart';

class SolarDataPage extends StatelessWidget {
  SolarData solarData;

  SolarDataPage({required this.solarData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Center(
        child: Text("data loaded"),
      ),
    );
  }
}
