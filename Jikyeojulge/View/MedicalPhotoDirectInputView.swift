//
//  MedicalPhotoDirectInputView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/11.
//

import SwiftUI

struct MedicalPhotoDirectInputView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var dismiss
    @State var value = ""
    @State var description = "진단 및 약 처방에 대한 이유를 적어주세요."
    @State var isShowingImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var selectedImage: UIImage?
    @State var show = false
    @State var isShowingSheet = false

    @State var photoImage: Image?
    
    @FetchRequest(entity: PhotoDirectInputEntity.entity(), sortDescriptors: [])
    var medical: FetchedResults<PhotoDirectInputEntity>
    
    var body: some View {
        ZStack{
            Color.mainBlue
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        dismiss.wrappedValue.dismiss()
                    }, label: {
                        Text("취소")
                    })
                    Spacer()
                        Button(action: {
                            saveMedicalData(photo: selectedImage!,
                                            medicalTitle: value,
                                            descriptions: description)
                            dismiss.wrappedValue.dismiss()
                        }, label: {
                            Text("저장")
                        })
                        .disabled(photoImage != nil && !value.isEmpty ? false : true)
                }
                .padding(.top, 24)
                .padding(.horizontal, 24)

                
                HStack(alignment: .center) {
                    Button(action: {
                        self.isShowingImagePicker.toggle()
                        
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 150)
                                .foregroundColor(.white)
                            
                            let image = photoImage ?? Image(systemName: "photo.fill")
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                        }
                    })
                    .fullScreenCover(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(images: $selectedImage, show: $show, sourceType: .camera)
                    }
                }
                .padding(.top, 24)
                .padding(.bottom, 50)
                
                
                HStack {
                    Text("진단서 또는 처방약")
                    Spacer()
                }
                .padding(.horizontal, 24)

                HStack(alignment: .center) {
                    TextField("진단서 또는 처방약 이름을 적어주세요.", text: $value)
                }
                .padding(.horizontal, 24)

                Divider()
                    .background(.black)
                    .padding(.horizontal, 24)

                
                HStack {
                    Text("설명")
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                TextEditor(text: $description)
                    .frame(width: 342, height: 156)
                    .background(Rectangle()
                        .stroke(Color.black.opacity(0.5)))
                    .padding(.horizontal, 24)
                    .foregroundColor(description == "진단 및 약 처방에 대한 이유를 적어주세요." ? .gray: .primary)
                    .onTapGesture {
                        if description == "진단 및 약 처방에 대한 이유를 적어주세요." {
                            description = ""
                        }
                    }
                Spacer()
            }
        }
    }

    func saveMedicalData(photo: UIImage, medicalTitle: String, descriptions: String) {
        let add = PhotoDirectInputEntity(context: self.viewContext)
        add.photo = photo.pngData()
        add.medicalTitle = medicalTitle
//        add.date = date
        add.descriptions = descriptions
        print("안녕하세요")

        try! self.viewContext.save()
    }

    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        photoImage = Image(uiImage: selectedImage)
    }
}
