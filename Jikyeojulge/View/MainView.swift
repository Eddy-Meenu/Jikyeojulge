//
//  MainView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \PersonalInfoEntity.id, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.name, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.photoImage, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.bloodType, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.birth, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.contact1, ascending: false),
        NSSortDescriptor(keyPath: \PersonalInfoEntity.contact2, ascending: false)])
    var personalInfo: FetchedResults<PersonalInfoEntity>
    
    @State public var image: Data = .init(count: 0)

    @State var medicalRecord: String = "지병에 대해 적어주세요."
    
    var body: some View {
        ZStack {
            Color.mainBlue.ignoresSafeArea()
            
            ForEach(personalInfo, id: \.id) { info in
                VStack {
                    Image(uiImage: UIImage(data: info.photoImage ?? self.image)!)
                        .resizable()
                        .clipShape(Circle())
                        .foregroundColor(.mainBlue)
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                    
                    VStack {
                        HStack {
                            Text("이름")
                            Spacer()
                            Text(info.name ?? "")
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("생년월일")
                            Spacer()
                            Text(info.birth ?? "")
                        }
                        Divider()
                        
                        HStack {
                            Text("혈액형")
                            Spacer()
                            Text(info.bloodType ?? "")
                        }
                        Divider()
                        
                        HStack {
                            Text("비상연락처")
                            Spacer()
                            Text(info.contact1 ?? "")
                        }
                        .padding(.bottom, 2)
                        HStack {
                            Spacer()
                            Text(info.contact2 ?? "")
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
