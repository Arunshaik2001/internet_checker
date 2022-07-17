
import 'dart:async';

import 'package:flutter/services.dart';

class InternetChecker {
  static const MethodChannel _channel = MethodChannel('internet_checker');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static get showAlertDialog async {
    await _channel.invokeMethod('showAlertDialog');
  }
}
