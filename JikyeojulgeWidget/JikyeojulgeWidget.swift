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
            case .unknown, .contact:
                VStack(spacing: 5) {
                    Text("비상 연락처")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.white)
                        .padding(.bottom, 12)
                    
                    WidgetText(personalInfoType: personalInfo[0].contact1 ?? "010\n1234\n5678", size: 16)
                    
                    WidgetText(personalInfoType: personalInfo[0].contact2 ?? "010\n1234\n5678", size: 16)
                }
                
            case .medicalInfo:
                VStack {
                    WidgetText(personalInfoType: personalInfo[0].bloodType ?? "AB+", size: setFontSizeByBloodType(bloodType: personalInfo[0].bloodType ?? "AB+"))
                    
                    Text(personalInfo[0].medicalRecord ?? "")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.white)
                        .padding(.bottom, 11)
                }
            }
        }
    }
    
    func setFontSizeByBloodType(bloodType: String) -> Int {
        switch bloodType {
        case "AB+", "AB-":
            return 60
        default:
            return 70
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
                VStack {
                    WidgetText(personalInfoType: personalInfo[0].bloodType ?? "AB+", size: setFontSizeByBloodType(bloodType: personalInfo[0].bloodType ?? "AB+"))
                    
                    WidgetText(personalInfoType: personalInfo[0].medicalRecord ?? "", size: 16)
                }
                .padding(.trailing, 10)
                .padding(.bottom, 10)
                
                VStack(alignment: .leading) {
                    WidgetText(personalInfoType: personalInfo[0].contact1 ?? "010-1234-5678", size: 20)
                    
                    WidgetText(personalInfoType: personalInfo[0].contact2 ?? "010-1234-5678", size: 20)
                        .padding(.top, 5)
                }
            }
        }
    }
    
    func setFontSizeByBloodType(bloodType: String) -> Int {
        switch bloodType {
        case "AB+", "AB-":
            return 50
        default:
            return 60
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
        .description("위젯을 통해 비상 연락처, 혈액형 또는 질병 기록 정보 중 하나를 선택해서 제공할 수 있습니다.")
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
        .description("위젯을 통해 혈액형 정보와 비상 연락처, 질병 기록을 전부 제공할 수 있습니다.")
        .supportedFamilies([.systemMedium])
    }
}

struct JikyeojulgeMediumWidget_Previews: PreviewProvider {
    static var previews: some View {
       JikyeojulgeMediumWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: PersonalInfoListIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
