import 'package:flutter/services.dart';

class FlutterAwsIvsController {
  late MethodChannel _channel;

  FlutterAwsIvsController.init(int id) {
    _channel = MethodChannel('flutter_aws_ivs_$id');
  }

  Future<void> joinStage(String? token) async {
    assert(token != null);
    return _channel.invokeMethod('joinStage', token);
  }

  Future<void> initView() async {
    return _channel.invokeMethod('initView');
  }

  Future<bool?> toggleLocalVideoMute() async {
    return _channel.invokeMethod<bool>('toggleLocalVideoMute');
  }
}
