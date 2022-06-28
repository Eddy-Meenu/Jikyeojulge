//
//  Color+Extension.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/27.
//

import SwiftUI

extension Color {
    static let mainBtnBlue: Color = Color(red: 6/255, green: 44/255, blue: 187/255).opacity(0.8)
    static let subBtnBlue: Color = Color(red: 6/255, green: 44/255, blue: 187/255).opacity(0.5)
    static let mainBlue: Color = Color(red: 6/255, green: 44/255, blue: 187/255).opacity(0.1)
    static let mainWhite: Color = Color(red: 249/255, green: 249/255, blue: 249/255)
}

extension TextField {
    func nothing() -> some View {
        self
            .multilineTextAlignment(.center)
            .font(.system(size: 18, weight: .regular))
            .padding(.top, 15)
    }
}