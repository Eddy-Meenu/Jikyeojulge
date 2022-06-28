//
//  InitSettingView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct InitSettingView: View {
    @State var name = ""
    @State var birth = ""
    @State var bloodType = ""
    @State var Contact1 = ""
    @State var Contact2 = ""
    @State var title = ["이름을 입력해주세요", "생년월일을 입력해주세요", "혈액형을 입력해주세요", "비상연락처를 입력해주세요", "사진을 등록해주세요"]
    @State var arrayCount = 0
    var body: some View {
        ZStack{
            Color.mainBlue.ignoresSafeArea()
            
            VStack {

                InitTitle(title: $title, arrayCount: $arrayCount)
                
                if arrayCount >= 4 {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                        .frame(width: 150, height: 150)
                }
                
                if arrayCount >= 3 {
                    HStack {
                        VStack {
                            InitTextField(placeholder: "010-0000-0000", value: $Contact1)
                        }
                        
                        VStack {
                            InitTextField(placeholder: "010-2222-2222", value: $Contact2)
                        }
                    }
                }
                
                if arrayCount >= 2 {
                    InitTextField(placeholder: "A+", value: $bloodType)
                }
                
                if arrayCount >= 1 {
                    InitTextField(placeholder: "1999년 01월 01일", value: $birth)
                }
                
                InitTextField(placeholder: "홍길동", value: $name)
                Spacer()
                
                Initbtn(arrayCount: $arrayCount)
            }
            .padding(.top, 40)
            .padding(.horizontal, 25)
        }
        
    }
}

struct InitSettingView_Previews: PreviewProvider {
    static var previews: some View {
        InitSettingView()
    }
}


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


struct InitTextField: View {
    var placeholder = ""
    @Binding var value: String

    var body: some View {
        
        TextField(placeholder, text: $value)
            .multilineTextAlignment(.center)
            .font(.system(size: 18, weight: .regular))
            .padding(.top, 15)
        Divider()
            .background(.black)
    }
}
