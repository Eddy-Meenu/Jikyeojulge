//
//  MedicineSearchView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI
import UIKit

struct MedicineSearchView: View {
    
//    var medicine: Medicine

    @Environment(\.managedObjectContext) private var viewContext

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var networkManager = NetworkManager()
    @State private var searchKeyword = ""

//    @State var date: Date
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.mainBlue
                    .ignoresSafeArea()
                List(networkManager.medicineList, id: \.itemSeq) { medicine in
                    Button(action: {
                        saveMedicine(medicine: medicine)
                    }, label: {
                        MedicineInfo(medicine: medicine)
                    })
                    .foregroundColor(.black)
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableView.appearance().contentInset.top = -20
                }
            }
            .navigationTitle("약품 검색")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchKeyword, placement: .navigationBarDrawer(displayMode: .always))
            .disableAutocorrection(true)
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
//                        saveMedicine(medicine: networkManager.medicineList[0])

                    }, label: {
                        Text("확인")
                    })
                })
            }
        }
    }
    func saveMedicine(medicine: Medicine) {
        let add = MedicineDataEntity(context: viewContext)
        add.itemName = medicine.itemName
        add.itemSeq = medicine.itemSeq
        add.itemImage = medicine.itemImage
        add.date = Date()
        add.efcyQesitm = medicine.efcyQesitm
        add.intrcQesitm = medicine.intrcQesitm
        add.seQesitm = medicine.seQesitm
        
        try! self.viewContext.save()
    }
}

struct MedicineSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineSearchView()
    }
}
