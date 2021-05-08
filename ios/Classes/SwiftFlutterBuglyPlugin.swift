import Flutter
import UIKit
import Bugly

enum CustomBuglyError: Error {
    case normal(_ content : String)
}

public class SwiftFlutterBuglyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_bugly", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterBuglyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "initBugly"{ // Optional
        let key = call.arguments as! String
        initBugly(key)
    }else if call.method == "bugReport"{
        let errorMsg = call.arguments as! String
        bugReport(errorMsg)
    }else if call.method == "putUserData"{
        let mapData = call.arguments as! Dictionary<String, String>
        print(mapData["flutter error"]!)
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
    
    private func initBugly(_ key: String){
        Bugly.start(withAppId: key)
    }
    
    private func bugReport(_ errorMsg: String){
        Bugly.reportError(CustomBuglyError.normal(errorMsg))
    }
}
