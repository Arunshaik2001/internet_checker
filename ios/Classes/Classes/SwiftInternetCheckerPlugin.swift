import Flutter
import UIKit


public class SwiftInternetCheckerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "internet_checker", binaryMessenger: registrar.messenger())
    let instance = SwiftInternetCheckerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "getPlatformVersion") {
       result("iOS " + UIDevice.current.systemVersion)
    }
    else if (call.method == "addNetworkStateListener") {
        ConnectionManager.sharedInstance.observeReachability()
    }
  }
}

class ConnectionManager {

static let sharedInstance = ConnectionManager()
private var reachability : Reachability!

func observeReachability(){
    do{
    self.reachability = try Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
    do {
        try self.reachability.startNotifier()
    }
    catch(let error) {
        print("Error occured while starting reachability notifications : \(error.localizedDescription)")
    }
    }
    catch(let error) {
        print("Error occured while starting reachability  : \(error.localizedDescription)")
    }
}

@objc func reachabilityChanged(note: Notification) {
    let reachability = note.object as! Reachability
    switch reachability.connection {
    case .cellular:
        createDialog(message: "Network available via Cellular Data.")
        break
    case .wifi:
        createDialog(message: "Network available via WiFi.")
        break
    case .unavailable:
        createDialog(message: "Network is not available.")
        break
    }
  }
    
    func createDialog(message: String){
        DispatchQueue.main.async {
           let alert = UIAlertController(title: "Network Change", message: message, preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
           UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil);
        }
    }
}
