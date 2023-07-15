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
        HStack {
            Text(team.name ?? "no content")
                .font(.body)
            
            Spacer()
            
            Image(systemName: "pin.fill")
        }
    }
}

struct TeamView: View {
    
    var teams: [Team]
    
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
    static func getTeams() -> [Team] {
        var teams: [Team] = Array()
        
        for i in 0..<5 {
            let team = Team(context: PersistenceController.shared.container.viewContext)
            team.id = UUID()
            team.name = "🍪 team \(i)"
            team.desc = "This is an example of team \(i)"
            teams.append(team)
        }
        
        return teams
    }
    
    static var previews: some View {
        NavigationSplitView {
            TeamView(teams: getTeams(), selected: .constant(nil))
        } detail: {
            Text("Detail")
        }

    }
}
