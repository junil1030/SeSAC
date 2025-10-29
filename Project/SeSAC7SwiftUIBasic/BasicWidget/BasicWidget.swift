//
//  BasicWidget.swift
//  BasicWidget
//
//  Created by 서준일 on 10/29/25.
//

import WidgetKit
import SwiftUI

// Provider: 미리 그리고 있다가 시점에 맞춰서 살짝 미리 보여주게 하는 거임 그러면 화면에 도달했을 때에는 이미 그려진 상태일테니까
// - 홈 화면에 위젯을 보통 90번 정도 보게 됨 > 근데 홈 화면에 머무르는 시간이 짧음
// - 홈 화면에 사용자가 접근하기 전에 미리 위젯에 보여줄 뷰를 그려놓고, 시간에 맞춰서 뷰를 업데이트
// Memory 30MB Limit
// 40 ~ 70 Refresh
// viewDidLoad
// Static -> Intent
struct Provider: TimelineProvider {
    // 위젯 최초 렌더링
    // 잠금 화면에서 민감한 정보를 숨기도록
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    // 위젯 갤러리 미리보기 화면
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀😀😀😀😀")
        completion(entry)
    }

    // 위젯 업데이트를 원하는 시간을 배열로 관리
    // 위젯 상태 변경 시점 (타임정책 설정)
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }
        // 타임 라인 마지막 날짜가 지난 뒤에 위젯킷이 새로운 타임라인을 요청할 수 있도록 설정 .atEnd
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

// Entry, TimelineEntry: 실제 위젯 구성 시 필요한 데이터
//var date: Date { get }                            : 추후 위젯이 다시 그려질 시간에 대한 정보
//var relevance: TimelineEntryRelevance? { get }    : 스마트 스택(시간, score가 높으면 스택 최상단)
struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

// EntryView: 실제 위젯에 대한 UI 담당
struct BasicWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            HStack {
                Text("\(UserDefaults.standard.string(forKey: "coin") ?? "없음")")
                Text(entry.date, style: .time)
                    .font(.title)
            }
            Text("RandomNumber: \(Int.random(in: 1...100))")
            Text(entry.emoji)
        }
    }
}

// 최종적으로 구성되는 WidgetConfiguration
struct BasicWidget: Widget {
    let kind: String = "BasicWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                BasicWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                BasicWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("위젯위젯")
        .description("이 위젯을 사용하면 어떤 기능이 생길까요?")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    BasicWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
