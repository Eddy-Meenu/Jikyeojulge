//
//  MedicineRecordView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI
import UIKit

struct DateSearchBar: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        HStack {
            DatePicker("시작 날짜", selection: $startDate, in:...Date(), displayedComponents: .date)
                .labelsHidden()
            Text("~")
            DatePicker("끝 날짜", selection: $endDate, in:...Date(), displayedComponents: .date)
                .labelsHidden()
            Button(action: {
                
            }, label: {
                Text("확인")
                    .foregroundColor(Color.white)
            })
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).fill(Color.subBtnBlue))
        }
    }
}

struct MedicineRecordView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var isShowingSheet = false
    @State private var isShowingFullScreen = false
    
    @FetchRequest(entity: MedicineDataEntity.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \MedicineDataEntity.itemName, ascending: true),
        NSSortDescriptor(keyPath: \MedicineDataEntity.itemSeq, ascending: false),
        NSSortDescriptor(keyPath: \MedicineDataEntity.efcyQesitm, ascending: false),
        NSSortDescriptor(keyPath: \MedicineDataEntity.intrcQesitm, ascending: false),
        NSSortDescriptor(keyPath: \MedicineDataEntity.seQesitm, ascending: false),
        NSSortDescriptor(keyPath: \MedicineDataEntity.itemImage, ascending: false)])
    var medicineData: FetchedResults<MedicineDataEntity>

    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBlue
                .ignoresSafeArea()
            
            VStack {
                DateSearchBar()
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                
                List{
                    ForEach(medicineData) { medicine in
                        NavigationLink(destination: {
                            ZStack {
                                Color.mainBlue
                                    .ignoresSafeArea()
                                ScrollView {
                                    VStack(alignment: .center) {
                                        AsyncImage(url: URL(string: medicine.itemImage ?? "https://immeenu.com/image/defaultMedicine.png"), scale: 5.0)
                                            .cornerRadius(10)
                                        
                                        Spacer()
                                            .frame(height: 25)
                                        
                                        contentsProvider(contents: medicine.itemName)
                                            .font(.system(size: 20, weight: .bold))
                                    }
                                    
                                    Spacer()
                                        .frame(height: 25)
                                    
                                    VStack(alignment: .leading) {
                                        Group {
                                            Text("효능")
                                                .font(.system(size: 16, weight: .bold))
                                            
                                            contentsProvider(contents: medicine.efcyQesitm)
                                                .font(.system(size: 16))
                                            
                                            Divider()
                                                .padding(.vertical, 15)
                                        }
                                        
                                        Group {
                                            Text("상호작용")
                                                .font(.system(size: 16, weight: .bold))
                                            
                                            contentsProvider(contents: medicine.intrcQesitm)
                                                .font(.system(size: 16))
                                            
                                            Divider()
                                                .padding(.vertical, 15)
                                        }
                                        
                                        Text("부작용")
                                            .font(.system(size: 16, weight: .bold))
                                        
                                        contentsProvider(contents: medicine.seQesitm)
                                            .font(.system(size: 16))
                                    }
                                }
                                .padding(16)
                                .frame(maxHeight: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .border(.white.opacity(0.2)).cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.15), radius: 30, x: 6, y: 6))
                                .padding(20)
                            }
                            .navigationTitle("약품 정보")
                            .navigationBarTitleDisplayMode(.inline)
                        }, label: {
                            HStack {
                                
                                AsyncImage(url: URL(string: medicine.itemImage ?? "https://immeenu.com/image/defaultMedicine.png"), scale: 6.0)
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(10)
                                    .padding(.trailing, 16)

                                VStack(alignment: .leading, spacing: 15) {
                                    contentsProvider(contents: medicine.itemName)
                                        .font(.system(size: 16, weight: .bold))
                                    
                                    contentsProvider(contents: medicine.efcyQesitm)
                                        .font(.system(size: 14))
                                        .lineLimit(2)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        })
                    }
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableView.appearance().contentInset.top = -20
                    networkManager.getData(itemName: "", itemSeq: "")
                }
            }
        }
        .navigationTitle("진단서 및 복용약")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(content:  {
                Button(action: {
                    isShowingSheet = true
                }, label: {
                    Text("추가")
                })
                Divider()
            })
        }
        .confirmationDialog("동작 선택", isPresented: $isShowingSheet, actions: {
            Button(action: {
                isShowingFullScreen = true
            }, label: {
                Text("조회하여 추가하기")
            })
            Button(action: {
                
            }, label: {
                Text("사진 촬영하기")
            })
            Button(action: {
                
            }, label: {
                Text("앨범에서 선택하기")
            })
        })
        .fullScreenCover(isPresented: $isShowingFullScreen, content: {
            MedicineSearchView()
        })
    }
    func contentsProvider(contents: String?) -> some View {
        return AnyView(Text(contents?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil) ?? "등록된 정보가 없습니다"))
    }
}

struct MedicineRecordView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineRecordView()
    }
}
