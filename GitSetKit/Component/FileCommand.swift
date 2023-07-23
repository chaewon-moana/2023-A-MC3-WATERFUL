//
//  FileCommand.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/23.
//

import SwiftUI

struct FileCommand: View {
    @Environment(\.openWindow) var openWindow
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        // New Project
        Button("command_file_new_team") {
            let generator = DefaultDataGenerator(managedObjectContext)
            let fields = generator.generateFields()
            let _ = generator.generateTeam(fields)
            
            PersistenceController.shared.saveContext()
        }
        .keyboardShortcut("n")
        
        Divider()
        
        // Import Team
        Button("command_file_import") {
            // TODO: Import Team
        }
        .keyboardShortcut("i")
        
        // Export Team
        Button("command_file_export") {
            // TODO: Export Team
        }
        .keyboardShortcut("e")
    }
}
