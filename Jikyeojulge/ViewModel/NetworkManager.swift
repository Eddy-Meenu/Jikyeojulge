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
    
    let serviceKey = "5HtxWM9+fExd03260y2ei9X4a4e9UwwI5vbxKNtkVT1YrNGfNrapFTrlqApqhO1rX9LcaHYXEeT8yR9MCyRhnw=="
    let type = "json"
    
    func getData() {
        var urlComponents = URLComponents(string: urlString)
        var components = urlComponents
        let serviceKeyQuery = URLQueryItem(name: "serviceKey", value: serviceKey)
        let typeQuery = URLQueryItem(name: "type", value: type)
        urlComponents?.queryItems = [serviceKeyQuery, typeQuery]
        components?.percentEncodedQuery = urlComponents?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = URL(string: (components?.string)!) else {
            return
        }
        
        let requestURL = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requestURL) { data, _, _ in
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MedicineJSON.self, from: data)
                DispatchQueue.main.async {
                    self.medicineList = result.body?.items ?? [Medicine]()
                }
            } catch {
                print("\(error.localizedDescription)\n\(error)")
            }
        }.resume()
    }
}
