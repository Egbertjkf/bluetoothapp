import UIKit
import Flutter
import CoreBluetooth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    
    private func receiveBluetoothInfo(result: FlutterResult){
        func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            result("true")
            break
        case .poweredOff:
            result("false")
            break
        case .resetting:
            result("false")
            break
        case .unauthorized:
            result("false")
            break
        case .unsupported:
           result("false")
            break
        case .unknown:
            result("false")
            break
        default:
            result("false")
            break
        }}
    }
    
   

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  
    let METHOD_CHANNEL_NAME = "com.example.bluetooth/method"
    let viewController = UIViewController()

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let methodChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
    let central = CBCentralManager()
    let alert = UIAlertAction()
        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if (call.method == "isBluetoothActive"){
                switch central.state {
            case .poweredOn:
                result("true")
                break
            case .poweredOff:
                result("false")
                break
            case .resetting:
                result("false")
                break
            case .unauthorized:
                result("false")
                break
            case .unsupported:
               result("false")
                break
            case .unknown:
                result("false")
                break
            default:
                result("false")
                break
                }}
            
            if(call.method == "ativaBluetooth"){
                
                        if #available(iOS 10.0, *) {
                            if let url2 = URL.init(string: UIApplication.openSettingsURLString){
                                UIApplication.shared.open(url2, options: [:], completionHandler: nil)}}
                    
                     /*      let alert = UIAlertController(title: "Settings",
                                                          message: "Please modify your settings",
                                                          preferredStyle: .alert)

                            alert.addAction(UIAlertAction(title: "Open Settings",
                                                          style: UIAlertAction.Style.default,
                                                          handler: nil))
                            alert.addAction(UIAlertAction(title: "Cancel",
                                                          style: UIAlertAction.Style.default,
                                                          handler: nil))

                            viewController.present(alert, animated: true, completion: nil)*/
                    
                }
    
            
        })
    
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
