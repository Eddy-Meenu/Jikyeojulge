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

    var body: some Scene {
        WindowGroup {
            NavigationView{
                if initSetting {
                    MainView()
                } else {
                    InitSettingView()
                }
            }
            .navigationBarHidden(true)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
