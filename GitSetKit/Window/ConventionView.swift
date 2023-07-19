//
//  ConventionView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI

struct ConventionView: View {
    @Binding var selected: Team!
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                // MARK: - Template View
                GroupBox {
                    TemplateView(fields: [])
                } label: {
                    Text("convention_section_template")
                        .font(.title3.bold())
                }
                .groupBoxStyle(TransparentGroupBox())
                .padding()
                .frame(height: proxy.size.height / 2)
                // : - Template View
                
                // MARK: - Inspector View
                GroupBox {
                    BlockSettingView()
                } label: {
                    Text("convention_section_block")
                        .font(.title3.bold())
                }
                .groupBoxStyle(TransparentGroupBox())
                .padding()
                .frame(height: proxy.size.height / 2)
                // : - Inspector View
            }
        }
        .navigationTitle(Text("app_name"))
    }
}

struct ConventionView_Previews: PreviewProvider {
    static func getTeams() -> [Team] {
        var teams: [Team] = Array()
        
        for i in 0..<5 {
            let team = Team(context: PersistenceController.shared.container.viewContext)
            team.name = "team \(i)"
            team.emoticon = "🍪"
            team.touch = Date()
            team.pinned = false
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
