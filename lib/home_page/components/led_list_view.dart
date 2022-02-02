import 'package:flutter/widgets.dart';
import 'package:iot_app/esp_sensors/esp_store/leds_store/leds_store.dart';
import 'package:provider/src/provider.dart';

class LedListView extends StatefulWidget {
  const LedListView({Key? key}) : super(key: key);

  @override
  _LedListViewState createState() => _LedListViewState();
}

class _LedListViewState extends State<LedListView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final store = context.read<LedsStore>();
      store.fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<LedsStore>();

    return ValueListenableBuilder(
        valueListenable: store.ledListView, builder: _builder);
  }

  Widget _builder(BuildContext context, Widget value, _) => value;
}
