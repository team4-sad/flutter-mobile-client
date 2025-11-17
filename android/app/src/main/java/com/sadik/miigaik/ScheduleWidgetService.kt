package com.sadik.miigaik

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import es.antonborri.home_widget.HomeWidgetPlugin

class ScheduleWidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        val appWidgetId = intent.getIntExtra("appWidgetId", 0)
        return ScheduleRemoteViewsFactory(this.applicationContext, appWidgetId)
    }
}

class ScheduleRemoteViewsFactory(
    private val context: Context,
    private val appWidgetId: Int
) : RemoteViewsService.RemoteViewsFactory {

    private lateinit var prefs: SharedPreferences
    private val lessons = mutableListOf<LessonItem>()

    override fun onCreate() {
        prefs = HomeWidgetPlugin.getData(context)
    }

    override fun onDataSetChanged() {
        lessons.clear()

        val sizeSchedule = prefs.getInt("${appWidgetId}_schedule_size", 0)
        for (i in 0 until sizeSchedule) {
            val lessonTitle = prefs.getString("${appWidgetId}_lessons_${i}_title", "") ?: ""
            val startTime = prefs.getString("${appWidgetId}_lessons_${i}_start_time", "") ?: ""
            val endTime = prefs.getString("${appWidgetId}_lessons_${i}_end_time", "") ?: ""
            val number = prefs.getInt("${appWidgetId}_lessons_${i}_number", 0).toString()

            if (lessonTitle.isNotEmpty()) {
                lessons.add(LessonItem(number, "$startTime-$endTime", lessonTitle))
            }
        }

        // Если нет уроков, добавляем заглушку
        if (lessons.isEmpty()) {
            lessons.add(LessonItem("", "", "Нет пар на сегодня"))
        }
    }

    override fun onDestroy() {
        lessons.clear()
    }

    override fun getCount(): Int = lessons.size

    override fun getViewAt(position: Int): RemoteViews {
        val remoteViews = RemoteViews(context.packageName, R.layout.lesson_item)
        val lesson = lessons[position]

        remoteViews.setTextViewText(R.id.numberText, lesson.number)
        remoteViews.setTextViewText(R.id.timeText, lesson.time)
        remoteViews.setTextViewText(R.id.subjectText, lesson.subject)

        // Настройка внешнего вида в зависимости от содержания
        if (lesson.subject == "Нет пар на сегодня") {
            remoteViews.setTextViewText(R.id.numberText, "")
            remoteViews.setTextViewText(R.id.timeText, "")
        }

        return remoteViews
    }

    override fun getLoadingView(): RemoteViews? = null

    override fun getViewTypeCount(): Int = 1

    override fun getItemId(position: Int): Long = position.toLong()

    override fun hasStableIds(): Boolean = true
}

data class LessonItem(
    val number: String,
    val time: String,
    val subject: String
)