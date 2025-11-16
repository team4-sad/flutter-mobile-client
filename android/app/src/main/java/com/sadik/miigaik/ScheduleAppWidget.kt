package com.sadik.miigaik

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.util.Log
import android.widget.RemoteViews
import androidx.core.net.toUri
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetPlugin

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

    val group = prefs.getString("${appWidgetId}_group", "Ошибка")

    views.setTextViewText(R.id.group_name, group)
    views.setOnClickPendingIntent(R.id.refresh,
        HomeWidgetBackgroundIntent.getBroadcast(
            context, "miigaik://schedule?action=refresh&id=${appWidgetId}".toUri()
        )
    )

    appWidgetManager.updateAppWidget(appWidgetId, views)

//    val intent = HomeWidgetBackgroundIntent.getBroadcast(
//        context, "miigaik://schedule?action=test&id=${appWidgetId}".toUri()
//    )
//
//    runBlocking {
//        Log.e("WIDGET", "start delay")
//        delay(5000)
//        Log.e("WIDGET", "end delay")
//        Log.e("WIDGET", "SEND TEST")
//        try {
//            intent.send()
//            Log.e("WIDGET", "SENDED TEST")
//        } catch (e: PendingIntent.CanceledException){
//            Log.e("WIDGET", "ERROR - ${e.message} - ${e.cause}")
//        }
//    }
}

