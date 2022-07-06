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
    
//    let moc = CoreDataStack.shared.managedObjectContext
//
//    let predicate = NSPredicate(format: "attribute1 == %@", "test")
//    let request = NSFetchRequest<SomeItem>(entityName: "PersonalInfoEntity")
//    let result = try moc.fetch(request)
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
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

struct JikyeojulgeWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \PersonalInfoEntity.id, ascending: true)],
//        animation: .default)
    
//    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [
//        NSSortDescriptor(keyPath: \PersonalInfoEntity.id, ascending: true),
//        NSSortDescriptor(keyPath: \PersonalInfoEntity.name, ascending: false),
//        NSSortDescriptor(keyPath: \PersonalInfoEntity.photoImage, ascending: false),
//        NSSortDescriptor(keyPath: \PersonalInfoEntity.bloodType, ascending: false),
//        NSSortDescriptor(keyPath: \PersonalInfoEntity.birth, ascending: false),
//        NSSortDescriptor(keyPath: \PersonalInfoEntity.contact1, ascending: false),
//        NSSortDescriptor(keyPath: \PersonalInfoEntity.contact2, ascending: false)])
//    var personalInfo: FetchedResults<PersonalInfoEntity>
    
    @State var personalInfo: FetchedResults<PersonalInfoEntity>.Element?
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color.widgetBlue
            HStack {
    //            Text(personalInfo[0].bloodType ?? "a")
                Text(personalInfo?.bloodType ?? "A+")
                    .foregroundColor(Color.white)
                    .font(.system(size: 70, weight: .black, design: .rounded))
                    .padding(.trailing, 10)
                VStack(alignment: .leading) {
                    
    //                Text(personalInfo[0].contact2 ?? "c")
                    Text(personalInfo?.contact1 ?? "010-1234-5678")
                        .foregroundColor(Color.white)
                        .font(.system(size: 22, weight: .black, design: .rounded))
                    Text(personalInfo?.contact1 ?? "010-5678-1234")
                        .foregroundColor(Color.white)
                        .font(.system(size: 22, weight: .black, design: .rounded))
                        .padding(.top, 5)
                }
            }
        }
    }
}

@main
struct JikyeojulgeWidget: Widget {
    let persistenceController = PersistenceController.shared
    
    let kind: String = "JikyeojulgeWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            JikyeojulgeWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct JikyeojulgeWidget_Previews: PreviewProvider {
    static var previews: some View {
        JikyeojulgeWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
