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
      
      // УДАЛЕНО: Блок с requestAuthorization
      // let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      // UNUserNotificationCenter.current().requestAuthorization(
      //   options: authOptions,
      //   completionHandler: { granted, error in
      //     if granted {
      //       print("✅ Push notifications authorized")
      //     } else {
      //       print("❌ Push notifications denied")
      //     }
      //   }
      // )
      
      // ПРИМЕЧАНИЕ: OneSignal сам запросит разрешения когда нужно
      print("✅ UNUserNotificationCenter delegate configured for iOS 10+")
      
    } else {
      // Для iOS 9 и ниже
      // УДАЛЕНО: registerUserNotificationSettings
      // let settings: UIUserNotificationSettings =
      //   UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      // application.registerUserNotificationSettings(settings)
      
      print("ℹ️ iOS 9 or lower detected, OneSignal will handle permissions")
    }
    
    // ОБЯЗАТЕЛЬНО: НЕ регистрируемся для получения push token здесь
    // УДАЛЕНО: application.registerForRemoteNotifications()
    // OneSignal вызовет это сам после получения разрешений
    
    print("ℹ️ AppDelegate configured, waiting for OneSignal initialization")
    
    // Call super
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // ВАЖНО: Обработка успешной регистрации токена
  override func application(_ application: UIApplication, 
                          didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    print("✅ APNs token received")
    // Конвертируем токен в строку для логирования (опционально)
    let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    let token = tokenParts.joined()
    print("📱 Device Token: \(token)")
    
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }
  
  // ВАЖНО: Обработка ошибок регистрации
  override func application(_ application: UIApplication, 
                          didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("❌ Failed to register for remote notifications: \(error.localizedDescription)")
    // Дополнительное логирование для отладки
    if let error = error as NSError? {
      print("   Error code: \(error.code)")
      print("   Error domain: \(error.domain)")
      print("   Error info: \(error.userInfo)")
    }
  }
  
  // ОПЦИОНАЛЬНО: Обработка входящих push-уведомлений (если нужно)
  @available(iOS 10.0, *)
  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                      willPresent notification: UNNotification,
                                      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("📬 Will present notification: \(notification.request.content.userInfo)")
    // Показываем уведомление даже когда приложение активно
    completionHandler([.alert, .badge, .sound])
  }
  
  @available(iOS 10.0, *)
  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                      didReceive response: UNNotificationResponse,
                                      withCompletionHandler completionHandler: @escaping () -> Void) {
    print("👆 Did receive notification response: \(response.notification.request.content.userInfo)")
    completionHandler()
  }
}