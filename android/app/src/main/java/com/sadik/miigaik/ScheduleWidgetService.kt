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

        val stringLessons = prefs.getString("${appWidgetId}_lessons", "") ?: ""
        val data = stringLessons.jsonToListOfMaps()

        for (lesson in data) {
            val lessonTitle = lesson["disciplineName"] as String
            val startTime = lesson["lessonStartTime"] as String
            val endTime = lesson["lessonEndTime"] as String
            val number = lesson["lessonOrderNumber"] as Int

            lessons.add(LessonItem(
                number,
                "${removeSeconds(startTime)}-${removeSeconds(endTime)}",
                lessonTitle
            ))
        }
    }

    private fun removeSeconds(time: String): String {
        return time.split(":").subList(0, 2).joinToString(":")
    }

    override fun onDestroy() {
        lessons.clear()
    }

    override fun getCount(): Int = lessons.size

    override fun getViewAt(position: Int): RemoteViews {
        val remoteViews = RemoteViews(context.packageName, R.layout.lesson_item)
        val lesson = lessons[position]

        remoteViews.setTextViewText(R.id.numberText, lesson.number.toString())
        remoteViews.setTextViewText(R.id.timeText, lesson.time)
        remoteViews.setTextViewText(R.id.subjectText, lesson.subject)

        return remoteViews
    }

    override fun getLoadingView(): RemoteViews? = null

    override fun getViewTypeCount(): Int = 1

    override fun getItemId(position: Int): Long = position.toLong()

    override fun hasStableIds(): Boolean = true
}

data class LessonItem(
    val number: Int,
    val time: String,
    val subject: String
)