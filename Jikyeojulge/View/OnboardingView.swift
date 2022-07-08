//
//  OnboardingView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct OnboardingView: View {

    let content = OnboardingComponent()
    
    var body: some View {

        TabView {
            ForEach(0..<6) { num in
                OnboardingPage(title: content.title[num],
                               description: content.description[num],
                               imageName: content.imageName[num])
            }
        }.tabViewStyle(PageTabViewStyle())
    }
}

struct OnboardingPage: View {

    let title: String
    let description: String
    let imageName: String
    
    var content = 0
    
    var body: some View {
     
        VStack {
            Text(title)
                .font(.title)
            Text(description)
                .font(.title3)
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 541)
        }
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
