import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_aws_ivs/controllers/flutter_aws_ivs_controller.dart';
import 'package:flutter_aws_ivs/flutter_aws_ivs.dart';
import 'package:flutter_aws_ivs/views/flutter_aws_ivs_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  late FlutterAwsIvsController _controller;
  // final _flutterAwsIvsPlugin = FlutterAwsIvs();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // try {
    //   platformVersion =
    //       await _flutterAwsIvsPlugin.getPlatformVersion() ?? 'Unknown platform version';
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }

  void _onFlutterAwsIvsViewCreated(FlutterAwsIvsController controller) {
    _controller = controller;
    controller.initView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                  onPressed: () {
                    if (_controller != null) {
                      _controller.toggleLocalVideoMute();
                    }
                  },
                  child: Text('Mute')),
              Expanded(
                child: FlutterAwsIvsView(
                  onAwsIvsCreated: _onFlutterAwsIvsViewCreated,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
