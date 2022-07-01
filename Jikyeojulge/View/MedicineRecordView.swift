//
//  MedicineRecordView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct MedicineInfo: View {
    var medicine: Medicine

    var body: some View {
        HStack {
            Image(medicine.itemImage ?? "DefaultMedicine")
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .foregroundColor(Color.red)
            
            Spacer()
                .frame(width: 16)
            
            VStack(alignment: .leading, spacing: 15) {
                Text(medicine.itemName ?? "약 이름")
                    .font(.system(size: 16, weight: .bold))
                
                Text(medicine.efcyQesitm ?? "약 효능")
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
    }
}

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
    @State private var medicineList = [Medicine]()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mainBlue
                .ignoresSafeArea()
            
            VStack {
                DateSearchBar()
                    .padding(.horizontal, 20)
                    .padding(.top, 15)
                Button(action: {
                    networkManager.getData()
                    print(medicineList)
                }, label: {
                    Text("클릭해줭")
                })
                
                List(networkManager.medicineList, id: \.itemSeq) { medicine in
                    NavigationLink(destination: {
                        MedicineDetailView()
                    }, label: {
                        MedicineInfo(medicine: medicine)
                    })
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableView.appearance().contentInset.top = -20
                }
                
//                List {
//                    NavigationLink(destination: {
//                        MedicineDetailView()
//                    }, label: {
//                        MedicineInfo()
//                    })
//                    NavigationLink(destination: {
//                        MedicineDetailView()
//                    }, label: {
//                        MedicineInfo()
//                    })
//                    NavigationLink(destination: {
//                        MedicineDetailView()
//                    }, label: {
//                        MedicineInfo()
//                    })
//                }
//                .onAppear {
//                    UITableView.appearance().backgroundColor = UIColor.clear
//                    UITableView.appearance().contentInset.top = -20
//                }
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
