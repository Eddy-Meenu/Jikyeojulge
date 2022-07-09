//
//  JikyeojulgePersonalInfoWidget.swift
//  JikyeojulgePersonalInfoWidget
//
//  Created by 김민택 on 2022/07/09.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct JikyeojulgePersonalInfoWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    
    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \PersonalInfoEntity.id, ascending: true),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.name, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.photoImage, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.bloodType, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.birth, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.contact1, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.contact2, ascending: false)])
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
struct JikyeojulgePersonalInfoWidget: Widget {
    let persistenceController = PersistenceController.shared
    let kind: String = "JikyeojulgePersonalInfoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            JikyeojulgePersonalInfoWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("기본 정보")
        .description("위젯을 통해 혈액형과 비상 연락처를 제공할 수 있습니다.")
        .supportedFamilies([.systemMedium])
    }
}

struct JikyeojulgePersonalInfoWidget_Previews: PreviewProvider {
    static var previews: some View {
        JikyeojulgePersonalInfoWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
