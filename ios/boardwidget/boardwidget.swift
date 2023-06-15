import WidgetKit
import SwiftUI
import Intents

extension Color {
    static let black = Color("black")
    static let grey = Color("grey")
    static let navy = Color("navy")
    
    static let white = Color("white")
    static let light_grey = Color("light_grey")
    static let yellow = Color("yellow")
}

struct WidgetSettings: Decodable, Hashable {
    let isTextChangeHourly: Bool
    let isTextChangeHour: Int
    let fontColor: String
    let backgroundColor: String
    let fontFamily: String
    let fontSize: Double
    
    func getFontColor() -> Color {
            return getColor(from: fontColor)
        }
    
    func getBackgroundColor() -> Color {
            return getColor(from: backgroundColor)
        }
        
    private func getColor(from value: String?) -> Color {
        guard let colorString = value?.lowercased() else {
            return Color.white
        }
            
            switch colorString {
            case "black":
                return .black
            case "grey":
                return .grey
            case "navy":
                return .navy
                
            case "white":
                return .white
            case "light_grey":
                return .light_grey
            case "yellow":
                return .yellow
            default:
                return Color.black
            }
        }

}

struct WidgetData: Decodable, Hashable {
    let text: String
    
}

struct FlutterEntry: TimelineEntry {
    let date: Date
    let WidgetSettings: WidgetSettings?
    let widgetData: WidgetData?
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> FlutterEntry {
        FlutterEntry(date: Date(), WidgetSettings: WidgetSettings( isTextChangeHourly: false, isTextChangeHour: 6, fontColor: "", backgroundColor: "", fontFamily: "", fontSize: 24.0), widgetData: WidgetData(text: "IOS테스트입니당"))
    }

    func getSnapshot(in context: Context, completion: @escaping (FlutterEntry) -> ()) {
        let entry = FlutterEntry(date: Date(), WidgetSettings: WidgetSettings( isTextChangeHourly: false, isTextChangeHour: 6, fontColor: "", backgroundColor: "", fontFamily: "", fontSize: 24.0), widgetData: WidgetData(text: "IOS테스트입니당"))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let shareDefaults = UserDefaults.init(suiteName: "group.boardwidget")
        let flutterSettings = try? JSONDecoder().decode(WidgetSettings.self, from: (shareDefaults?.string(forKey: "WidgetSettings")?.data(using: .utf8)) ?? Data())
        let flutterData = try? JSONDecoder().decode(WidgetData.self, from: (shareDefaults?.string(forKey: "WidgetData")?.data(using: .utf8)) ?? Data())

        let entryDate = Calendar.current.date(byAdding: .hour, value: 24, to: Date())!
        let entry = FlutterEntry(date: entryDate, WidgetSettings: flutterSettings, widgetData: flutterData)

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
        let backgroundColor = entry.WidgetSettings?.getBackgroundColor() ?? Color.black
        let fontColor = entry.WidgetSettings?.getFontColor() ?? Color.white

        ZStack {
            ContainerRelativeShape().fill(backgroundColor)

            Text(entry.widgetData?.text ?? "탭해서 텍스트를 설정하세요!")
                .font(Font.custom(entry.WidgetSettings?.fontFamily ?? "KyoboHandwriting2019", size: CGFloat(entry.WidgetSettings?.fontSize ?? 24.0)))
                .foregroundColor(fontColor)

            VStack {
                Spacer()

                HStack {
                    Spacer()
//                    Text("우측하단")
//                        .font(Font.custom(entry.WidgetSettings?.fontFamily ?? "KyoboHandwriting2019", size: CGFloat(entry.WidgetSettings?.fontSize ?? 24.0)))
//                        .foregroundColor(fontColor)
//                        .padding(14)
                }
            }
        }
    }
}
