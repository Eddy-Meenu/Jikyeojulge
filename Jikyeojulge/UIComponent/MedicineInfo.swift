//
//  MedicineInfo.swift
//  Jikyeojulge
//
//  Created by 김민택 on 2022/07/01.
//

import SwiftUI

struct MedicineInfo: View {
    var medicine: Medicine

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: medicine.itemImage ?? "https://github.com/Eddy-Meenu/Jikyeojulge/blob/main/Jikyeojulge/Assets.xcassets/DefaultMedicine.imageset/medicineDefault.png?raw=true"), scale: 6.0)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .padding(.trailing, 16)
            
            VStack(alignment: .leading, spacing: 15) {
                Text(medicine.itemName ?? "약 이름")
                    .font(.system(size: 16, weight: .bold))
                
                Text(medicine.efcyQesitm ?? "약 효능")
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
    }
}
