import 'package:flutter/widgets.dart';

class MotionSensorText extends StatelessWidget {
  final Stream<List<double>> motionEvents;
  final _initialSensorValue = [double.nan, double.nan, double.nan];
  MotionSensorText({Key? key, required this.motionEvents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: _builder,
      initialData: _initialSensorValue,
      stream: motionEvents,
    );
  }

  Widget _builder(BuildContext context, AsyncSnapshot<List<double>> snapshot) {
    final sensorValue = snapshot.data ?? _initialSensorValue;

    return Text(valuesToText(sensorValue));
  }

  String valuesToText(List<double> values) {
    const precision = 3;
    final x = values[0].toStringAsFixed(precision);
    final y = values[1].toStringAsFixed(precision);
    final z = values[2].toStringAsFixed(precision);

    return 'x: $x y: $y z: $z';
  }
}
