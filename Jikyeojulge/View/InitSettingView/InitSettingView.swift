//
//  InitSettingView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct InitSettingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
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
    @State public var showImage: Data = .init(count: 0)
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State var nextView: Bool? = false

    var body: some View {
        ZStack{
            Color.mainBlue
                .ignoresSafeArea()

            VStack {
                InitTitle(title: $title, arrayCount: $arrayCount)

                ScrollView(showsIndicators: false) {
                    if arrayCount >= 4 {
                        if showImage.count != 0 {
                            Button(action: {
                                self.show.toggle()
                            }, label: {
                                Image(uiImage: UIImage(data: self.showImage)!)
                                    .resizable()
                                    .clipShape(Circle())
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .padding(.top, 50)
                            })
                        } else {
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
                }
                Spacer()

                if showImage.count != 0 {
                    NavigationLink(destination: MainView(), tag: true, selection: $nextView) {
                        EmptyView()
                    }.isDetailLink(false)
                    Button(action: {
                        savePersonalInfo()
                        UserDefaults.standard.set(true, forKey: "initSetting")

                        nextView = true

//                        self.showImage.count = 0

                    }, label: {
                        Text("확인")
                            .foregroundColor(.mainWhite)
                            .font(.system(size: 18, weight: .bold))
                            .padding(.horizontal, 133)
                            .padding(.vertical, 14)
                    })
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.mainBtnBlue))

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
            .onTapGesture(perform: hideKeyboard)
            .padding(.top, 40)
            .padding(.horizontal, 25)
            .sheet(isPresented: self.$show, content: {
                ImagePicker(images: self.$showImage, show: self.$show, sourceType: self.sourceType)
            })
        }
        .navigationBarHidden(true)
    }
    func savePersonalInfo() {
        let add = PersonalInfoEntity(context: self.viewContext)
        add.name = self.name
        add.photoImage = self.showImage
        add.contact1 = self.Contact1
        add.contact2 = self.Contact2
        add.birth = self.birth
        add.bloodType = self.bloodType

        try! self.viewContext.save()
    }
}

struct InitSettingView_Previews: PreviewProvider {
    static var previews: some View {
        InitSettingView()
    }
}
