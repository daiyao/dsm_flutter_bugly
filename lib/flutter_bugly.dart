import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBugly {
  static const MethodChannel _channel = const MethodChannel('flutter_bugly');

  // static Future<String> get platformVersion async {
  //   final String version = await _channel.invokeMethod('getPlatformVersion');
  //   return version;
  // }

  static void initBugly(String key) {
    _channel.invokeMethod('initBugly', key);
  }
  static void bugReport(String content){
    _channel.invokeMethod('bugReport', content);
  }
  static void putUserData(Map userData){
    _channel.invokeMethod('putUserData', userData);
  }
}
