//
//  MedicineRecordView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

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
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBlue
                .ignoresSafeArea()
            
            VStack {
                DateSearchBar()
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                
                List(networkManager.medicineList, id: \.itemSeq) { medicine in
                    NavigationLink(destination: {
                        MedicineDetailView(medicine: medicine)
                    }, label: {
                        MedicineInfo(medicine: medicine)
                    })
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
}

struct MedicineRecordView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineRecordView()
    }
}
