package com.sadik.miigaik

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.util.Log
import android.view.View
import android.widget.RemoteViews
import androidx.work.WorkManager
import es.antonborri.home_widget.HomeWidgetPlugin
import org.json.JSONArray
import org.json.JSONObject
import androidx.core.content.edit
import androidx.core.net.toUri
import es.antonborri.home_widget.HomeWidgetBackgroundIntent

class ScheduleAppWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        Log.e("WIDGET", "onUpdate")
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onDeleted(context: Context, appWidgetIds: IntArray) {
        Log.e("WIDGET", "onDeleted for widgets: ${appWidgetIds.joinToString()}")

        val prefs: SharedPreferences = HomeWidgetPlugin.getData(context)
        prefs.edit {
            for (appWidgetId in appWidgetIds) {
                removeWidgetData(this, appWidgetId)
            }
        }
        Log.e("WIDGET", "Widget data cleaned up successfully")
    }

    override fun onEnabled(context: Context) {
        Log.e("WIDGET", "onEnabled")
    }

    override fun onDisabled(context: Context) {
        Log.e("WIDGET", "onDisabled")
    }

    private fun removeWidgetData(editor: SharedPreferences.Editor, appWidgetId: Int) {
        val keysToRemove = listOf(
            "${appWidgetId}_signature",
            "${appWidgetId}_lessons",
            "${appWidgetId}_lessons_empty",
            "${appWidgetId}_date",
            "${appWidgetId}_display_date",
            "${appWidgetId}_schedule_state"
        )

        keysToRemove.forEach { key ->
            editor.remove(key)
            Log.d("WIDGET", "Removed key: $key")
        }
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    Log.e("WIDGET", "updateAppWidget $appWidgetId")
    val views = RemoteViews(context.packageName, R.layout.schedule_app_widget)
    try {
        val prefs: SharedPreferences = HomeWidgetPlugin.getData(context)

        val signatureString = prefs.getString("${appWidgetId}_signature", "") ?: ""
        Log.e("WIDGET", "signatureString=$signatureString")
        val signatureJsonObj = JSONObject(signatureString)
        val signature = signatureJsonObj.toMap()

        val locale = prefs.getString("locale", "ru_RU") ?: "ru_RU"

        val date = prefs.getString("${appWidgetId}_display_date", "")
        Log.e("WIDGET", "display_date=$date")
        views.setTextViewText(R.id.date_text, date)

        views.setTextViewText(R.id.schedule_name, signature["title"]?.toString() ?: "")

        views.setOnClickPendingIntent(
            R.id.refresh,
            HomeWidgetBackgroundIntent.getBroadcast(
                context, "miigaik://schedule?action=refresh&id=$appWidgetId&locale=$locale".toUri()
            )
        )

        val isEmptyLessons = prefs.getBoolean("${appWidgetId}_lessons_empty", false)
        if (isEmptyLessons){
            showEmptyLessons(views)
        }else{
            hideMessage(views)
        }

        val intent = Intent(context, ScheduleWidgetService::class.java).apply {
            putExtra("appWidgetId", appWidgetId)
        }
        views.setRemoteAdapter(R.id.schedule_list, intent)

        setupWidgetClickIntent(context, views, appWidgetId)

        appWidgetManager.updateAppWidget(appWidgetId, views)
        appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetId, R.id.schedule_list)
    } catch (e: Exception){
        showErrorMessage(views)
        Log.e("WIDGET", e.message.toString())
        Log.d("WIDGET", Log.getStackTraceString(e))
        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}

private fun setupWidgetClickIntent(context: Context, views: RemoteViews, appWidgetId: Int) {
    val packageName = context.packageName
    val intent = context.packageManager.getLaunchIntentForPackage(packageName)
    intent?.apply {
        flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        putExtra("FROM_WIDGET", true)
        putExtra("WIDGET_ID", appWidgetId)
    }

    val pendingIntent = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S) {
        PendingIntent.getActivity(
            context,
            appWidgetId,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
        )
    } else {
        PendingIntent.getActivity(
            context,
            appWidgetId,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT
        )
    }

    views.setOnClickPendingIntent(R.id.root, pendingIntent)
}

internal fun showErrorMessage(views: RemoteViews){
    showMessage(views, "Что-то пошло не так", "Попробуйте пересоздать виджет")
}

internal fun showEmptyLessons(views: RemoteViews){
    showMessage(views, "Выходной", "Занятий на сегодня нет")
}

internal fun showMessage(views: RemoteViews, title: String, subTitle: String) {
    views.setViewVisibility(R.id.message_container, View.VISIBLE)
    views.setViewVisibility(R.id.schedule_list, View.GONE)
    views.setTextViewText(R.id.title_message, title)
    views.setTextViewText(R.id.subtitle_message, subTitle)
}

internal fun hideMessage(views: RemoteViews){
    views.setViewVisibility(R.id.message_container, View.GONE)
    views.setViewVisibility(R.id.schedule_list, View.VISIBLE)
    views.setTextViewText(R.id.title_message, "")
    views.setTextViewText(R.id.subtitle_message, "")
}

fun String?.jsonToListOfMaps(): List<Map<String, Any?>> {
    if (this.isNullOrEmpty()) return emptyList()

    return try {
        val jsonArray = JSONArray(this)
        val result = mutableListOf<Map<String, Any?>>()

        for (i in 0 until jsonArray.length()) {
            val jsonObject = jsonArray.getJSONObject(i)
            val map = mutableMapOf<String, Any?>()

            val keys = jsonObject.keys()
            while (keys.hasNext()) {
                val key = keys.next()
                val value = jsonObject.get(key)
                map[key] = when (value) {
                    is JSONObject -> value.toMap()
                    is JSONArray -> value.toList()
                    else -> value
                }
            }
            result.add(map)
        }
        result
    } catch (e: Exception) {
        Log.e("WIDGET", "Error parsing JSON to List<Map>: $e")
        emptyList()
    }
}

fun JSONObject.toMap(): Map<String, Any?> {
    val map = mutableMapOf<String, Any?>()
    val keys = this.keys()
    while (keys.hasNext()) {
        val key = keys.next()
        val value = this.get(key)
        map[key] = when (value) {
            is JSONObject -> value.toMap()
            is JSONArray -> value.toList()
            else -> value
        }
    }
    return map
}

fun JSONArray.toList(): List<Any?> {
    val list = mutableListOf<Any?>()
    for (i in 0 until this.length()) {
        val value = this.get(i)
        list.add(when (value) {
            is JSONObject -> value.toMap()
            is JSONArray -> value.toList()
            else -> value
        })
    }
    return list
}