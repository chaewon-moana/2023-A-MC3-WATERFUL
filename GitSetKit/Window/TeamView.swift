//
//  TeamView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI


struct TeamCell: View {
    // 수정 모드에서 TextField 표시를 위한 필드
    enum Field {
        case edit
    }
    
    // 팀
    @State var team: Team
    
    // 팀 이름 수정 모드 토글
    @State private var editing: Bool = false
    // 팀 이름 수정 임시 변수
    @State private var newName: String = ""
    
    // TextField 포커스 변수
    @FocusState private var field: Field?
    
    var body: some View {
        // 팀 이름 수정 모드
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
    
    // 고정된 팀
    var pinned: [Team]
    // 모든 팀
    var teams: [Team]
    
    @Binding var selected: Team?
    
    var body: some View {
        List(selection: $selected) {
            // MARK: Pinned Team
            Section("section_pinned") {
                ForEach(pinned) { team in
                    NavigationLink(value: team) {
                        TeamCell(team: team)
                    }
                }
            }
            //: Pinned Team
            
            // MARK: All Team
            Section("section_team") {
                ForEach(teams) { team in
                    NavigationLink(value: team) {
                        TeamCell(team: team)
                    }
                }
            }
            //: All Team
            
        }
        .listStyle(.sidebar)
        
    }
}
//: - TeamView
