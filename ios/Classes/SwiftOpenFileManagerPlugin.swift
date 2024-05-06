import Flutter
import UIKit

public class SwiftOpenFileManagerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "open_file_manager", binaryMessenger: registrar.messenger())
        let instance = SwiftOpenFileManagerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard call.method == "openFileManager" else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        guard let arguments = call.arguments as? [String: Any] else {
                  result(FlutterError(code: "INVALID_ARGUMENTS", message: "Arguments must be a map", details: nil))
                  return
                }
        
        let subFolderPath = arguments["subFolderPath"] as? String
        
        var path = documentsDirectory.absoluteString.replacingOccurrences(of: "file://", with: "shareddocuments://")
        path.append(subFolderPath ?? "")
        UIApplication.shared.open(URL(string: path)!)
    }
}
