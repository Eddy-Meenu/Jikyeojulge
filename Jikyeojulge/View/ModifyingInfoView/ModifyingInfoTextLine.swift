//
//  ModifyingInfoTextLine.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/28.
//

import SwiftUI

struct ModifyingInfoTextLine: View {
    var label = ""
    var placeholder = ""
    @Binding var value: String

    var body: some View {
        HStack {
            Text(label)
            TextField(placeholder, text: $value)
                .multilineTextAlignment(.trailing)
                .disableAutocorrection(true)
        }
    }
}
