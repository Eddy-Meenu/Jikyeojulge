//
//  MedicineDetailView.swift
//  Jikyeojulge
//
//  Created by 김민택 on 2022/06/28.
//

import SwiftUI

struct MedicineDetailView: View {
    var body: some View {
        ZStack {
            Color.mainBlue
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .center) {
                    Image("DefaultMedicine")
                        .cornerRadius(10)
                    
                    Spacer()
                        .frame(height: 25)
                    
                    Text("약 이름")
                        .font(.system(size: 20, weight: .bold))
                }
                
                Spacer()
                    .frame(height: 25)
                
                VStack(alignment: .leading) {
                    Group {
                        Text("효능")
                            .font(.system(size: 16, weight: .bold))
                        
                        Text("이 약은 식욕감퇴(식욕부진), 위부팽만감, 소화불량, 과식, 체함, 구역, 구토에 사용합니다.")
                            .font(.system(size: 16))
                        
                        Spacer()
                            .frame(height: 15)
                        
                        Divider()
                        
                        Spacer()
                            .frame(height: 15)
                    }
                    
                    Group {
                        Text("상호작용")
                            .font(.system(size: 16, weight: .bold))
                        
                        Text("메토트렉세이트, 설포닐우레아, 다른 국소 적용 약물과 함께 사용 시 의사 또는 약사와 상의하십시오.")
                            .font(.system(size: 16))
                        
                        Spacer()
                            .frame(height: 15)
                        
                        Divider()
                        
                        Spacer()
                            .frame(height: 15)
                    }
                    
                    Text("부작용")
                        .font(.system(size: 16, weight: .bold))
                    Text("발진, 발적(충혈되어 붉어짐), 홍반(붉은 반점), 가려움, 정상 피부에 닿았을 경우 국소 자극 반응이 나타나는 경우 사용을 즉각 중지하고 의사 또는 약사와 상의하십시오.\n\n드물게 피부자극, 접촉성 알레르기 반응 등이 나타날 수 있습니다.")
                        .font(.system(size: 16))
                }
            }
            .padding(16)
            .frame(maxHeight: .infinity)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.15), radius: 30, x: 6, y: 6))
            .padding(20)
        }
        .navigationTitle("약품 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MedicineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineDetailView()
    }
}
