//
//  GitSetKitApp.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI

@main
struct GitSetKitApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        // MARK: - WindowView
        WindowGroup(id: WindowId.window.rawValue) {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                FileCommand()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
        //: - WindowView
        
        // MARK: - TrayView
        MenuBarExtra {
            TrayView()
        } label: {
            Image(systemName: "arrow.branch")
        }
        .menuBarExtraStyle(.window)
        //: - TrayView
    }
    
    enum WindowId: String {
        case window
    }
}
