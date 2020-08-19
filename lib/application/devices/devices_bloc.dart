import 'package:awas/application/devices/devices_state.dart';
import 'package:bloc/bloc.dart';

class DevicesBloc extends Cubit<DevicesState> {
  DevicesBloc()
      : super(
          const DevicesInitial(),
        );
}
