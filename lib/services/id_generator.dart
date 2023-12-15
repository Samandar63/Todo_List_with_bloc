// ignore_for_file: non_constant_identifier_names

import 'package:uuid/uuid.dart';

class IdGenerator {
  static String ID() {
    return const Uuid().v4();
  }
}
