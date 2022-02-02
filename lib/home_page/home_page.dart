import 'package:flutter/material.dart';
import 'package:iot_app/control_led_by_motion/led_motion_controller.dart';
import 'package:iot_app/home_page/components/accelerometer_view.dart';
import 'package:iot_app/home_page/components/temperature_view.dart';
import 'components/esp_connection_view.dart';
import 'components/led_list_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LedMotionController>(); // inicializa o LedMotionController.

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(title)),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  EspConnectionView(),
                  LedListView(),
                  TemperatureView(),
                  AccelerometerView()
                ],
              ),
            ),
          ),
        ));
  }
}
