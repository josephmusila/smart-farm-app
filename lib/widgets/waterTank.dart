import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
//import wave package

//set this class to home: attribute of MaterialApp() at main.dart
class WaterTank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      color: Colors.white,
      child: WaveWidget(
        //user Stack() widget to overlap content and waves
        config: CustomConfig(
          colors: [
            Colors.blue.withOpacity(0.3),
            Colors.blue.withOpacity(0.3),
            Colors.blue.withOpacity(0.3),
            //the more colors here, the more wave will be
          ],
          durations: [4000, 5000, 7000],
          //durations of animations for each colors,
          // make numbers equal to numbersof colors
          heightPercentages: [0.3, 0.3, 0.3],
          //height percentage for each colors.
          blur: MaskFilter.blur(BlurStyle.solid, 5),
          //blur intensity for waves
        ),
        waveAmplitude: 5.00, //depth of curves
        waveFrequency: 3, //number of curves in waves
        backgroundColor: Colors.white, //background colors
        size: Size(
          double.infinity,
          double.infinity,
        ),
      ),
    );
  }
}
