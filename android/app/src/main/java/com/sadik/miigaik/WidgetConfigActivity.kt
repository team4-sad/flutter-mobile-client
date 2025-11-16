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

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("WIDGET_CONFIG", "onCreate started")

        // Получаем widgetId ДО инициализации Flutter
        widgetId = intent?.extras?.getInt(
            AppWidgetManager.EXTRA_APPWIDGET_ID,
            AppWidgetManager.INVALID_APPWIDGET_ID
        ) ?: AppWidgetManager.INVALID_APPWIDGET_ID

        Log.d("WIDGET_CONFIG", "Widget ID: $widgetId")

        if (widgetId == AppWidgetManager.INVALID_APPWIDGET_ID) {
            Log.e("WIDGET_CONFIG", "Invalid widget ID")
            setResult(RESULT_CANCELED)
            finish()
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
                    else -> result.notImplemented()
                }
            }
        }
    }

    private fun completeConfiguration() {
        Log.d("WIDGET_CONFIG", "Completing configuration")
        val resultValue = Intent().apply {
            putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
        }
        setResult(RESULT_OK, resultValue)
        finish()
    }

    override fun onDestroy() {
        methodChannel?.setMethodCallHandler(null)
        super.onDestroy()
        Log.d("WIDGET_CONFIG", "onDestroy")
    }
}