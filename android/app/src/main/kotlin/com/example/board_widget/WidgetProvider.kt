package com.example.board_widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import android.graphics.Color
import android.graphics.Typeface
import android.content.res.AssetManager
import android.util.TypedValue
import androidx.core.content.res.ResourcesCompat
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeScreenWidgetProvider : HomeWidgetProvider() {
    
     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                        MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                // 메인 글자 설정
                val text = widgetData.getString("mainText", "기본값")
                setTextViewText(R.id.text_promise, text)

                // 위젯 설정
                val fontColor = widgetData.getString("fontColor", "#333333")
                setInt(R.id.text_promise, "setTextColor", Color.parseColor(fontColor))

                val backgroundColor = widgetData.getString("backgroundColor", "#ffffff")
                setInt(R.id.widget_root, "setBackgroundColor", Color.parseColor(backgroundColor))
                
                val fontSize = widgetData.getInt("fontSize", 24)
                setTextViewTextSize(R.id.text_promise, TypedValue.COMPLEX_UNIT_SP, fontSize.toFloat())

                // val textView: TextView = findViewById(R.id.text_promise)
                // textView.typeface = Typeface.createFromAsset(assets,"naver_godic.ttf")
                
                // setInt(R.id.text_promise, "setTextViewTypeface", 0)
                // setTypeface(R.id.text_promise, 0)

                // val typeface = Typeface.createFromAsset(context.assets, "fonts/naver_godic.ttf")
                // setTextViewTypeface(R.id.text_promise, typeface)
                
                
                // val fontName = widgetData.getString("fontName", "naver_godic.ttf")
                // val typeface = Typeface.createFromAsset(context.assets, fontName)

                // setInt(R.id.text_promise, "setTypeface", 0)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}