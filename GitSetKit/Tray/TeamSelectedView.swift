//
//  TeamSelectedView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/24.
//

import Foundation
import SwiftUI
import CoreData

struct TeamSelectedView: View {
    @State var selectedTeamIndex: String = ""
    @State private var isWindow = false
    
    @Binding var teamNames: [Team]
    @Binding var selectedTeam: Team?
    
    let shared = PersistenceController.shared
    
    var body: some View {
        HStack{
            //로고 변경해야함
            Image(systemName: "GitSetKitLogo")
                .frame(width:24, height:24)
                .onTapGesture {
                    isWindow = true
                }
            
            Text("GitSetKit")
                .foregroundColor(.black)
            
            Spacer()
            
            Menu {
                ForEach(teamNames, id: \.self) { team in
                    Button {
                        selectedTeam = team
                    } label: {
                        Text(team.wrappedName)
                    }
                }
            } label: {
                Text(selectedTeam?.wrappedName ?? "팀 선택")
            }
            .frame(width:100)
            .padding(EdgeInsets(top: 0, leading: 90, bottom: 0, trailing: 0))
        }//Hstack
        .frame(width: 330)
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
}




