//
//  ContentView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI

struct ContentView: View {
    
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    @State private var teams: [Team] = []
    @State private var selected: Team?
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // MARK: Side Bar
            TeamView(teams: $teams, selected: $selected) 
            
        } detail: {
            // MARK: Detail
            if let selected = selected {
                ConventionView(selected: $selected)
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "tray")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                    Text("not_selected")
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
