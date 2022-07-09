//
//  MedicineRecordView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI
import UIKit

struct MedicineRecordSegment: View {
    var medicine: MedicineDataEntity
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: medicine.itemImage ?? "https://immeenu.com/image/defaultMedicine.png"), scale: 6.0)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .padding(.trailing, 16)
            
            VStack(alignment: .leading, spacing: 15) {
                Text(medicine.itemName ?? "등록된 정보가 없습니다")
                    .font(.system(size: 16, weight: .bold))
                
                Text(medicine.efcyQesitm ?? "등록된 정보가 없습니다")
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct MedicineRecordView: View {
    @State private var isShowingSheet = false
    @State private var isShowingFullScreen = false
    
    @FetchRequest(entity: MedicineDataEntity.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \MedicineDataEntity.itemName, ascending: true),
        NSSortDescriptor(keyPath: \MedicineDataEntity.itemSeq, ascending: false),
        NSSortDescriptor(keyPath: \MedicineDataEntity.efcyQesitm, ascending: false),
        NSSortDescriptor(keyPath: \MedicineDataEntity.intrcQesitm, ascending: false),
        NSSortDescriptor(keyPath: \MedicineDataEntity.seQesitm, ascending: false),
        NSSortDescriptor(keyPath: \MedicineDataEntity.itemImage, ascending: false),
        NSSortDescriptor(keyPath: \MedicineDataEntity.date, ascending: false)])
    var medicineData: FetchedResults<MedicineDataEntity>
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var isShowingStartDateSelector = false
    @State private var isShowingEndDateSelector = false
    
    var dateformat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY. MM. dd."
        
        return formatter
    }
    
    var body: some View {
        ZStack {
            Color.mainBlue
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("\(startDate, formatter: dateformat)")
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.lightGray))
                        .onTapGesture {
                            isShowingEndDateSelector = false
                            isShowingStartDateSelector.toggle()
                        }
                        .onAppear() {
                            startDate = medicineData.last?.date?.addingTimeInterval(-1209600) ?? Date()
                        }
                    
                    Text("~")
                    
                    Text("\(endDate, formatter: dateformat)")
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.lightGray))
                        .onTapGesture {
                            isShowingStartDateSelector = false
                            isShowingEndDateSelector.toggle()
                        }
                        .onAppear() {
                            endDate = medicineData.last?.date ?? Date()
                        }
                    
                    Button(action: {
                        
                    }, label: {
                        Text("확인")
                    })
                    .padding(7)
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.subBtnBlue))
                }
                .padding(.horizontal, 20)
                
                List {
                    ForEach(medicineData) { medicine in
                        NavigationLink(destination: {
                            MedicineDetailView(medicine: medicine)
                        }, label: {
                            MedicineRecordSegment(medicine: medicine)
                        })
                    }
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableView.appearance().contentInset.top = -20
                }
            }
            .overlay(
                VStack(alignment: .leading) {
                    if isShowingStartDateSelector {
                        HStack {
                            DatePicker("시작 날짜", selection: $startDate, in:...Date(), displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.98)).shadow(color: Color.black.opacity(0.16), radius: 30, x: 4, y: 4))
                                                                .frame(width: UIScreen.main.bounds.width * 0.7)
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 0))
                        Spacer()
                    }
                    if isShowingEndDateSelector {
                        HStack {
                            Spacer()
                            DatePicker("종료 날짜", selection: $endDate, in:...Date(), displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.98)).shadow(color: Color.black.opacity(0.16), radius: 30, x: 4, y: 4))
                                                                .frame(width: UIScreen.main.bounds.width * 0.7)
                        }
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 20))
                        Spacer()
                    }
                })
        }
        .toolbar {
            ToolbarItem(content: {
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
                        Text("직접 입력하기")
                    })
                })
                .fullScreenCover(isPresented: $isShowingFullScreen, content: {
                    MedicineSearchView()
                })
    }
}

struct MedicineRecordView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineRecordView()
    }
}
