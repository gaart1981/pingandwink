# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.plugins.** { *; }

# OneSignal - критично для пушей
-keep class com.onesignal.** { *; }
-dontwarn com.onesignal.**
-keep class com.onesignal.notifications.** { *; }
-keep class com.onesignal.common.** { *; }

# Google Play Core (решает ваши ошибки)
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**
-keep class com.google.android.play.core.** { *; }

# Firebase/FCM для пушей
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Android система уведомлений
-keep class * extends android.app.Service
-keep class * extends android.content.BroadcastReceiver
-keep class * extends android.app.Activity

# Supabase
-dontwarn io.supabase.**
-keep class io.supabase.** { *; }

# Mapbox
-dontwarn com.mapbox.**
-keep class com.mapbox.** { *; }

# Kotlin
-dontwarn kotlin.**
-dontwarn kotlinx.**

# OkHttp (используется многими библиотеками)
-dontwarn okhttp3.**
-dontwarn okio.**

# Общие правила для стабильности
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception