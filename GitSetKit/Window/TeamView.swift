//
//  TeamView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI

struct TeamCell: View {
    var team: Team
    
    var body: some View {
        VStack {
            Text(team.name ?? "")
            
            if let desc = team.desc {
                Text(desc)
                    .font(.caption)
            }
        }
    }
}

struct TeamView: View {
    @Binding var teams: [Team]
    @Binding var selected: Team?
    
    var body: some View {
        List(selection: $selected) {
            Section("section_team") {
                ForEach(teams) { team in
                    NavigationLink(value: team) {
                        TeamCell(team: team)
                    }
                }
            }
            
        }
        .listStyle(.sidebar)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
