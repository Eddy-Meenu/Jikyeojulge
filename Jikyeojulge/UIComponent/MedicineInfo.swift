//
//  MedicineInfo.swift
//  Jikyeojulge
//
//  Created by 김민택 on 2022/07/01.
//

import SwiftUI

struct MedicineInfo: View {
    @ObservedObject var networkManager: NetworkManager
    var medicine: Medicine

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: medicine.itemImage ?? "https://immeenu.com/image/defaultMedicine.png"), scale: 6.0)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .padding(.trailing, 16)
            
            VStack(alignment: .leading, spacing: 15) {
                HStack(alignment: .top) {
                    contentsProvider(contents: medicine.itemName)
                        .font(.system(size: 16, weight: .bold))
                    
                    Spacer()
                    
                    if networkManager.compareMedicine(medicine: medicine) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.green)
                    }
                }
                
                contentsProvider(contents: medicine.efcyQesitm)
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
    }
    
    func contentsProvider(contents: String?) -> some View {
        return AnyView(Text(contents?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil) ?? "등록된 정보가 없습니다"))
    }
}
