import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomTheme {
  CustomTheme._();

  static const NeumorphicThemeData light = const NeumorphicThemeData(
    depth: 2,
    accentColor: Colors.redAccent,
    intensity: 1.0,
    buttonStyle: const NeumorphicStyle(
      boxShape: NeumorphicBoxShape.circle(),
    ),
    boxShape: NeumorphicBoxShape.stadium(),
    lightSource: LightSource.topRight,
  );
}
