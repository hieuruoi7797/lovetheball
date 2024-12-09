import UIKit
import Flutter
import SocketIO

@main
@objc class AppDelegate: FlutterAppDelegate {
  var socketManager: SocketManager?
  var socket: SocketIOClient?
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
                     if let args = call.arguments as? [String: Any] {
                         // Initialize the Socket.IO connection
                         self?.setupSocketConnection(
                            id: args["id"] as? String,
                            name: args["name"] as? String
                         )
                         //                     self?.startBackgroundTask(channel: channel)
                         result(nil)
                     } else {
                         result(FlutterMethodNotImplemented)
                     }
                 }
             }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
  override func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Reconnect to socket if necessary
        if socket?.status != .connected {
            socket?.connect()
        }
        completionHandler(.newData)
    }

    
    
    private func setupSocketConnection(id: String?, name: String?) {
        let serverURL = URL(string: "https://ample-crawdad-kind.ngrok-free.app")! // Replace with your server URL
        socketManager = SocketManager(
            socketURL: serverURL,
            config: [
                .path("/socket"),
                .log(true),
                .forceWebsockets(true),
                .reconnects(true),
                ]
        )
//        socket = socketManager?.defaultSocket
        
        socket = socketManager?.socket(forNamespace: "/notifications")
    

        // Handle connection event
        socket?.on(clientEvent: .connect) { _, _ in
            print("Socket connected")
            self.emitRegisterEvent(id: id, name: name) // Emit your custom event after connection is opened
        }

        // Handle a custom event (example: "message")
        socket?.on("message") { data, ack in
            if let response = data.first as? [String: Any] {
                print("Received message: \(response)")
                // You can use FlutterMethodChannel to send this back to Flutter
            }
        }
        
        // Handle disconnect event
               socket?.on(clientEvent: .disconnect) { _, _ in
                   print("Socket disconnected")
               }
        
        // Connect to the socket
        socket?.connect()
    }
    // Emit an event after the connection is established
        func emitRegisterEvent(id: String?, name: String?) {
            let data: [String: Any] = [
                "interactor": [
                    "id_": id,
                    "name": name,
                    "interactor_type": 0
                ],
                "notification_to_be_received": [0]
            ]

            // Emit the "register" event to the server
            self.socket!.emit("register", data)
            print("Emitted 'register' event with data: \(data)")
        }
    
    func sendMessage(event: String, message: SocketData) {
            socket?.emit(event, message)
    }

    func disconnectSocket() {
            socket?.disconnect()
    }
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
            startBackgroundTask()
        }

        override func applicationWillEnterForeground(_ application: UIApplication) {
            stopBackgroundTask()
        }

        func startBackgroundTask() {
            // Request extra time for background execution
            backgroundTask = UIApplication.shared.beginBackgroundTask {
                self.endBackgroundTask()
            }
            assert(backgroundTask != .invalid)
        }

        func stopBackgroundTask() {
            // End the background task when the app comes to the foreground
            endBackgroundTask()
        }

        func endBackgroundTask() {
            if backgroundTask != .invalid {
                UIApplication.shared.endBackgroundTask(backgroundTask)
                backgroundTask = .invalid
            }
        }
    
//    func startBackgroundTask(channel: FlutterMethodChannel) {
//            // Begin background task
//            backgroundTask = UIApplication.shared.beginBackgroundTask {
//                UIApplication.shared.endBackgroundTask(self.backgroundTask)
//                self.backgroundTask = .invalid
//            }
//            
//            // Simulate a delay (e.g., 5 seconds)
//            DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {
//                // Invoke the Flutter method to show a notification
//                channel.invokeMethod("showNotification", arguments: nil)
//                
//                // End the background task
//                UIApplication.shared.endBackgroundTask(self.backgroundTask)
//                self.backgroundTask = .invalid
//            }
//        }
}
