//
//  MedicineSearchView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI
import UIKit

struct MedicineSearchView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var networkManager = NetworkManager()
    @State private var searchKeyword = ""
    
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
                    }, label: {
                        Text("확인")
                    })
                })
            }
        }
    }
    
    func removeHTMLTag(contents: String?) -> String {
        return contents?.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil) ?? "등록된 정보가 없습니다"
    }
    
    func saveMedicine(medicine: Medicine) {
        let add = MedicineDataEntity(context: viewContext)
        add.itemName = removeHTMLTag(contents: medicine.itemName)
        add.itemSeq = removeHTMLTag(contents: medicine.itemSeq)
        add.itemImage = medicine.itemImage
        add.date = Date()
        add.efcyQesitm = removeHTMLTag(contents: medicine.efcyQesitm)
        add.intrcQesitm = removeHTMLTag(contents: medicine.intrcQesitm)
        add.seQesitm = removeHTMLTag(contents: medicine.seQesitm)
        
        try! self.viewContext.save()
    }
}

struct MedicineSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineSearchView()
    }
}
