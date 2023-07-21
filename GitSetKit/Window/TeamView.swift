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
    
    @StateObject var team: Team
    
    @State private var editing: Bool = false
    @State private var newName: String = ""
    
    @FocusState private var field: Field?
    
    var body: some View {
        if editing {
            TextField("", text: $newName)
                .focused($field, equals: .edit)
                .onSubmit {
                    PersistenceController.shared.updateTeam(team: team, name: newName.isEmpty ? (team.name ?? "Unknown") : newName)
                    
                    editing = false
                }
        } else {
            HStack {
                Text(team.name ?? "Unknown")
                    .font(.body)
                
                Spacer()
                
                if team.pinned {
                    Image(systemName: "pin.fill")
                }
            }
            .contextMenu {
                // MARK: Pin Button
                if team.pinned {
                    Button(role: .none) {
                        PersistenceController.shared.updateTeam(team: team, pinned: false)
                        
                    } label: {
                        Label("unpin", systemImage: "pin.fill")
                    }
                } else {
                    Button(role: .none) {
                        PersistenceController.shared.updateTeam(team: team, pinned: true)
                        
                    } label: {
                        Label("pin", systemImage: "pin")
                    }
                }
                //: Edit Button
                
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
                    PersistenceController.shared.deleteTeam(team)
                    
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
    
    var pinned: [Team]
    var teams: [Team]
    
    @Binding var selected: Team?
    
    @FocusState private var editState: Team?
    
    var body: some View {
        List(selection: $selected) {
            Section("section_pinned") {
                ForEach(pinned) { team in
                    NavigationLink(value: team) {
                        TeamCell(team: team)
                    }
                }
            }
            
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
//: - TeamView
