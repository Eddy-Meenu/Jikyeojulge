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
    static let lightGray: Color = Color(red: 118/255, green: 118/255, blue: 128/255).opacity(0.12)
    static let darkGray: Color = Color(red: 60/255, green: 60/255, blue: 67/255).opacity(0.6)
    static let widgetBlue: Color = Color(red: 161/255, green: 176/255, blue: 249/255)
    static let mainBlueGeneric:  Color = Color(red: 229/255, green: 233/255, blue: 247/255)
}

extension TextField {
    func nothing() -> some View {
        self
            .multilineTextAlignment(.center)
            .font(.system(size: 18, weight: .regular))
            .padding(.top, 15)
    }
}
