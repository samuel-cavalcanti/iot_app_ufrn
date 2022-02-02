import 'package:sensors_plus/sensors_plus.dart' as sensors;

import 'high_pass_filter.dart';

class MotionSensor {
  final _highPassFilter = HighPassFilter();

  Stream<List<double>> get accelerometer => sensors.accelerometerEvents
      .asyncMap((event) => _highPassFilter.filter([event.x, event.y, event.z]));
}
