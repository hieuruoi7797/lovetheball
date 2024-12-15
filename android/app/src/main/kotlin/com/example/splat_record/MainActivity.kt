package com.splat.splat_mobile
import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull
import android.os.Handler
import android.os.Looper
import android.util.Log
import androidx.core.app.ActivityCompat
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

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(
                    this,
                    arrayOf(
                        Manifest.permission.BLUETOOTH_CONNECT,
                        Manifest.permission.FOREGROUND_SERVICE_CONNECTED_DEVICE
                    ),
                    1001
                )
            }
        }
        // Create the MethodChannel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
            if (call.method == "startBackgroundTask") {
                val map = call.arguments as? Map<*, *>
                val intent = Intent(this, SocketManager::class.java)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    intent.putExtra("serverUrl", "https://ample-crawdad-kind.ngrok-free.app")
                    intent.putExtra("path", "/socket")
                    intent.putExtra("namespace", "/notifications")
                    intent.putExtra("id", map!!["id"] as? String)
                    intent.putExtra("username", map["name"] as? String)
                    startForegroundService(intent)
                }
                result.success("Background task started")
            } else {
                result.notImplemented()
            }
        }
    }


}
