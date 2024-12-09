package com.splat.splat_mobile
import android.content.Intent
import android.os.Build
import androidx.annotation.NonNull
import android.os.Handler
import android.os.Looper
import android.util.Log
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import managers.SocketManager
import org.json.JSONObject
import kotlinx.coroutines.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.splat/background"
//    val socketManager = SocketManager()


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Ensure BinaryMessenger is non-null
        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger

        // Create the MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
            if (call.method == "startBackgroundTask") {
                val intent = Intent(this, SocketManager::class.java)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    intent.putExtra("serverUrl", "https://ample-crawdad-kind.ngrok-free.app")
                    intent.putExtra("path", "/socket")
                    intent.putExtra("namespace", "/notifications")
                    startForegroundService(intent)
                }
                result.success("Background task started")
            } else {
                result.notImplemented()
            }
        }
    }


}
