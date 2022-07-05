//
//  MedicineRecordView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI
import UIKit

struct MedicineRecordView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var isShowingSheet = false
    @State private var isShowingFullScreen = false
    
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
        ZStack(alignment: .top) {
            Color.mainBlue
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(height: 30)
                List(networkManager.medicineList, id: \.itemSeq) { medicine in
                    NavigationLink(destination: {
                        MedicineDetailView(medicine: medicine)
                    }, label: {
                        MedicineInfo(medicine: medicine)
                    })
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.clear
    //                UITableView.appearance().contentInset.top = -20
                    networkManager.getData(itemName: "", itemSeq: "")
                }
            }
            
            if isShowingStartDateSelector || isShowingEndDateSelector {
                Color.black.opacity(0.01)
                    .onTapGesture {
                        isShowingStartDateSelector = false
                        isShowingEndDateSelector = false
                    }
            }
            
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
                    
                    Text("~")
                    
                    Text("\(endDate, formatter: dateformat)")
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.lightGray))
                        .onTapGesture {
                            isShowingStartDateSelector = false
                            isShowingEndDateSelector.toggle()
                        }
                    
                    Button(action: {
                        
                    }, label: {
                        Text("확인")
                            .foregroundColor(Color.white)
                    })
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.subBtnBlue))
                }
                .padding(.bottom, 10)
                .background(Color.mainBlueGeneric)
                .overlay(
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(height: 360)
                        if isShowingStartDateSelector {
                            HStack {
                                DatePicker("시작 날짜", selection: $startDate, in:...Date(), displayedComponents: .date)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.98)).shadow(color: Color.black.opacity(0.16), radius: 30, x: 4, y: 4))
                                    .frame(width: UIScreen.main.bounds.width * 0.7)
                                Spacer()
                            }
                        }
                        if isShowingEndDateSelector {
                            HStack {
                                Spacer()
                                DatePicker("끝 날짜", selection: $endDate, in:...Date(), displayedComponents: .date)
                                    .datePickerStyle(GraphicalDatePickerStyle())
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.98)).shadow(color: Color.black.opacity(0.16), radius: 30, x: 4, y: 4))
                                    .frame(width: UIScreen.main.bounds.width * 0.7)
                            }
                        }
                    }
                )
            }
                    .padding(.horizontal, 16)
                    .padding(.top, 15)
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
}

struct MedicineRecordView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineRecordView()
    }
}
