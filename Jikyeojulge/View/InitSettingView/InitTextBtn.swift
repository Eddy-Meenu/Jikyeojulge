//
//  InitTextBtn.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/28.
//

import SwiftUI

struct InitTextField: View {
    var placeholder = ""
    @Binding var value: String

    var body: some View {
        
        TextField(placeholder, text: $value)
            .multilineTextAlignment(.center)
            .font(.system(size: 18, weight: .regular))
            .padding(.top, 15)
        Divider()
            .background(.black)
    }
}
