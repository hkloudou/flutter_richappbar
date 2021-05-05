import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_richappbar/flutter_richappbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     platformVersion = await FlutterRichappbar.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // appBarTheme: AppBarTheme(
          //   foregroundColor: Color(0xFF606266),
          //   backgroundColor: Colors.white,
          //   brightness: Brightness.light,
          //   backwardsCompatibility: false,
          // ),
          ),
      home: RichAppBarPage(
        title: "动态标题",
        onRefresh: () {
          print("re");
          return Future.value();
        },
        body: Container(
          height: 100,
          width: double.infinity,
          color: Colors.red,
          child: Text("测试"),
        ),
      ),
    );
  }
}
