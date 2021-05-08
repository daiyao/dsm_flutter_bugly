import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bugly/flutter_bugly.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (Platform.isAndroid) {
      FlutterBugly.initBugly("e36b8bc964");
    } else if (Platform.isIOS) {
      FlutterBugly.initBugly("3b9f2976ce");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // FlutterBugly.bugReport("主动发出的异常");
                FlutterBugly.putUserData({"flutter error": "我是主动发送的异常 ${DateTime.now().microsecond}"});
              },
              child: Text("增加用户自己的数据"),
            ),
            ElevatedButton(
              onPressed: () {
                FlutterBugly.bugReport("主动发出的异常");
              },
              child: Text("上报异常"),
            )
          ],
        ),
      ),
    );
  }
}
