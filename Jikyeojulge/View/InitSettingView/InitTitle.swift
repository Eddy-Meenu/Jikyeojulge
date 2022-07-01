//
//  InitTitle.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/28.
//

import SwiftUI

struct InitTitle: View {
    @Binding var title: [String]
    @Binding var arrayCount: Int
    
    var body: some View {
        
        HStack {
            Text("\(title[arrayCount])")
                .font(.system(size: 25, weight: .bold))
            Spacer()
        }
    }
}
