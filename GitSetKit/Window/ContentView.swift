//
//  ContentView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(
        entity: Team.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Team.name, ascending: true)
        ]
    ) var teams: FetchedResults<Team>
    
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    @State private var selected: Team?
    
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
                }
            }
            
            Button("Add Test") {
                
            }
            //: - Detail
        }
        .frame(minWidth: 720, maxHeight: 640)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
