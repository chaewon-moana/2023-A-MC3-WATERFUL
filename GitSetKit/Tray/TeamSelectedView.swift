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
    @State var selectTeam: Team = Team()
    
    @Binding var teamNames: [Team]
   // @Binding var selectedTeam: Team!
   
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
            
            Menu{
                ForEach(0..<teamNames.count) { index in
                    Button(action: {
                        selectedTeamIndex = teamNames[index].name ?? "team"
                        selectTeam = teamNames[index]
                        print("\(selectedTeamIndex)-") //선택된 팀으로 이동 + 선택다시 되도록
                    }){
                        Text(teamNames[index].name ?? " ")
                    }
                }
            } label: {
                Text("\(selectedTeamIndex) ") //coredata에서 선택된 거 받아오기
                    .foregroundColor(.black)
            }
            .frame(width:100)
            .padding(EdgeInsets(top: 0, leading: 90, bottom: 0, trailing: 0))
  
        }//Hstack -> windowView 열리게 
        .frame(width: 330)
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        
    }
    
    
    
}




