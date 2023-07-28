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
    @Binding var outputMessage: [String]

    
    @State private var isWindowOpen = false
    
    var body: some View {
        HStack{
            Image("tray_icon")
                .frame(width:24, height:24)
                .onTapGesture {
                    isWindowOpen.toggle()
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
                            .foregroundColor(Color.black)
                    }
                }
            } label: {
                Text(selectedTeam?.wrappedName ?? "팀 선택")
            }
            
            .frame(width:100, alignment: .trailing)
           
            
        }//Hstack
        .frame(width: 316, height: 24)
        .padding(EdgeInsets(top: 9, leading: 9, bottom: 15, trailing: 9))
        .sheet(isPresented: $isWindowOpen){
            ContentView()
                .frame(width: 850, height: 518)
        }
    }
}




