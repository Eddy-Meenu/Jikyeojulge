//
//  ModifyingNumLine.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/10.
//

import SwiftUI

struct ModifyingInfoNumLine: View {

    var label = ""
    var placeholder = ""
    @Binding var value: String

    
    var body: some View {
        HStack {
            Text(label)

            TextField(placeholder, text: $value)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
        }
    }
}

