//
//  DeveloperLinkView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/09.
//

import SwiftUI

struct DeveloperLink: View {
    
    let urlLink: String
    let developerName: String
    
    var body: some View {
        Link(destination: URL(string: urlLink)!){
            VStack(alignment: .leading) {
                Text(developerName)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                Text(urlLink)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.mainBtnBlue)
            }
        }
        .padding(.horizontal, 20)
    }
}
