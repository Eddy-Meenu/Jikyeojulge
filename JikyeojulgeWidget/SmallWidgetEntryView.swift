//
//  SmallWidgetEntryView.swift
//  JikyeojulgeWidgetExtension
//
//  Created by 김민택 on 2022/07/16.
//

import WidgetKit
import SwiftUI
import Intents

struct SmallWidgetEntryView : View {
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
                    WidgetText(personalInfoType: personalInfo[0].bloodType ?? "AB+",
                               size: setFontSizeByBloodType(bloodType: personalInfo[0].bloodType ?? "AB+"))
                    
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
