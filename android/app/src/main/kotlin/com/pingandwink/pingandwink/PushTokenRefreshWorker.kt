package com.pingandwink.pingandwink

import android.content.Context
import androidx.work.Worker
import androidx.work.WorkerParameters
import android.util.Log
import com.onesignal.OneSignal
import com.onesignal.debug.LogLevel

class PushTokenRefreshWorker(
    context: Context,
    params: WorkerParameters
) : Worker(context, params) {
    
    companion object {
        private const val TAG = "PushTokenWorker"
        private const val PREFS_NAME = "FlutterSharedPreferences"
        private const val LAST_REFRESH_KEY = "flutter.last_onesignal_refresh"
    }
    
    override fun doWork(): Result {
        Log.d(TAG, "🔄 Starting push token refresh worker")
        
        return try {
            // Get OneSignal App ID from BuildConfig or hardcode it
            val oneSignalAppId = "18c75d05-2c09-4536-8ea3-f1c47e962862" // Your OneSignal App ID
            
            // Initialize OneSignal (always initialize, don't check)
            Log.d(TAG, "📱 Initializing OneSignal in Worker")
            OneSignal.initWithContext(applicationContext, oneSignalAppId)
            OneSignal.Debug.logLevel = LogLevel.VERBOSE
            
            // Give it a moment to initialize
            Thread.sleep(2000)
            
            // Check subscription status
            val pushSubscription = OneSignal.User.pushSubscription
            val playerId = pushSubscription.id
            val optedIn = pushSubscription.optedIn
            
            Log.d(TAG, "📊 Current status - Player ID: $playerId, Opted In: $optedIn")
            
            // Force opt-in if not subscribed
            if (playerId == null || playerId.isEmpty() || !optedIn) {
                Log.d(TAG, "⚠️ Token lost, re-subscribing...")
                pushSubscription.optIn()
                
                // Wait a bit for the subscription to complete
                Thread.sleep(3000)
                
                val newPlayerId = OneSignal.User.pushSubscription.id
                Log.d(TAG, "✅ New Player ID after re-subscription: $newPlayerId")
            } else {
                Log.d(TAG, "✅ Token is valid, no action needed")
            }
            
            // Save refresh timestamp
            val prefs = applicationContext.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            prefs.edit()
                .putString(LAST_REFRESH_KEY, System.currentTimeMillis().toString())
                .apply()
            
            Log.d(TAG, "✅ Worker completed successfully")
            Result.success()
            
        } catch (e: Exception) {
            Log.e(TAG, "❌ Worker failed: ${e.message}", e)
            Result.retry()
        }
    }
}