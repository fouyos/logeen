import 'package:awas/presentation/core/custom_icons.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BluetoothStateWidget extends StatelessWidget {
  const BluetoothStateWidget(this._state);

  final BluetoothState _state;

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _bluetoothStateIcon(),
            const SizedBox(
              height: 16,
            ),
            _bluetoothStateText(
              context,
              _state,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _bluetoothStateIcon() {
  return NeumorphicButton(
    padding: const EdgeInsets.all(16.0),
    onPressed: () {},
    child: NeumorphicIcon(
      CustomIcons.bluetooth_disabled,
      size: 160,
    ),
  );
}

Widget _bluetoothStateText(
  BuildContext context,
  BluetoothState state,
) {
  final String _displayState =
      state != null ? state.toString().substring(15) : 'not available';

  return Text(
    'Bluetooth Adapter is $_displayState',
    textAlign: TextAlign.center,
    style: Theme.of(context).textTheme.subtitle2,
  );
}
