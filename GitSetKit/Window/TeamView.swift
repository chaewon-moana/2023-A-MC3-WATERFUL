//
//  TeamView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI


struct TeamCell: View {
    enum Field {
        case edit
    }
    
    @ObservedObject var team: Team
    @StateObject var teamVM: TeamViewModel
    
    @State private var editing: Bool = false
    @State private var newName: String = ""
    
    @FocusState private var field: Field?
    
    var body: some View {
        if editing {
            TextField("", text: $newName)
                .focused($field, equals: .edit)
                .onSubmit {
                    teamVM.clearStates()
                    team.name = newName.isEmpty ? (team.name ?? "no name") : newName
                    teamVM.name = team.name ?? "no name"
                    teamVM.desc = team.desc ?? ""
                    teamVM.template = team.template ?? ""
                    teamVM.updateTeam(team: team)
                    teamVM.clearStates()
                    
                    editing = false
                }
        } else {
            HStack {
                Text(team.name ?? "no content")
                    .font(.body)
                
                Spacer()
                
                Image(systemName: "pin.fill")
            }
            .contextMenu {
                // MARK: Edit Button
                Button(role: .none) {
                    editing = true
                    newName = team.name ?? ""
                    field = .edit
                } label: {
                    Label("edit", systemImage: "pencil")
                }
                //: Edit Button
                
                // MARK: Delete Button
                Button(role: .destructive) {
                    teamVM.deleteTeam(team: team)
                    
                } label: {
                    Label("delete", systemImage: "trash.fill")
                }
                //: Delete Button
                
            }
        }
    }
}

// MARK: - TeamView
struct TeamView: View {
    
    var teams: [Team]
    
    @Binding var selected: Team?
    @StateObject var teamVM: TeamViewModel
    
    @FocusState private var editState: Team?
    
    var body: some View {
        List(selection: $selected) {
            Section("section_team") {
                ForEach(teamVM.teams) { team in
                    NavigationLink(value: team) {
                        TeamCell(team: team, teamVM: teamVM)
                    }
                }
            }
            
        }
        .listStyle(.sidebar)
        
    }
}
//: - TeamView


// MARK: - Preview
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
            TeamView(teams: getTeams(), selected: .constant(nil), teamVM: TeamViewModel())
        } detail: {
            Text("Detail")
        }
        
    }
}
//: - Preview
