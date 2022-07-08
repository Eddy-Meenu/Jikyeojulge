//
//  ContentView.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        NavigationView {
            MedicineRecordView()
        }

    }

    private func addItem() {
        withAnimation {
            let Info = PersonalInfoEntity(context: viewContext)
            Info.id = UUID()
            Info.name = ""
            Info.birth = ""
            Info.bloodType = ""
            Info.contact1 = ""
            Info.contact2 = ""

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

