import Flutter
import UIKit
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // This is required for flutter_local_notifications
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    // Register Flutter plugins with error handling
    do {
      GeneratedPluginRegistrant.register(with: self)
    } catch {
      print("Error registering plugins: \(error)")
    }
    
    // Call super
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}