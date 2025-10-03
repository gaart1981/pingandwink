import Flutter
import UIKit
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)
    
    // КРИТИЧЕСКИ ВАЖНО: Настройка для push notifications
    if #available(iOS 10.0, *) {
      // Для iOS 10+
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { granted, error in
          if granted {
            print("✅ Push notifications authorized")
          } else {
            print("❌ Push notifications denied")
          }
        }
      )
    } else {
      // Для iOS 9 и ниже
      let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
    
    // ОБЯЗАТЕЛЬНО: Регистрация для получения push token
    application.registerForRemoteNotifications()
    
    // Call super
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // ВАЖНО: Обработка успешной регистрации токена
  override func application(_ application: UIApplication, 
                          didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("✅ APNs token received")
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }
  
  // ВАЖНО: Обработка ошибок регистрации
  override func application(_ application: UIApplication, 
                          didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("❌ Failed to register for remote notifications: \(error.localizedDescription)")
  }
}