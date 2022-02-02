import 'package:flutter/material.dart';

class TemperatureLoadingView extends StatelessWidget {
  const TemperatureLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: SizedBox(
        child: CircularProgressIndicator(),
        width: 20,
        height: 20,
      ),
    );
  }
}