package com.sadik.miigaik

import android.appwidget.AppWidgetManager
import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class WidgetConfigActivity : FlutterActivity() {

    private var widgetId = AppWidgetManager.INVALID_APPWIDGET_ID
    private var methodChannel: MethodChannel? = null
    private var isConfigurationComplete = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("WIDGET_CONFIG", "onCreate started")

        widgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        Log.d("WIDGET_CONFIG", "Widget ID: $widgetId")

        if (widgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            Log.e("WIDGET_CONFIG", "Invalid widget ID")
            cancelConfiguration()
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.d("WIDGET_CONFIG", "Flutter engine configured, widgetId: $widgetId")

        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "widget_config"
        ).apply {
            setMethodCallHandler { call, result ->
                Log.d("WIDGET_CONFIG", "Method call: ${call.method}")
                when (call.method) {
                    "getWidgetId" -> {
                        Log.d("WIDGET_CONFIG", "Returning widgetId: $widgetId")
                        result.success(widgetId)
                    }
                    "finish" -> {
                        completeConfiguration()
                        result.success(null)
                    }
                    "cancel" -> {
                        cancelConfiguration()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    private fun completeConfiguration() {
        Log.d("WIDGET_CONFIG", "Completing configuration")
        isConfigurationComplete = true
        val resultValue = Intent().apply {
            putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
        }
        setResult(RESULT_OK, resultValue)
        finish()
    }

    private fun cancelConfiguration() {
        Log.d("WIDGET_CONFIG", "Canceling configuration")
        isConfigurationComplete = true
        setResult(RESULT_CANCELED)
        finish()
    }

    override fun onBackPressed() {
        Log.d("WIDGET_CONFIG", "Back button pressed")
        cancelConfiguration()
    }

    override fun onUserLeaveHint() {
        super.onUserLeaveHint()
        Log.d("WIDGET_CONFIG", "User leaving activity")
        if (!isConfigurationComplete) {
            cancelConfiguration()
        }
    }

    override fun onDestroy() {
        // Если активность уничтожается и конфигурация не завершена, отменяем
        if (!isConfigurationComplete) {
            Log.d("WIDGET_CONFIG", "Activity destroyed without completion")
            setResult(RESULT_CANCELED)
        }

        methodChannel?.setMethodCallHandler(null)
        super.onDestroy()
        Log.d("WIDGET_CONFIG", "onDestroy")
    }
}