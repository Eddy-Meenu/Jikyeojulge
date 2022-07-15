//
//  MedicalPhotoDirectInputView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/11.
//

import SwiftUI

struct MedicalDirectInputView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var dismiss
    @State var value = ""
    @State var description = "진단 및 약 처방에 대한 이유를 적어주세요."
    @State var isShowingImagePicker = false
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var selectedImage: UIImage?
    @State var show = false

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
                            let image = photoImage ?? Image(systemName: "camera.fill")
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(.white)
                                .padding(.horizontal, 25)
                                .padding(.vertical, 10)
// TODO: 언젠가 이 색깔을 피그마에서 뽑아서 더블백그라운드를 없애주기를..
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.mainBlue))
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.mainBlue))
                        }
                    })
                    .fullScreenCover(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(images: $selectedImage, show: $show, sourceType: .camera)
                    }
                }
                .padding(.vertical, 24)
                
                HStack {
                    Text("진단서 또는 처방약")
                        .font(.system(size: 18, weight: .bold))
                        
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
                    .padding(.bottom, 14)
                
                HStack {
                    Text("설명")
                        .font(.system(size: 18, weight: .bold))
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
