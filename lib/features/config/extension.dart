import 'package:flutter_dotenv/flutter_dotenv.dart';

extension ConfigString on String {
  String conf() => dotenv.get(this);
  int confInt() => dotenv.getInt(this);
  double confDouble() => dotenv.getDouble(this);
  bool confBool() => dotenv.getBool(this);
}