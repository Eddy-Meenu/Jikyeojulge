//
//  DeveloperInfoView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/06.
//

import SwiftUI

struct DeveloperInfoView: View {
    var body: some View {
        ZStack {
            Color.mainBlue
                .ignoresSafeArea()
            VStack {
                List {
                    DeveloperLink(urlLink: "https://github.com/JUNY0110",
                                  developerName: "Eddy")
                    DeveloperLink(urlLink: "https://github.com/taek0622",
                                  developerName: "Meenu")
                }
            }
        }
    }
}

struct DeveloperInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeveloperInfoView()
    }
}
