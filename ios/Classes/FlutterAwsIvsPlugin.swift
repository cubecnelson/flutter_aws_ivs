import Flutter
import UIKit

public class FlutterAwsIvsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // let channel = FlutterMethodChannel(name: "flutter_aws_ivs", binaryMessenger: registrar.messenger())
    // let instance = FlutterAwsIvsPlugin()
    // registrar.addMethodCallDelegate(instance, channel: channel)


    let factory = FlutterAwsIvsFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "flutter_aws_ivs")
  }

  // public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  //   switch call.method {
  //   case "getPlatformVersion":
  //     result("iOS " + UIDevice.current.systemVersion)
  //   default:
  //     result(FlutterMethodNotImplemented)
  //   }
  // }
}
