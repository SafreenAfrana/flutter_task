import UIKit
import Flutter
import CoreBluetooth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "bluetooth_channel"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: CHANNEL,
            binaryMessenger: flutterViewController.binaryMessenger
        )
        
        channel.setMethodCallHandler { [weak self] (call, result) in
            switch call.method {
            case "enableBluetooth":
                self?.enableBluetooth(result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func enableBluetooth(result: @escaping FlutterResult) {
        let centralManager = CBCentralManager(delegate: nil, queue: nil)
        if centralManager.state == .poweredOn {
            result(true) // Bluetooth is already enabled
        } else {
            // Create a UIAlertController to display a dialog
            let alertController = UIAlertController(
                title: "Enable Bluetooth",
                message: "Please enable Bluetooth in Settings",
                preferredStyle: .alert
            )
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                // Open the Bluetooth settings when the user taps OK
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }
                result(true)
            })
            
            // Present the UIAlertController on the current view controller
            let rootViewController = self.window?.rootViewController
            rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
