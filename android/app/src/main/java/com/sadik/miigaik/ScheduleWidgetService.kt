package com.sadik.miigaik

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.util.Log
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import es.antonborri.home_widget.HomeWidgetPlugin

class ScheduleWidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        val appWidgetId = intent.getIntExtra("appWidgetId", 0)
        Log.e("WIDGET_SERVICE", "Creating factory for widget: $appWidgetId")
        return ScheduleRemoteViewsFactory(this.applicationContext, appWidgetId)
    }
}

class ScheduleRemoteViewsFactory(
    private val context: Context,
    private val appWidgetId: Int // Передаем в конструктор
) : RemoteViewsService.RemoteViewsFactory {

    private lateinit var prefs: SharedPreferences
    private val lessons = mutableListOf<LessonItem>()

    override fun onCreate() {
        prefs = HomeWidgetPlugin.getData(context)
        Log.e("WIDGET_FACTORY", "Factory created for widget: $appWidgetId")
    }

    override fun onDataSetChanged() {
        lessons.clear()
        Log.e("WIDGET_FACTORY", "onDataSetChanged for widget: $appWidgetId")

        val stringLessons = prefs.getString("${appWidgetId}_lessons", "") ?: ""
        Log.e("WIDGET_FACTORY", "Data for widget $appWidgetId: ${stringLessons.take(50)}...")

        if (stringLessons.isEmpty()) {
            Log.e("WIDGET_FACTORY", "No lessons data for widget: $appWidgetId")
            return
        }

        try {
            val data = stringLessons.jsonToListOfMaps()
            Log.e("WIDGET_FACTORY", "Parsed ${data.size} lessons for widget: $appWidgetId")

            for (lesson in data) {
                val lessonTitle = lesson["discipline_name"] as? String ?: ""
                val startTime = lesson["lesson_start_time"] as? String ?: ""
                val endTime = lesson["lesson_end_time"] as? String ?: ""
                val number = (lesson["lesson_order_number"] as? Int) ?: 0

                if (lessonTitle.isNotEmpty()) {
                    lessons.add(LessonItem(
                        number,
                        "${removeSeconds(startTime)}-${removeSeconds(endTime)}",
                        lessonTitle
                    ))
                }
            }
        } catch (e: Exception) {
            Log.e("WIDGET_FACTORY", "Error parsing lessons for widget $appWidgetId: ${e.message}")
        }

        Log.e("WIDGET_FACTORY", "Loaded ${lessons.size} lessons for widget: $appWidgetId")
    }

    private fun removeSeconds(time: String): String {
        return time.split(":").subList(0, 2).joinToString(":")
    }

    override fun onDestroy() {
        lessons.clear()
        Log.e("WIDGET_FACTORY", "Factory destroyed for widget: $appWidgetId")
    }

    override fun getCount(): Int {
        Log.e("WIDGET_FACTORY", "getCount for widget $appWidgetId: ${lessons.size}")
        return lessons.size
    }

    override fun getViewAt(position: Int): RemoteViews {
        Log.e("WIDGET_FACTORY", "getViewAt position $position for widget $appWidgetId")

        val remoteViews = RemoteViews(context.packageName, R.layout.lesson_item)

        if (position < lessons.size) {
            val lesson = lessons[position]
            remoteViews.setTextViewText(R.id.numberText, lesson.number.toString())
            remoteViews.setTextViewText(R.id.timeText, lesson.time)
            remoteViews.setTextViewText(R.id.subjectText, lesson.subject)
            Log.e("WIDGET_FACTORY", "Created view for: ${lesson.subject}")
        } else {
            Log.e("WIDGET_FACTORY", "Position $position out of bounds for widget $appWidgetId")
        }

        return remoteViews
    }

    override fun getLoadingView(): RemoteViews? = null

    override fun getViewTypeCount(): Int = 1

    override fun getItemId(position: Int): Long {
        return (appWidgetId * 1000 + position).toLong()
    }

    override fun hasStableIds(): Boolean = true
}

data class LessonItem(
    val number: Int,
    val time: String,
    val subject: String
)