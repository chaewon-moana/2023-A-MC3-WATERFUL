//
//  ContentView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI

struct ContentView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    @StateObject var teamVM: TeamViewModel = TeamViewModel()
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // MARK: - Side Bar
            //            TeamView(teams: $teams, selected: $selected)
            ForEach(teamVM.teams) { team in
                HStack {
                    Text("\(team.name ?? "Unknown Team")")
                    Text("\(team.desc ?? "Unknown Desc")")
                }
                .onTapGesture {
                    teamVM.deleteTeam(team: team)
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
        } detail: {
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
