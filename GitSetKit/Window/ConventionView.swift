//
//  ConventionView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI
import WrappingHStack

fileprivate struct TemplateCell: View {
    var field: Field
    
    var body: some View {
        Text(field.fieldName ?? "")
    }
}

fileprivate struct TemplateView: View {
    var fields: [Field]
    
    var body: some View {
        WrappingHStack {
            Text("git commit -m \"")
            Text("\"")
        }
    }
}

struct ConventionView: View {
    @Binding var selected: Team!
    
    
    var body: some View {
        LazyVStack {
            HStack {
                Text("convention_section_template")
                    .font(.title3.bold())
                Spacer()
            }
        }
        .padding()
        .navigationTitle(Text("app_name"))
    }
}

struct ConventionView_Previews: PreviewProvider {
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
            TeamView(teams: getTeams(), selected: .constant(getTeams()[0]))
        } detail: {
            NavigationStack {
                ConventionView(selected: .constant(getTeams()[0]))
            }
        }
    }
}
