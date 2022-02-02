import 'package:flutter/material.dart';
import 'package:iot_app/esp_sensors/esp_store/leds_store/leds_store.dart';
import 'package:iot_app/esp_sensors/models/led.dart';
import 'package:provider/provider.dart';

import 'led_list_title.dart';

class LedListSuccessView extends StatelessWidget {
  final List<ValueNotifier<Led>> leds;

  const LedListSuccessView({Key? key, required this.leds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: _itemBuilder,
      itemCount: leds.length,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) =>
      LedListTile(led: leds[index]);
}
