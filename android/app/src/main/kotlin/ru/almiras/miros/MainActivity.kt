package uz.ung.docflow

import android.content.pm.PackageManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity(), StreamHandler {
    companion object {
        var flutterEngineInstance: FlutterEngine? = null
    }

    private var eventSink: EventSink? = null;

    private fun startEventChannel(messenger: BinaryMessenger) {
        EventChannel(messenger, "window_focus_channel").setStreamHandler(this)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngineInstance?.dartExecutor?.let {
            MethodChannel(it.binaryMessenger, "user_agent")
                .setMethodCallHandler { call, result ->
                    run {
                        if (call.method.equals("get")) {
                            result.success(System.getProperty("http.agent"))
                        } else {
                            result.notImplemented();
                        }
                    }
                }

            MethodChannel(
                it.binaryMessenger,
                "eimzo_installed"
            ).setMethodCallHandler { call, result ->
                run {
                    if (call.method.equals("get")) {
                        try {
                            context.packageManager.getPackageInfo("uz.yt.idcard.eimzo", 0)
                            result.success(true)
                        } catch (e: PackageManager.NameNotFoundException) {
                            result.success(false)
                        }

                    } else {
                        result.notImplemented()
                    }
                }
            }
        }
    }

    override fun onDestroy() {
        val thread = Thread {
            val shp = activity.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
            val rememberMe = shp.getBoolean("flutter.rememberMe", false);

            if (!rememberMe) {
                shp.edit().clear().apply()
            }
        }

        thread.start();

        super.onDestroy()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngineInstance = flutterEngine;
        startEventChannel(flutterEngine.dartExecutor.binaryMessenger);
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)

        eventSink?.success(hasFocus);
    }

    override fun onListen(arguments: Any?, events: EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}

