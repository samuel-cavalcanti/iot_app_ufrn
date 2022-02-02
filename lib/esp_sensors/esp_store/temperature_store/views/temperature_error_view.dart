import 'package:flutter/widgets.dart';

class TemperatureErrorView extends StatelessWidget {
  final String message;
  const TemperatureErrorView({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
