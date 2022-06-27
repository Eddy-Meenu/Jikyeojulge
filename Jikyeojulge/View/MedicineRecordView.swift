//
//  MedicineRecordView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct MedicineInfo: View {
    var body: some View {
        ZStack {
            Color.white
            HStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.red)
                VStack(alignment: .leading) {
                    Text("이부프로펜")
                        .font(.system(size: 20, weight: .bold))
                    Text("-효과")
                    Text("이 약은 약물중독, 자가중독에 사용합니다.")
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct MedicineInfo_Previews: PreviewProvider {
    static var previews: some View {
        MedicineInfo()
    }
}

struct MedicineRecordView: View {
    @State private var tempText = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.gray
                .ignoresSafeArea()
            VStack {
                HStack {
                    TextField("placeholder", text: $tempText)
                    Text("~")
                    TextField("placeholder", text: $tempText)
                    Button(action: {
                        
                    }, label: {
                        Text("확인")
                    })
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 10))
                }
                MedicineInfo()
                MedicineInfo()
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("진단서 및 복용약")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MedicineRecordView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineRecordView()
    }
}
