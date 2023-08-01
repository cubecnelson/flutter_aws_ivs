import 'package:flutter/services.dart';

const onErrorMethodName = "onError";
const onConnectionStateChangedMethodName = "onConnectionStateChanged";
const onLocalAudioStateChangedMethodName = "onLocalAudioStateChanged";
const onLocalVideoStateChangedMethodName = "onLocalVideoStateChanged";
const onBroadcastStateChangedMethodName = "onBroadcastStateChanged";

class FlutterAwsIvsController {
  late MethodChannel _channel;
  FlutterAwsIvsControllerListener? _listener;

  setListener(FlutterAwsIvsControllerListener listener) {
    this._listener = listener;
  }

  FlutterAwsIvsController.init(int id) {
    _channel = MethodChannel('flutter_aws_ivs_$id');
    _channel.setMethodCallHandler(handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall methodCall) async {
    print(methodCall.method);
    switch (methodCall.method) {
      case onErrorMethodName:
        _listener?.onError();
        return;
      case onConnectionStateChangedMethodName:
        _listener?.onConnectionStateChanged(methodCall.arguments);
        return;
      case onLocalAudioStateChangedMethodName:
        _listener?.onLocalAudioStateChanged(methodCall.arguments);
        return;
      case onLocalVideoStateChangedMethodName:
        _listener?.onLocalVideoStateChanged(methodCall.arguments);
        return;
      case onBroadcastStateChangedMethodName:
        _listener?.onBroadcastStateChanged(methodCall.arguments);
        return;
    }
    return;
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

abstract class FlutterAwsIvsControllerListener {
  onError();
  onConnectionStateChanged(int state);
  onLocalAudioStateChanged(bool isMuted);
  onLocalVideoStateChanged(bool isMuted);
  onBroadcastStateChanged(bool isBroadcasting);
}
