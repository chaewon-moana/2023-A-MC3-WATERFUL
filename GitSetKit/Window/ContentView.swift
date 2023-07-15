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
    
    @StateObject var teamVM: TeamViewModel = TeamViewModel ()
    
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
                teamVM.name = "name"
                teamVM.desc = "desc"
                teamVM.template = "teamplate"
                
                teamVM.createTeam()
                teamVM.clearStates()
            }
            //: - Side Bar
            // MARK: - Detail
            //            if let selected = selected {
            //                ConventionView(selected: $selected)
            //            } else {
            //                VStack(spacing: 16) {
            //                    Image(systemName: "tray")
            //                        .resizable()
            //                        .aspectRatio(contentMode: .fit)
            //                        .frame(width: 64, height: 64)
            //                    Text("not_selected")
            //: - Detail
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
