//
//  ContentView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/09.
//

import SwiftUI

struct ContentView: View {
    // 고정 팀
    @FetchRequest(
        entity: Team.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Team.touch, ascending: true)],
        predicate: NSPredicate(format: "pinned == true")
    ) var pinnedTeam: FetchedResults<Team>
    
    // 모든 팀
    @FetchRequest(
        entity: Team.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Team.touch, ascending: true)]
    ) var teams: FetchedResults<Team>
    
    // 선택된 팀
    @State private var selected: Team?
    
    // SideBar, Detail 보이기 설정
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // MARK: Side Bar
            TeamView(pinned: pinnedTeam.map({ $0 }), teams: teams.map({ $0 }), selected: $selected)
            
            //: Side Bar
        } detail: {
            // MARK: Detail
            // 팀 선택된 경우
            if let selected = selected {
                NavigationStack {
                    ConventionView(selectedTeam: $selected)
                }
                
            } else {
                // 팀 선택이 없는 경우 (= 팀이 없는 경우)
                VStack(spacing: 16) {
                    Image(systemName: "tray")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                    Text("not_selected")
                    
                    Button("add_team") {
                        let generator = DefaultDataGenerator(managedObjectContext)
                        let fields = generator.generateFields()
                        let team = generator.generateTeam(fields)
                        
                        self.selected = team
                        
                        PersistenceController.shared.saveContext()
                    }
                }
            }
            //: - Detail
        }
        .onLoad {
            // 최초 로드 시 첫번째 팀 선택
            if let team = teams.first {
                self.selected = team
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
