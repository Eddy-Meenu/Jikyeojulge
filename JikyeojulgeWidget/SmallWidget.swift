//
//  SmallWidget.swift
//  JikyeojulgeWidgetExtension
//
//  Created by 김민택 on 2022/07/16.
//

import WidgetKit
import SwiftUI
import Intents

struct SmallWidget: Widget {
    let persistenceController = PersistenceController.shared
    
    let kind: String = "SmallWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: PersonalInfoListIntent.self, provider: Provider()) { entry in
           SmallWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("선택 정보")
        .description("위젯을 통해 비상 연락처, 혈액형 또는 질병 기록 정보 중 하나를 선택해서 제공할 수 있습니다.")
        .supportedFamilies([.systemSmall])
    }
}
