//
//  SettingView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        NavigationView {
            List {
                Section() {
                    NavigationLink {
                        ModifyingInfoView()
                    } label: {
                        Text("개인정보 수정")
                            .font(.system(size: 15, weight: .bold))
                    }
                }
                
                Section() {
                    NavigationLink {
                        OnboardingView()
                    } label: {
                        Text("위젯 만드는 법")
                            .font(.system(size: 15, weight: .bold))
                        
                    }
                }
                
                Section() {
                    NavigationLink {
                        //개발자 정보 뷰 생성
                    } label: {
                        Text("개발자 정보")
                            .font(.system(size: 15, weight: .bold))
                    }
                    HStack {
                        Text("버전 정보")
                            .font(.system(size: 15, weight: .bold))
                        Spacer()
                        Text("최신 버전")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.secondary)
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
