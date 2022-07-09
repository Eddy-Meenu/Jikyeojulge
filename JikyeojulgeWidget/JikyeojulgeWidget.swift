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
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
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
    let configuration: ConfigurationIntent
}

struct JikyeojulgeSmallBloodTypeWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    
    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [])
    var personalInfo: FetchedResults<PersonalInfoEntity>

    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color.widgetBlue
            
            Text(personalInfo[0].bloodType ?? "AB+")
                .foregroundColor(Color.white)
                .font(.system(size: 50, weight: .black, design: .rounded))
        }
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
            
            Text(personalInfo[0].contact1 ?? "010\n1234\n5678")
                .foregroundColor(Color.white)
                .font(.system(size: 34, weight: .black, design: .rounded))
        }
    }
}

struct JikyeojulgeSmallContactTwoWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    
    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [])
    var personalInfo: FetchedResults<PersonalInfoEntity>
    
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color.widgetBlue
            
            Text(personalInfo[0].contact2 ?? "010\n1234\n5678")
                .foregroundColor(Color.white)
                .font(.system(size: 34, weight: .black, design: .rounded))
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
                
                Text(personalInfo[0].bloodType ?? "AB+")
                    .foregroundColor(Color.white)
                    .font(.system(size: 65, weight: .black, design: .rounded))
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    
                    Text(personalInfo[0].contact1 ?? "010-1234-5678")
                        .foregroundColor(Color.white)
                        .font(.system(size: 18, weight: .black, design: .rounded))
                    
                    Text(personalInfo[0].contact2 ?? "010-5678-1234")
                        .foregroundColor(Color.white)
                        .font(.system(size: 18, weight: .black, design: .rounded))
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
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
           JikyeojulgeSmallWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("비상 연락처 1")
        .description("위젯을 통해 비상 연락처 또는 혈액형 정보를 제공할 수 있습니다.")
        .supportedFamilies([.systemSmall])
    }
}

struct JikyeojulgeMediumWidget: Widget {
    let persistenceController = PersistenceController.shared
    
    let kind: String = "JikyeojulgeMediumWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
           JikyeojulgeMediumWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("기본 정보")
        .description("위젯을 통해 혈액형 정보와 비상 연락처를 제공할 수 있습니다.")
        .supportedFamilies([.systemMedium])
    }
}

struct JikyeojulgeMediumWidget_Previews: PreviewProvider {
    static var previews: some View {
       JikyeojulgeMediumWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
