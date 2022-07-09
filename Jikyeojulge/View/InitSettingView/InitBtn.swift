//
//  InitBtn.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/28.
//

import SwiftUI

struct Initbtn: View {
    @Binding var arrayCount: Int

    var body: some View {
        
        Button(action: {
            arrayCount += 1
        }, label: {
            Text("확인")
                .foregroundColor(.mainWhite)
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 133)
                .padding(.vertical, 14)
        })
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.mainBtnBlue))
    }
}
