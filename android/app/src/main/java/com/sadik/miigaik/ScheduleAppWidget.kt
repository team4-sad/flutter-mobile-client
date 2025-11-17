package com.sadik.miigaik

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.RemoteViews
import androidx.core.net.toUri
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import java.text.SimpleDateFormat
import java.util.*

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
        Log.e("WIDGET", "onDeleted")
    }

    override fun onEnabled(context: Context) {
        Log.e("WIDGET", "onEnabled")
    }

    override fun onDisabled(context: Context) {
        Log.e("WIDGET", "onDisabled")
    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
) {
    Log.e("WIDGET", "updateAppWidget $appWidgetId")
    val views = RemoteViews(context.packageName, R.layout.schedule_app_widget)
    val prefs = HomeWidgetPlugin.getData(context)

    val title = prefs.getString("${appWidgetId}_schedule_title", "")
    views.setTextViewText(R.id.group_name, title)

    val date = prefs.getString("${appWidgetId}_schedule_date", "")
    views.setTextViewText(R.id.date_text, date)

    val intent = Intent(context, ScheduleWidgetService::class.java).apply {
        putExtra("appWidgetId", appWidgetId)
    }
    views.setRemoteAdapter(R.id.schedule_list, intent)

    appWidgetManager.updateAppWidget(appWidgetId, views)
    appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetId, R.id.schedule_list)
}

private fun getCurrentDate(): String {
    val dateFormat = SimpleDateFormat("dd.MM.yyyy EEEE", Locale("ru"))
    return dateFormat.format(Date())
}