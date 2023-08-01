import Foundation
import Flutter
import UIKit

class FlutterAwsIvsView: NSObject, FlutterPlatformView {
    private var _nativeWebView: AWSBroadcastView
    private var _methodChannel: FlutterMethodChannel
    
    func view() -> UIView {
        return _nativeWebView
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        var layout = ParticipantCollectionViewLayout()
        _nativeWebView = AWSBroadcastView.init(frame: frame, collectionViewLayout: layout)
        _methodChannel = FlutterMethodChannel(name: "flutter_aws_ivs_\(viewId)", binaryMessenger: messenger)

        super.init()
        // iOS views can be created here
        _methodChannel.setMethodCallHandler(onMethodCall)

    }


    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
        switch(call.method){
        case "initView":
            initView(call:call, result:result)
            
        case "toggleLocalVideoMute":
            toggleLocalVideoMute(call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func toggleLocalVideoMute(call: FlutterMethodCall, result: FlutterResult){
        var isVideoMuted = _nativeWebView.toggleLocalVideoMute()
        result(isVideoMuted)
    }
    
    func initView(call: FlutterMethodCall, result: FlutterResult){
        _nativeWebView.initView()
        result(true)
    }
    
}
