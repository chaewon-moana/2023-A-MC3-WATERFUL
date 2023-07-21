//
//  ContentView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI

struct ContentView: View {
    @State var teams: [Team] = []
    
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var selected: Team?
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // MARK: Side Bar
            TeamView(teams: teams.map({ $0 }), selected: $selected)
            
        } detail: {
            // MARK: Detail
            if selected != nil {
                NavigationStack {
                    ConventionView(selected: $selected)
                }
                
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "tray")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                    Text("not_selected")
                    
                    Button("add_team") {
                        let generator = DefaultDataGenerator(managedObjectContext)
                        let fields = generator.generateFields()
                        let team = generator.generateTeam(fields)
                        
                        self.selected = team
                        
                        PersistenceController.shared.saveContext()
                        
                        self.teams = PersistenceController.shared.readTeam()
                    }
                }
            }
            //: - Detail
        }
        .onLoad {
            teams = PersistenceController.shared.readTeam()
            
            if let team = teams.first {
                self.selected = team
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
