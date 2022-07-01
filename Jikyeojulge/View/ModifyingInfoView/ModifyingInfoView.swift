//
//  ModifyingInfoView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct ModifyingInfoView: View {
    @State var name: String = ""
    @State var birth: String = ""
    @State var bloodType: String = ""
    @State var contact1: String = ""
    @State var contact2: String = ""
    @State var medicalRecord: String = "지병에 대해 적어주세요."

    var body: some View {
        ZStack {
            Color.mainBlue
                .ignoresSafeArea()

            VStack {
                Image(systemName: "photo")
                    .resizable()
                    .clipShape(Circle())
                    .foregroundColor(.mainBlue)
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                
                VStack {
                    ModifyingInfoTextLine(label: "이름", placeholder: "에디", value: $name)
                    Divider()
                    
                    ModifyingInfoTextLine(label: "생년월일", placeholder: "1999년 01월 01일", value: $birth)
                    Divider()
                    
                    ModifyingInfoTextLine(label: "혈액형", placeholder: "A+", value: $bloodType)
                    Divider()
                    
                    ModifyingInfoTextLine(label: "비상연락처", placeholder: "010-0000-0000", value: $contact1)
                    ModifyingInfoTextLine(label: "", placeholder: "010-2222-2222", value: $contact2)
                    Divider()
                }
                .padding(.horizontal, 24)
                
                HStack{
                    Text("의료 기록")
                    Spacer()
                }
                .padding(.horizontal, 24)

                CustomTextEditor(placholder: "지병에 대해 적어주세요", medicalRecord: $medicalRecord)
            }
            .frame(width: 350, height: 630)
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.mainWhite)
                .shadow(color: .gray.opacity(0.25), radius: 10, x: 2, y: 2))
        }
    }
}

struct ModifyingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyingInfoView()
    }
}

