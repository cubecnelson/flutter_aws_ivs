import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../callbacks/flutter_aws_ivs_view_created_callback.dart';
import '../controllers/flutter_aws_ivs_controller.dart';

class FlutterAwsIvsView extends StatefulWidget {
  const FlutterAwsIvsView({super.key, this.onAwsIvsCreated});

  final FlutterAwsIvsViewCreatedCallback? onAwsIvsCreated;

  @override
  State<FlutterAwsIvsView> createState() => _AwsIvsViewState();
}

class _AwsIvsViewState extends State<FlutterAwsIvsView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'flutter_aws_ivs',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'flutter_aws_ivs',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Container();
  }

  Future<void> onPlatformViewCreated(id) async {
    if (widget.onAwsIvsCreated == null) {
      return;
    }
    widget.onAwsIvsCreated?.call(FlutterAwsIvsController.init(id));
  }
}
