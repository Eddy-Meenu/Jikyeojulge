//
//  MainView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct MainView: View {
    @State var medicalRecord: String = "지병에 대해 적어주세요."
    
    var body: some View {
        ZStack {
            Color.mainBlue.ignoresSafeArea()
            VStack {
                Image(systemName: "photo")
                    .resizable()
                    .clipShape(Circle())
                    .foregroundColor(.mainBlue)
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                
                
                VStack {
                    HStack {
                        Text("이름")
                        Spacer()
                        Text("에디")
                            
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("생년월일")
                        Spacer()
                        Text("1999년 01월 01일")
                    }
                    Divider()
                    
                    HStack {
                        Text("혈액형")
                        Spacer()
                        Text("A+")
                    }
                    Divider()
                    
                    HStack {
                        Text("비상연락처")
                        Spacer()
                        Text("010-0000-0000")
                    }
                    .padding(.bottom, 2)
                    HStack {
                        Spacer()
                        Text("010-2222-2222")
                    }
                    Divider()
                }
                .padding(.horizontal, 24)
                
                HStack {
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
    
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


struct CustomTextEditor: View {
    let placholder: String
    @Binding var medicalRecord: String
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
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
}
