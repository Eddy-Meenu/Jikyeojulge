//
//  MedicineDetailView.swift
//  Jikyeojulge
//
//  Created by 김민택 on 2022/06/28.
//

import SwiftUI

struct MedicineDetailView: View {
    @ObservedObject var networkManager = NetworkManager()
    var medicine: Medicine
    
    var body: some View {
        ZStack {
            Color.mainBlue
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: medicine.itemImage ?? "https://github.com/Eddy-Meenu/Jikyeojulge/blob/main/Jikyeojulge/Assets.xcassets/DefaultMedicine.imageset/medicineDefault.png?raw=true"), scale: 5.0)
                        .cornerRadius(10)
                    
                    Spacer()
                        .frame(height: 25)
                    
                    Text(medicine.itemName?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil) ?? "약 이름")
                        .font(.system(size: 20, weight: .bold))
                }
                
                Spacer()
                    .frame(height: 25)
                
                VStack(alignment: .leading) {
                    Group {
                        Text("효능")
                            .font(.system(size: 16, weight: .bold))
                        
                        Text(medicine.efcyQesitm?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil) ?? "약 효능")
                            .font(.system(size: 16))
                        
                        Divider()
                            .padding(.vertical, 15)
                    }
                    
                    Group {
                        Text("상호작용")
                            .font(.system(size: 16, weight: .bold))
                        
                        Text(medicine.intrcQesitm?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil) ?? "약 상호작용")
                            .font(.system(size: 16))
                        
                        Divider()
                            .padding(.vertical, 15)
                    }
                    
                    Text("부작용")
                        .font(.system(size: 16, weight: .bold))
                    Text(medicine.seQesitm?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil) ?? "약 부작용")
                        .font(.system(size: 16))
                }
            }
            .padding(16)
            .frame(maxHeight: .infinity)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .border(.white.opacity(0.2)).cornerRadius(10)
                .shadow(color: Color.black.opacity(0.15), radius: 30, x: 6, y: 6))
            .padding(20)
        }
        .navigationTitle("약품 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}
