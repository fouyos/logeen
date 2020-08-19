import 'package:awas/presentation/device/widgets/device_bluetooth_state_widget.dart';
import 'package:awas/presentation/device/widgets/find_bluetooth_devices_widget.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DeviceScreen extends StatelessWidget {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        centerTitle: true,
        title: const Text(
          'Devices',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 28,
            shadows: [
              Shadow(
                color: Colors.black38,
                offset: Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 2,
              )
            ],
            color: Colors.black87,
          ),
        ),
      ),
      body: StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (
          context,
          snapshot,
        ) {
          final _state = snapshot.data;

          if (_state == BluetoothState.on) {
            return const FindDevicesWidget();
          } else {
            return BluetoothStateWidget(
              _state,
            );
          }
        },
      ),
    );
  }
}
