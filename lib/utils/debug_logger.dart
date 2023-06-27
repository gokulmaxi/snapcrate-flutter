import 'package:flutter/foundation.dart';

void dLog(dynamic message) {
  if (kDebugMode) {
    print(message);
  }
}
