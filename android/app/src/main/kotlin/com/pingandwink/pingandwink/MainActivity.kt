package com.pingandwink.pingandwink

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import androidx.work.*
import java.util.concurrent.TimeUnit
import android.os.Bundle
import android.util.Log

class MainActivity: FlutterActivity() {
    
    companion object {
        private const val TAG = "MainActivity"
        private const val WORK_NAME = "push_token_refresh"
    }
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d(TAG, "🚀 MainActivity onCreate - Setting up WorkManager")
        setupWorkManager()
    }
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.d(TAG, "✅ Flutter Engine configured")
    }
    
    private fun setupWorkManager() {
        try {
            // Network constraint - only run when connected
            val constraints = Constraints.Builder()
                .setRequiredNetworkType(NetworkType.CONNECTED)
                .build()
            
            // Periodic work request - every hour
            val periodicWorkRequest = PeriodicWorkRequestBuilder<PushTokenRefreshWorker>(
                1, TimeUnit.HOURS,  // Repeat interval
                15, TimeUnit.MINUTES // Flex period
            )
                .setConstraints(constraints)
                .setBackoffCriteria(
                    BackoffPolicy.LINEAR,
                    15, // Изменено: используем числовое значение вместо MIN_BACKOFF_MILLIS
                    TimeUnit.MINUTES
                )
                .addTag("onesignal_refresh")
                .build()
            
            // Enqueue unique work - KEEP means don't replace if already exists
            WorkManager.getInstance(this).enqueueUniquePeriodicWork(
                WORK_NAME,
                ExistingPeriodicWorkPolicy.KEEP,
                periodicWorkRequest
            )
            
            Log.d(TAG, "✅ WorkManager scheduled - every hour")
            
            // Also schedule immediate one-time work for testing
            val oneTimeWorkRequest = OneTimeWorkRequestBuilder<PushTokenRefreshWorker>()
                .setInitialDelay(30, TimeUnit.SECONDS)
                .addTag("onesignal_refresh_immediate")
                .build()
                
            WorkManager.getInstance(this).enqueue(oneTimeWorkRequest)
            Log.d(TAG, "✅ Immediate work scheduled - in 30 seconds")
            
        } catch (e: Exception) {
            Log.e(TAG, "❌ Failed to setup WorkManager", e)
        }
    }
}