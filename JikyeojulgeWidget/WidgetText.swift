//
//  WidgetText.swift
//  JikyeojulgeWidgetExtension
//
//  Created by 김민택 on 2022/07/16.
//

import SwiftUI

struct WidgetText: View {
    let personalInfoType: String
    let size: Int
    
    var body: some View {
        Text(personalInfoType)
            .foregroundColor(Color.white)
            .font(.system(size: CGFloat(size), weight: .black, design: .rounded))
    }
}
