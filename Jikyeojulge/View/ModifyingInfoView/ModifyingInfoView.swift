//
//  ModifyingInfoView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct ModifyingInfoView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var dismiss

    @State var name: String = ""
    @State var birth: String = ""
    @State var bloodType: String = ""
    @State var contact1: String = ""
    @State var contact2: String = ""
    @State var medicalRecord: String = "지병에 대해 적어주세요."
    @State var isShowing = false
    @State var showImage: Data = .init(count: 1)
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @State var photoImage: Image?
    @State var selectedImage: UIImage?
    
    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \PersonalInfoEntity.id, ascending: true),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.name, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.photoImage, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.bloodType, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.birth, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.contact1, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.contact2, ascending: false)])
    var personalInfo: FetchedResults<PersonalInfoEntity>
        
    var body: some View {
        ZStack {
            Color.mainBlue
                .ignoresSafeArea()
            
            ForEach(personalInfo, id: \.id) { info in
                VStack {
                    let image = photoImage ?? Image(uiImage: UIImage(data: (info.photoImage)!)!)
                    image
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .padding(.top, 50)
                        .onTapGesture {
                            self.isShowing.toggle()
                        }

                    VStack {
                        ModifyingInfoTextLine(label: "이름",
                                              placeholder: info.name ?? "",
                                              value: $name)
                        Divider()

                        ModifyingInfoTextLine(label: "생년월일",
                                              placeholder: info.birth ?? "",
                                              value: $birth)
                        Divider()

                        ModifyingInfoTextLine(label: "혈액형",
                                              placeholder: "A+",
                                              value: $bloodType)
                        Divider()

                        ModifyingInfoTextLine(label: "비상연락처",
                                              placeholder: "010-1234-1234",
                                              value: $contact1)

                        ModifyingInfoTextLine(label: "",
                                              placeholder: "010-5678-5678",
                                              value: $contact2)
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
                .fullScreenCover(isPresented: self.$isShowing, onDismiss: loadImage, content: {
                    ImagePicker(images: self.$selectedImage, show: self.$isShowing, sourceType: self.sourceType)
                })

            }
            .frame(width: 350, height: 630)
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.mainWhite)
                .shadow(color: .gray.opacity(0.25), radius: 10, x: 2, y: 2))
            
        }
        .onAppear {
            name = personalInfo[0].name!
            birth = personalInfo[0].birth!
            bloodType = personalInfo[0].bloodType!
            contact1 = personalInfo[0].contact1!
            contact2 = personalInfo[0].contact2!
            selectedImage = UIImage(data: personalInfo[0].photoImage!)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {

                Button(action: {
                    updatePersonalInfo(name: name,
                                       photoImage: selectedImage!,
                                       contact1: contact1,
                                       contact2: contact2,
                                       birth: birth,
                                       bloodType: bloodType)
                    
                    dismiss.wrappedValue.dismiss()
                }, label: {
                    Text("저장")
                })
            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        photoImage = Image(uiImage: selectedImage)
    }

    func updatePersonalInfo(name: String, photoImage: UIImage, contact1: String, contact2: String, birth: String, bloodType: String) {
        personalInfo[0].name = name
        personalInfo[0].photoImage = photoImage.pngData()
        personalInfo[0].contact1 = contact1
        personalInfo[0].contact2 = contact2
        personalInfo[0].birth = birth
        personalInfo[0].bloodType = bloodType

        try! self.viewContext.save()
    }
}
