//
//  NetworkManager.swift
//  Jikyeojulge
//
//  Created by 김민택 on 2022/06/29.
//

import Combine
import Foundation

class NetworkManager: ObservableObject {
    @Published var medicineList = [Medicine]()
    let urlString = "http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList"
    
    let serviceKey = "5HtxWM9%2BfExd03260y2ei9X4a4e9UwwI5vbxKNtkVT1YrNGfNrapFTrlqApqhO1rX9LcaHYXEeT8yR9MCyRhnw%3D%3D"
    let type = "json"
    
    let url = "http://apis.data.go.kr/1471000/DrbEasyDrugInfoService/getDrbEasyDrugList?serviceKey=5HtxWM9%2BfExd03260y2ei9X4a4e9UwwI5vbxKNtkVT1YrNGfNrapFTrlqApqhO1rX9LcaHYXEeT8yR9MCyRhnw%3D%3D&type=json"
    
    init() {
//        var urlComponents = URLComponents(string: urlString)
//        let serviceKeyQuery = URLQueryItem(name: "serviceKey", value: serviceKey)
//        let typeQuery = URLQueryItem(name: "type", value: type)
//        urlComponents?.queryItems = [serviceKeyQuery, typeQuery]
        guard let url = URL(string: urlString) else {
            return
        }
        
        var requestURL = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MedicineModel.self, from: data)
                DispatchQueue.main.async {
                    self.medicineList = result.items ?? [Medicine]()
                }
            } catch {
                print("\(error.localizedDescription)\n\(error)")
            }
        }.resume()
    }
}
