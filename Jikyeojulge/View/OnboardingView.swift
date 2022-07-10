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
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            TabView {
                ForEach(0..<5) { num in
                    OnboardingPage(title: content.title[num],
                                   description: content.description[num],
                                   imageName: content.imageName[num])
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .onAppear() {
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.widgetBlue)
                UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
            }
        }
    }
}

struct OnboardingPage: View {

    let title: String
    let description: String
    let imageName: String
        
    var body: some View {

            VStack {
                Text(title)
                    .font(.system(size: 22, weight: .bold))
                    
                Text(description)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 541)
                Spacer()
            }
            .padding(.horizontal, 24)
        }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
