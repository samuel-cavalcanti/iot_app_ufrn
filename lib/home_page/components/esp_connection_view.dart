import 'package:flutter/material.dart';
import 'package:iot_app/esp_sensors/esp_service/esp_service.dart';
import 'package:iot_app/esp_sensors/esp_service/http_esp_service.dart';
import 'package:provider/src/provider.dart';

class EspConnectionView extends StatelessWidget {
  const EspConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final espService = context.read<EspService>() as HttpEspService;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text.rich(
        TextSpan(children: [
          const TextSpan(text: 'Esp '),
          TextSpan(
              text: espService.baseURL,
              style: Theme.of(context).textTheme.caption)
        ]),
        style: const TextStyle(fontSize: 25.0),
      ),
    );
  }
}
