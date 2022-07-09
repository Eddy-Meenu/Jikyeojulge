//
//  Text+Extension.swift
//  Jikyeojulge
//
//  Created by 김민택 on 2022/07/10.
//

import SwiftUI

extension Text {
    func widgetText(size: Int) -> some View {
        self
            .foregroundColor(Color.white)
            .font(.system(size: CGFloat(size), weight: .black, design: .rounded))
    }
}
