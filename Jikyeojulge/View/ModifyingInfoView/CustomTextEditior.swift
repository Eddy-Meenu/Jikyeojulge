//
//  CustomTextEditior.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/28.
//

import SwiftUI

struct CustomTextEditor: View {
    let placholder: String
    @Binding var medicalRecord: String

    var body: some View {

        TextEditor(text: $medicalRecord)
            .frame(width: 302, height: 156)
            .background(Rectangle()
                .stroke(Color.black.opacity(0.5)))
            .padding(.horizontal, 24)
            .foregroundColor(medicalRecord == "지병에 대해 적어주세요." ? .gray: .primary)
            .onTapGesture {
                if medicalRecord == "지병에 대해 적어주세요." {
                    medicalRecord = ""
                }
            }
    }
}
