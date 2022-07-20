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
    @State var contact1 = ""
    @State var contact2 = ""
    @State var title = ["이름을 입력해주세요",
                        "생년월일을 입력해주세요",
                        "혈액형을 입력해주세요",
                        "비상연락처를 입력해주세요",
                        "사진을 등록해주세요"]
    
    @State var arrayCount = 0
    
    @State var show = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State var nextView: Bool? = false
    
    @State private var selectedURL: URL?
    @ObservedObject var imageLoader = ImageLoader()
    @State var selectedImage: UIImage?
    @State var photoImage: Image?

    var body: some View {
        ZStack{
            Color.mainBlue
                .ignoresSafeArea()

            VStack {
                InitTitle(title: $title,
                          arrayCount: $arrayCount)

                ScrollView(showsIndicators: false) {
                    if arrayCount >= 4 {
                            let image = photoImage ?? Image(systemName: "photo.fill")
                            image
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .padding(.top, 50)
                            .onTapGesture{
                                self.show.toggle()
                            }
                            .sheet(isPresented: self.$show, onDismiss: loadImage, content: {
                                ImagePicker(images: self.$selectedImage, show: self.$show, sourceType: self.sourceType)
                            })
                    }

                    if arrayCount >= 3 {
                        HStack {
                            VStack {
                                InitTextField(placeholder: "010-0000-0000", value: $contact1)
                            }

                            VStack {
                                InitTextField(placeholder: "010-1234-1234", value: $contact2)
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

                if photoImage != nil {
                    Button(action: {
                        savePersonalInfo(name: name,
                                         photoImage: selectedImage!,
                                         contact1: contact1,
                                         contact2: contact2,
                                         birth: birth,
                                         bloodType: bloodType)
                        UserDefaults.standard.set(true, forKey: "initSetting")

                        nextView = true

                    }, label: {
                        Text("확인")
                            .foregroundColor(.mainWhite)
                            .font(.system(size: 18, weight: .bold))
                            .padding(.horizontal, 133)
                            .padding(.vertical, 14)
                    })
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color.mainBtnBlue))

                } else if !contact1.isEmpty && !contact2.isEmpty {
                    Initbtn(arrayCount: $arrayCount)
                        .opacity(self.arrayCount < 4 ? 1 : 0)
                } else if !bloodType.isEmpty {
                    Initbtn(arrayCount: $arrayCount)
                        .opacity(self.arrayCount < 3 ? 1 : 0)
                } else if !birth.isEmpty {
                    Initbtn(arrayCount: $arrayCount)
                        .opacity(self.arrayCount < 2 ? 1 : 0)
                } else if !name.isEmpty {
                    Initbtn(arrayCount: $arrayCount)
                        .opacity(self.arrayCount < 1 ? 1 : 0)
                }
            }
            .onTapGesture(perform: hideKeyboard)
            .padding(.top, 40)
            .padding(.horizontal, 25)
        }
        .navigationBarHidden(true)
    }
    private func loadImage() {
        if self.selectedURL != nil {
            self.imageLoader.loadImage(with: selectedURL!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if self.imageLoader.image != nil {
                    selectedImage = self.imageLoader.image
                    photoImage = Image(uiImage: selectedImage!)
                } else {
                    loadImage()
                }
            }
        } else {
            guard let selectedImage = selectedImage else { return }
            photoImage = Image(uiImage: selectedImage)
        }
    }
    
    func savePersonalInfo(name: String, photoImage: UIImage, contact1: String, contact2: String, birth: String, bloodType: String ) {
        let add = PersonalInfoEntity(context: self.viewContext)
        add.name = name
        add.photoImage = photoImage.pngData()
        add.contact1 = contact1
        add.contact2 = contact2
        add.birth = birth
        add.bloodType = bloodType

        try! self.viewContext.save()
    }
}

struct InitSettingView_Previews: PreviewProvider {
    static var previews: some View {
        InitSettingView()
    }
}
