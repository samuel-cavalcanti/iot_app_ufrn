import 'package:flutter/widgets.dart';

import 'package:iot_app/esp_sensors/esp_store/temperature_store/temperature_store.dart';
import 'package:provider/src/provider.dart';

class TemperatureView extends StatefulWidget {
  const TemperatureView({Key? key}) : super(key: key);

  @override
  _TemperatureViewState createState() => _TemperatureViewState();
}

class _TemperatureViewState extends State<TemperatureView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final store = context.read<TemperatureStore>();
      store.fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text('Temperatura '),
        ),
        context.watch<TemperatureStore>().value,
      ],
    );
  }
}
