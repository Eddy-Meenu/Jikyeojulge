//
//  JikyeojulgeWidget.swift
//  JikyeojulgeWidget
//
//  Created by 김민택 on 2022/07/04.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: PersonalInfoListIntent())
    }

    func getSnapshot(for configuration: PersonalInfoListIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: PersonalInfoListIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: PersonalInfoListIntent
}

struct WidgetText: View {
    let personalInfoType: String
    let size: Int
    
    var body: some View {
        Text(personalInfoType)
            .foregroundColor(Color.white)
            .font(.system(size: CGFloat(size), weight: .black, design: .rounded))
    }
}

struct JikyeojulgeSmallWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    
    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [])
    var personalInfo: FetchedResults<PersonalInfoEntity>

    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color.widgetBlue
            
            switch entry.configuration.personalInfo {
            case .unknown, .contact1:
                WidgetText(personalInfoType: personalInfo[0].contact1 ?? "010\n1234\n5678", size: 34)
                
            case .contact2:
                WidgetText(personalInfoType: personalInfo[0].contact2 ?? "010\n1234\n5678", size: 34)
                
            case .bloodType:
                WidgetText(personalInfoType: personalInfo[0].bloodType ?? "AB+", size: 50)
            }
        }
    }
}

struct JikyeojulgeMediumWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    
    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [])
    var personalInfo: FetchedResults<PersonalInfoEntity>

    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color.widgetBlue
            HStack {
                
                WidgetText(personalInfoType: personalInfo[0].bloodType ?? "AB+", size: 65)
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    
                    WidgetText(personalInfoType: personalInfo[0].contact1 ?? "010-1234-5678", size: 18)
                    
                    WidgetText(personalInfoType: personalInfo[0].contact2 ?? "010-1234-5678", size: 18)
                        .padding(.top, 5)
                }
            }
        }
    }
}

@main
struct JikyeojulgeWidget: WidgetBundle {
    
    @WidgetBundleBuilder
    var body: some Widget {
        JikyeojulgeSmallWidget()
        JikyeojulgeMediumWidget()
    }
}

struct JikyeojulgeSmallWidget: Widget {
    let persistenceController = PersistenceController.shared
    
    let kind: String = "JikyeojulgeSmallWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: PersonalInfoListIntent.self, provider: Provider()) { entry in
           JikyeojulgeSmallWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("선택 정보")
        .description("위젯을 통해 비상 연락처 또는 혈액형 정보 중 하나를 선택해서 제공할 수 있습니다.")
        .supportedFamilies([.systemSmall])
    }
}

struct JikyeojulgeMediumWidget: Widget {
    let persistenceController = PersistenceController.shared
    
    let kind: String = "JikyeojulgeMediumWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: PersonalInfoListIntent.self, provider: Provider()) { entry in
           JikyeojulgeMediumWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("기본 정보")
        .description("위젯을 통해 혈액형 정보와 비상 연락처를 전부 제공할 수 있습니다.")
        .supportedFamilies([.systemMedium])
    }
}

struct JikyeojulgeMediumWidget_Previews: PreviewProvider {
    static var previews: some View {
       JikyeojulgeMediumWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: PersonalInfoListIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
