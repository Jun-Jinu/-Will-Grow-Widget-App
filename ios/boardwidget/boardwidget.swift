//
//  boardwidget.swift
//  boardwidget
//
//  Created by 전진우 on 2023/06/03.
//

import WidgetKit
import SwiftUI
import Intents

struct WidgetData: Decodable, Hashable {
    let text: String
}

struct FlutterEntry: TimelineEntry {
    let date: Date
    let widgetData: WidgetData? 
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FlutterEntry {
        FlutterEntry(date: Date(), widgetData: WidgetData(text:"Flutter IOS widget입니다."))
    }

    func getSnapshot(in context: Context, completion: @escaping (FlutterEntry) -> ()) {
        let entry = FlutterEntry(date: Date(), widgetData: WidgetData(text: "Flutter IOS widget입니다."))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let shareDefaults = UserDefaults.init(suiteName: "group.boardwidget")
        let flutterData = try? JSONDecoder().decode(WidgetData.self, from: (shareDefaults?.string(forKey: "widgetData")?.data(using: .utf8)) ?? Data())

        let entryDate = Calendar.current.date(byAdding: .hour, value: 24, to: Date())!
        let entry = FlutterEntry(date: entryDate, widgetData: flutterData)

        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct boardwidget: Widget {
    let kind: String = "boardwidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in iosWidgetView(entry: entry)
        }
    }
}

struct iosWidgetView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
        ContainerRelativeShape().fill(.gray.gradient)
    

        // TODO: 텍스트 폰트 변경, 배경 색 설정 추가
        Text(entry.widgetData?.text ?? "탭해서 텍스트를 설정하세요!")
            .font(.system(size: 24, weight: .heavy))
            .foregroundColor(.white.opacity(0.8))
        
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Text("우측하단")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(14) // 필요에 따라 여백을 조정하세요.
                }
            }
        }
    }
}
