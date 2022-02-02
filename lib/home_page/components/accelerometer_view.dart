import 'package:flutter/material.dart';
import 'package:iot_app/motion_sensor/motion_sensor_controller.dart';
import 'package:iot_app/motion_sensor/motion_sensor_text.dart';
import 'package:provider/provider.dart';

class AccelerometerView extends StatelessWidget {
  const AccelerometerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MotionSensor motionSensor = context.read<MotionSensor>();
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Text('Acelerômetro'),
          ),
          MotionSensorText(motionEvents: motionSensor.accelerometer),
        ],
      ),
    );
  }
}
