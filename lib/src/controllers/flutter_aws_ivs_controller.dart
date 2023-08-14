import 'package:flutter/services.dart';
import '../models/aws_ivs_create_participant_token.dart';
import 'package:flutter_aws_ivs/src/services/aws_ivs_service.dart';

const onErrorMethodName = "onError";
const onConnectionStateChangedMethodName = "onConnectionStateChanged";
const onLocalAudioStateChangedMethodName = "onLocalAudioStateChanged";
const onLocalVideoStateChangedMethodName = "onLocalVideoStateChanged";
const onBroadcastStateChangedMethodName = "onBroadcastStateChanged";

class FlutterAwsIvsController {
  late MethodChannel _channel;
  FlutterAwsIvsControllerListener? _listener;
  AwsIvsCreateParticipantToken? awsIvsCreateParticipantToken;

  setListener(FlutterAwsIvsControllerListener listener) {
    _listener = listener;
  }

  FlutterAwsIvsController.init(int id) {
    _channel = MethodChannel('flutter_aws_ivs_$id');
    _channel.setMethodCallHandler(handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall methodCall) async {
    // print(methodCall.method);
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

  Future<void> joinStage(String participantToken) async {
    if (participantToken != null) {
      return _channel.invokeMethod('joinStage', participantToken);
    }
  }

  Future<void> leaveStage() async {
    return _channel.invokeMethod('leaveStage');
  }

  Future<void> initView() async {
    return _channel.invokeMethod('initView');
  }

  Future<bool?> toggleLocalAudioMute() async {
    return _channel.invokeMethod<bool>('toggleLocalAudioMute');
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
