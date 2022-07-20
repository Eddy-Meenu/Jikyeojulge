//
//  MediumWidgetEntryView.swift
//  JikyeojulgeWidgetExtension
//
//  Created by 김민택 on 2022/07/16.
//

import WidgetKit
import SwiftUI
import Intents

struct MediumWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    
    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [])
    var personalInfo: FetchedResults<PersonalInfoEntity>

    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color.widgetBlue
            HStack {
                VStack {
                    WidgetText(personalInfoType: personalInfo[0].bloodType ?? "AB+",
                               size: setFontSizeByBloodType(bloodType: personalInfo[0].bloodType ?? "AB+"))
                    
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
