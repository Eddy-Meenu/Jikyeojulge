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
                List{
                    Link(destination: URL(string: "https://github.com/JUNY0110")!){
                        VStack(alignment: .leading) {
                            Text("Eddy")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("https://github.com/JUNY0110")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.mainBtnBlue)
                        }
                    }
                    .padding(.horizontal, 20)
                    Link(destination: URL(string: "https://github.com/JUNY0110")!){
                        VStack(alignment: .leading) {
                            Text("Meenu")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.black)
                            
                            Text("https://github.com/taek0622")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.mainBtnBlue)
                        }
                    }
                    .padding(.horizontal, 20)
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
