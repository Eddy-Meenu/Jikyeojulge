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
    
    @State var lastInput = false
    @State var showText = false
    
    @State var show = false
    @State var showImage: Data?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State var nextView: Data?

    var body: some View {
        ZStack{
            Color.mainBlue
                .ignoresSafeArea()
            
            VStack {

                InitTitle(title: $title, arrayCount: $arrayCount)

                if arrayCount >= 4 {
                    if showImage == nil {
                        Button(action: {
                            self.show.toggle()
                        }, label: {
                            Image(systemName: "photo.fill")
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFill()
                                .foregroundColor(.gray)
                                .frame(width: 150, height: 150)
                                .padding(.top, 50)
                        })
                    } else {
                        Button(action: {
                            self.show.toggle()
                        }, label: {
                            Image(uiImage: UIImage(data: self.showImage!)!)
                                .resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 190, height: 190)
                                .padding(.top, 50)
                        })
                    }
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

                if showImage != nil {
//                    NavigationLink(destination: MainView().environmentObject(items), tag: true, selection: $nextView) {
//                        EmptyView()
//                    }
                    Initbtn(arrayCount: $arrayCount, showText: $showText, name: $name)
                } else if !Contact1.isEmpty && !Contact2.isEmpty {
                    Initbtn(arrayCount: $arrayCount, showText: $showText, name: $name)
                        .opacity(self.arrayCount < 4 ? 1 : 0)
                } else if !bloodType.isEmpty {
                    Initbtn(arrayCount: $arrayCount, showText: $showText, name: $name)
                        .opacity(self.arrayCount < 3 ? 1 : 0)
                } else if !birth.isEmpty {
                    Initbtn(arrayCount: $arrayCount, showText: $showText, name: $name)
                        .opacity(self.arrayCount < 2 ? 1 : 0)
                } else if !name.isEmpty {
                    Initbtn(arrayCount: $arrayCount, showText: $showText, name: $name)
                        .opacity(self.arrayCount < 1 ? 1 : 0)
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 25)
            .sheet(isPresented: self.$show, content: {
                ImagePicker(images: $showImage, show: self.$show, sourceType: self.sourceType)
            })
        }
        .navigationBarHidden(true)
    }
}

struct InitSettingView_Previews: PreviewProvider {
    static var previews: some View {
        InitSettingView()
    }
}
