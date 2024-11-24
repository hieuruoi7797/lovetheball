import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var backgroundTask: UIBackgroundTaskIdentifier = .invalid

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
    GeneratedPluginRegistrant.register(with: self)
      
      // Setup the method channel
             let controller = window?.rootViewController as! FlutterViewController
             let channel = FlutterMethodChannel(name: "com.splat/background", binaryMessenger: controller.binaryMessenger)
             
             channel.setMethodCallHandler { [weak self] (call, result) in
                 if call.method == "startBackgroundTask" {
                     self?.startBackgroundTask(channel: channel)
                     result(nil)
                 } else {
                     result(FlutterMethodNotImplemented)
                 }
             }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func startBackgroundTask(channel: FlutterMethodChannel) {
            // Begin background task
            backgroundTask = UIApplication.shared.beginBackgroundTask {
                UIApplication.shared.endBackgroundTask(self.backgroundTask)
                self.backgroundTask = .invalid
            }
            
            // Simulate a delay (e.g., 5 seconds)
            DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {
                // Invoke the Flutter method to show a notification
                channel.invokeMethod("showNotification", arguments: nil)
                
                // End the background task
                UIApplication.shared.endBackgroundTask(self.backgroundTask)
                self.backgroundTask = .invalid
            }
        }
}
