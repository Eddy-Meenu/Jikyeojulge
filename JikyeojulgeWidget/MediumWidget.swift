//
//  MediumWidget.swift
//  JikyeojulgeWidgetExtension
//
//  Created by 김민택 on 2022/07/16.
//

import WidgetKit
import SwiftUI
import Intents

struct MediumWidget: Widget {
    let persistenceController = PersistenceController.shared
    
    let kind: String = "MediumWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: PersonalInfoListIntent.self, provider: Provider()) { entry in
           MediumWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("기본 정보")
        .description("위젯을 통해 혈액형 정보와 비상 연락처, 질병 기록을 전부 제공할 수 있습니다.")
        .supportedFamilies([.systemMedium])
    }
}
