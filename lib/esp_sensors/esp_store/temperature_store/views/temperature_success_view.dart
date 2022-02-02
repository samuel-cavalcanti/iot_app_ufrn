
import 'package:flutter/material.dart';

class TemperatureSuccessView extends StatelessWidget {
  final double temperature;
  const TemperatureSuccessView({Key? key, required this.temperature})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${temperature.floor()}º C',
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}