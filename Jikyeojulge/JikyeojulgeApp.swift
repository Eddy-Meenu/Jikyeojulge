//
//  JikyeojulgeApp.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI

@main
struct JikyeojulgeApp: App {

    @AppStorage("initSetting") var initSetting: Bool = UserDefaults.standard.bool(forKey: "initSetting")
    
    let persistenceController = PersistenceController.shared

    @State var selection = 1
    
    var body: some Scene {
        WindowGroup {
            
            if initSetting {
                
                NavigationView{
                    TabView(selection: $selection) {
                        MainView()
                            .tabItem{
                                Image(systemName: "house")
                                Text("기본정보")
                            }
                            .tag(1)
                        MedicineRecordView()
                            .tabItem{
                                Image(systemName: "pills.fill")
                                Text("약 정보")
                            }
                            .tag(2)
                        SettingView()
                            .tabItem{
                                Image(systemName: "gearshape.2.fill")
                                Text("환경설정")
                            }
                            .tag(3)
                    }
                    .navigationTitle(navigationTitle2(selection: selection))
                    .navigationBarTitleDisplayMode(.inline)
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

                
//                TabView {
//                    NavigationView {
//                        MainView()
//                            .navigationBarTitle("기본 정보")
//                            .navigationBarTitleDisplayMode(.inline)
//                    }
//                    .tabItem{
//                        Image(systemName: "house")
//                        Text("기본정보")
//                    }
//                    NavigationView {
//                        MedicineRecordView()
//                            .navigationBarTitle("진단서 및 복용약")
//                            .navigationBarTitleDisplayMode(.inline)
//                    }
//                    .tabItem{
//                        Image(systemName: "pills.fill")
//                        Text("약 정보")
//                    }
//                    NavigationView {
//                        SettingView()
//                            .navigationBarTitle("환경 설정")
//                            .navigationBarTitleDisplayMode(.inline)
//                    }
//                    .tabItem{
//                        Image(systemName: "gearshape.2.fill")
//                        Text("환경설정")
//                    }
//                }
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                InitSettingView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
    
    func navigationTitle2(selection: Int) -> String {
        if selection == 1 {
            return "기본정보"
        } else if selection == 2 {
            return "진단서 및 복용약"
        } else if selection == 3 {
            return "환경설정"
        } else {
            return "error"
        }
    }
    func navigationTitle(selection: Int) -> String {
        switch selection {
        case 1:
            return "기본 정보"
        case 2:
            return "진단서 및 복용약"
        case 3:
            return "환경설정"
        default:
            return "Error"
        }
    }}
