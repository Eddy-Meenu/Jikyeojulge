//
//  MainView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct MainView: View {
    
    var content = MainViewComponent()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: PersonalInfoEntity.entity(), sortDescriptors: [])
    var personalInfo: FetchedResults<PersonalInfoEntity>
    
    @State public var image: Data = .init(count: 0)

    @State var medicalRecord: String = "지병에 대해 적어주세요."
    
// TODO: 년월일, 하이픈 자동입력
//    var dateformat: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "YYYY년 MM월 dd일"
//
//        return formatter
//    }
    
    var date = Date()
    
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
                        MainViewText(label: content.name,
                                     inputInfo: info.name ?? "")
                        Divider()
                        
                        MainViewText(label: content.birth,
                                     inputInfo: info.birth ?? "")
                        Divider()
                        
                        MainViewText(label: content.bloodType,
                                     inputInfo: info.bloodType ?? "")
                        Divider()
                        
                        MainViewText(label: content.contact,
                                     inputInfo: info.contact1 ?? "")
                        .padding(.bottom, 2)
                        
                        HStack {
                            Spacer()
                            Text(info.contact2 ?? "")
                        }
                        
                        Divider()
                        
                        VStack{
                            HStack {
                                Text("의료 기록")
                                Spacer()
                            }
                            
                            ScrollView(showsIndicators: false) {
                                HStack {
                                    Text(personalInfo[0].medicalRecord ?? "")
                                        .font(.system(size: 16, weight: .regular))
                                        .padding(.all, 5)
                                }
                            }
                            .frame(width: 302, height: 156, alignment: .leading)
                            .background(Rectangle()
                                .stroke(Color.gray.opacity(0.5)))
                        }
                        
                    }
                    .padding(.horizontal, 24)

                }
            }
            .frame(width: 350, height: 630)
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.mainWhite)
                .shadow(color: Color.gray.opacity(0.5), radius: 20, x: 6, y: 6))
        }
    }
}
    
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct MainViewText: View {
    
    let label: String
    let inputInfo: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(inputInfo)
        }
    }
}
