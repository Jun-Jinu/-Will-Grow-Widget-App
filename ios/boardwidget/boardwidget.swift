import WidgetKit
import SwiftUI
import Intents

struct WidgetData: Decodable, Hashable {
    let text: String
    let isTextChangeHourly: String
    let isTextChangeHour: String
    let fontColor: String
    let backgroundColor: String
    let fontFamily: String
    let fontSize: Double
}

struct FlutterEntry: TimelineEntry {
    let date: Date
    let widgetData: WidgetData?
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FlutterEntry {
        FlutterEntry(date: Date(), widgetData: WidgetData(text: "Flutter IOS widget입니다.", isTextChangeHourly: "", isTextChangeHour: "", fontColor: "", backgroundColor: "", fontFamily: "", fontSize: 0.0))
    }

    func getSnapshot(in context: Context, completion: @escaping (FlutterEntry) -> ()) {
        let entry = FlutterEntry(date: Date(), widgetData: WidgetData(text: "Flutter IOS widget입니다.", isTextChangeHourly: "", isTextChangeHour: "", fontColor: "", backgroundColor: "", fontFamily: "", fontSize: 0.0))
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
        let backgroundColor = Color(entry.widgetData?.backgroundColor ?? "")
        let fontColor = Color(entry.widgetData?.fontColor ?? "")

        ZStack {
            ContainerRelativeShape().fill(backgroundColor)

            Text(entry.widgetData?.text ?? "탭해서 텍스트를 설정하세요!")
                .font(Font.custom(entry.widgetData?.fontFamily ?? "KyoboHandwriting2019", size: CGFloat(entry.widgetData?.fontSize ?? 24.0)))
                .foregroundColor(fontColor)

            VStack {
                Spacer()

                HStack {
                    Spacer()
                    Text("우측하단")
                        .font(Font.custom(entry.widgetData?.fontFamily ?? "KyoboHandwriting2019", size: CGFloat(entry.widgetData?.fontSize ?? 24.0)))
                        .foregroundColor(fontColor)
                        .padding(14)
                }
            }
        }
    }
}
