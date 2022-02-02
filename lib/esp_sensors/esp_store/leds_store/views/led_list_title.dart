import 'package:flutter/material.dart';
import 'package:iot_app/esp_sensors/models/led.dart';
import 'package:provider/src/provider.dart';

import '../leds_store.dart';

extension LedMaterialColor on LedColor {
  Color get materialColor {
    switch (this) {
      case LedColor.white:
        return Colors.grey.shade300;
      case LedColor.red:
        return Colors.red.shade800;
      case LedColor.blue:
        return Colors.blue.shade800;
      case LedColor.green:
        return Colors.green.shade800;
      case LedColor.yellow:
        return Colors.yellow.shade800;
    }
  }
}

class LedListTile extends StatelessWidget {
  final ValueNotifier<Led> led;

  const LedListTile({Key? key, required this.led}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: led,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, Led value, _) {
    return ListTile(
      onTap: () => context.read<LedsStore>().updateLedStatus(led),
      leading: Icon(
        Icons.lightbulb,
        color: value.color.materialColor,
      ),
      title: Text('LED ${value.id}'),
      trailing: _ledStatusWidget(context, value),
    );
  }

  Widget _ledStatusWidget(BuildContext context, Led value) {
    const loading = CircularProgressIndicator();
    final complete = Text(
      value.status.name.toUpperCase(),
      style: Theme.of(context)
          .textTheme
          .button
          ?.merge(TextStyle(color: Theme.of(context).primaryColor)),
    );

    switch (led.value.status) {
      case LedStatus.on:
        return complete;
      case LedStatus.off:
        return complete;
      case LedStatus.posting:
        return loading;
    }
  }
}
