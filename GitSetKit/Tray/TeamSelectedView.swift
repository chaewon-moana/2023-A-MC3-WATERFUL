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
    
    @State private var teamName = ["team1", "team2", "team3", "team4"]
    @State private var selectedTeamIndex = 0
    @State private var isWindow = false
    
    @Binding var teamNames: [Team]
    @State var selectedTeam: Team?
   
    let shared = PersistenceController.shared
    
    var body: some View {
        HStack{
            //로고 변경해야함
            
            Image(systemName: "pencil.circle.fill")
                .frame(width:24, height:24)
                .onTapGesture {
                    isWindow = true
                }
            
            Text("GitSetKit")
                .foregroundColor(.black)
            
            
            Spacer()
            
            Menu{
                ForEach(0..<teamName.count) { index in
                    Button(action: {
                        print("팀선택됨") //선택된 팀으로 이동 + 선택다시 되도록
                        selectedTeamIndex = index
                    }){
                        Text(teamName[index])
                    }
                }
            } label: {
                Text(teamName[selectedTeamIndex]) //coredata에서 선택된 거 받아오기
                    .foregroundColor(.black)
            }

            .frame(width:100)
            .padding(EdgeInsets(top: 0, leading: 90, bottom: 0, trailing: 0))
            
            
        }
 
        
        .frame(width: 330)
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
        
    }
    
    
    
}




