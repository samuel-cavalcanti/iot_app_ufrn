import 'package:flutter/material.dart';
import 'package:iot_app/control_led_by_motion/led_motion_controller.dart';
import 'package:iot_app/esp_sensors/esp_service/esp_service.dart';
import 'package:iot_app/esp_sensors/esp_service/http_esp_service.dart';
import 'package:iot_app/esp_sensors/esp_store/leds_store/leds_store.dart';
import 'package:iot_app/esp_sensors/esp_store/temperature_store/temperature_store.dart';
import 'package:iot_app/http_client/http_io.dart';
import 'package:iot_app/motion_sensor/motion_sensor_controller.dart';
import 'package:provider/provider.dart';
import 'home_page/home_page.dart';
import 'http_client/fake_http_client.dart';

class SimpleIOTapp extends StatelessWidget {
  const SimpleIOTapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple IOT app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        Provider(create: (_) => MotionSensor()),
        Provider<HttpIO>(create: (_) => FakeHTTPClient()),
        Provider<EspService>(
            create: (context) => HttpEspService(io: context.read())),
        Provider(create: (context) => LedsStore(context.read())),
        ChangeNotifierProvider(
            create: (context) => TemperatureStore(context.read())),
        Provider(
            create: (context) => LedMotionController(
                ledsStore: context.read(), sensors: context.read())),
      ], child: const HomePage(title: 'Simple Iot app')),
    );
  }
}
