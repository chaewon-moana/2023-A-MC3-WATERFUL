//
//  TrayView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/15.
//

import Foundation
import SwiftUI
import CoreData
//import AppKit



struct TrayView: View {
    @FetchRequest(
        entity: Team.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Team.name, ascending: true)
        ]
    ) var teams: FetchedResults<Team>
    
    @StateObject var teamVM: TeamViewModel = TeamViewModel ()
    
    //dummy data
    @State private var teamNames = ["team1", "team2", "team3", "team4"]
    
    
    
    
    let SourcePro = "SourceCodePro-Light"
    
    @State private var selectedTeamIndex = 0
    @State private var gitCommitOn = true
    @State private var date = Date()
    @State private var commitMessage: String = "Git commit copied check"

    
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width:344,height:390)
            
            VStack{
                HStack{
                    //로고 변경해야함
                    Image("GitSetKitLogo")
                        .frame(width:24, height:24)
                    
                    Text("GitSetKit")
                        .foregroundColor(.black)
                    
                    
                    Spacer()
                    
                    Menu{
                        ForEach(0..<teamNames.count) { index in
                            Button(action: {
                                print("팀선택됨") //선택된 팀으로 이동 + 선택다시 되도록
                                selectedTeamIndex = index
                            }){
                                Text(teamNames[index])
                            }
                        }
                    } label: {
                        Text(teamNames[selectedTeamIndex]) //coredata에서 선택된 거 받아오기
                            .foregroundColor(.black)
                    }
                    .frame(width:100)
                    .padding(EdgeInsets(top: 0, leading: 90, bottom: 0, trailing: 0))
                    
                }
                .frame(width: 330)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                
                
                VStack{
                    Text("미리보기")
                        .frame(width: 344, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(size:16))
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(red: 50/255, green: 50/255, blue: 50/255))
                            .frame(width: 320, height: 120)
                        
                        VStack{
                            VStack{
                                if gitCommitOn {
                                    Text("git commit -m : ")
                                        .font(.custom("SourceCodePro-Light", size: 15))
                                        .padding()
                                    
                                }
                                //data에서 작업 받아와야함
                                
                            }
                            .frame(width: 320, height: 100, alignment: .topLeading)
                            //HStack 고정되어 있어야함
                            
                            HStack{
                                Toggle(isOn: $gitCommitOn){
                                    Text(" Git 명령어 포함")
                                }
                                .toggleStyle(.checkbox)
                                .offset(x: -80,y:15)
                                
                                
                               
                                Button(action: {
                                    copyToPaste(text: commitMessage)
                                    print("복사됨")
                                }) {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.gray)
                                        Image(systemName: "doc.on.doc")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }
                                
                                }
                                .buttonStyle(.plain)
                                .offset(x: 70, y: 10)
                            }
                            .frame(width: 300, height: 30)
                            .offset(x:0, y: -30)
                            
                        }
                        .frame(width: 320, height: 120)
                        
                    }
                    .frame(width: 320, height: 120)
                    
                }
                
                
                FieldView()
                
                HStack{
                    Button("\(Image(systemName:"macwindow")) 앱 열기") {
                        print("앱 열기 버튼")
                        //NSWindow로 새 창 띄우기
                    }
                    
                    Spacer()
                    
                    Button("이전"){
                        print("이전 화면으로 넘어가기")
                    }
                    
                    Button("다음"){
                        print("다음 화면으로 넘어가기")
                    }
                   
                }
                .frame(width: 320)
                .tint(.blue)
                
            }
            
        }
        
    }
    
    
    
    //git commit message copied function
    func copyToPaste(text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
    
    
    
    
}

struct TrayView_Previews: PreviewProvider {
    static var previews: some View {
        TrayView()
    }
}
