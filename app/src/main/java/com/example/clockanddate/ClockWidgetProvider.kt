package com.example.clockanddate

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.provider.AlarmClock
import android.widget.RemoteViews

/**
 * 4x2 clock widget. The time and date are drawn by TextClock, which the
 * launcher ticks on its own, so the app never needs to wake up every minute.
 */
class ClockWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
    ) {
        val views = RemoteViews(context.packageName, R.layout.widget_clock).apply {
            setOnClickPendingIntent(R.id.widget_root, openClockApp(context))
        }
        appWidgetManager.updateAppWidget(appWidgetIds, views)
    }

    // Tapping the widget opens the device clock app, like the stock clock widget.
    private fun openClockApp(context: Context): PendingIntent {
        val intent = Intent(AlarmClock.ACTION_SHOW_ALARMS)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        return PendingIntent.getActivity(
            context, 0, intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
    }
}
