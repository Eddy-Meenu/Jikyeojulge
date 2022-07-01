//
//  MedicineSearchView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct MedicineSearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var networkManager = NetworkManager()
    @State private var searchKeyword = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.mainBlue
                    .ignoresSafeArea()
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
                }
            }
            .navigationTitle("약품 검색")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchKeyword, placement: .navigationBarDrawer(displayMode: .always))
            .onSubmit(of: .search) {
                networkManager.getData(itemName: searchKeyword, itemSeq: "")
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading, content: {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("취소")
                    })
                })
                ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("확인")
                    })
                })
            }
        }
    }
}

struct MedicineSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineSearchView()
    }
}
