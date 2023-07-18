//
//  TeamViewModel.swift
//  GitSetKit
//
//  Created by 송재훈 on 2023/07/14.
//

import CoreData

class TeamViewModel: ObservableObject {
    @Published var teams: [Team] = []
    
    let persistenceShare = PersistenceController.shared
    
    @Published var name: String = ""
    @Published var desc: String = ""
    @Published var template: String = ""
    
    init() {
        getAllTeams()
    }
    
    // MARK: - Function
    func getAllTeams() {
        teams = persistenceShare.teamRead()
    }
    
    func createTeam() {
        persistenceShare.teamCreate(name: name, desc: desc, template: template)
        getAllTeams()
    }
    
    func deleteTeam(team: Team) {
        persistenceShare.teamDelete(team)
        getAllTeams()
    }
    
    func updateTeam(team: Team) {
        persistenceShare.teamUpdate(team: team, name: name, desc: desc, template: template)
        getAllTeams()
    }
    
    func clearStates() {
        name = ""
        desc = ""
        template = ""
    }
}
