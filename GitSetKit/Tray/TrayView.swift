//
//  TrayView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/15.
//

import Foundation
import SwiftUI
import CoreData
import WrappingHStack
import AppKit


struct TrayView: View {
    
    @FetchRequest(
        entity: Team.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Team.name, ascending: true)
        ]
    ) var teams: FetchedResults<Team>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    let shared = PersistenceController.shared
     
    
    @State private var teamNames: [Team] = []
    @State private var selectedField: [Field] = []
    @State private var selectedTeam: Team? = nil
    
    @State private var selectedTeamIndex = 0
    @State private var gitCommitOn = true
    @State private var commitMessage: String = "git commit -m \""
    @State private var selectedBlock = Field()
    
    @State private var outputMessage: [Any] = []
    @State private var inputText: String = ""
    
    
    
    var body: some View {
        ZStack{
            //glassmorphism 적용
            RoundedRectangle(cornerRadius: 20)
                .ignoresSafeArea()
                .frame(width:344,height:390)
                .opacity(0.3)
            
            VStack{
                
                TeamSelectedView(teamNames: $teamNames, selectedTeam: $selectedTeam)
                
                VStack{
                    Text("미리보기")
                        .frame(width: 344, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(size:16))
                        .padding(.leading, 24)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(red: 50/255, green: 50/255, blue: 50/255))
                            .frame(width: 320, height: 120)
                        
                        VStack{
                            ScrollView {
                              //if-else //field 값 workBlocks에 담아오고 입력된 값 out에 저장, 기본 textplaceholder 로 바꾸면 될듯
                                    WrappingHStack(selectedField, id: \.self, alignment: .leading, spacing: .constant(4), lineSpacing: 8) { block in
                                        
                                        //Fieldtype받아서 각자 View로 이동,,,
                                        
//                                        if block == commitMessage {
//                                            if gitCommitOn {
//                                                Text(commitMessage)
//                                                    .font(.custom("SourceCodePro-Light", size: 15))
//                                                    .foregroundColor(.white)
//                                            }
//                                        } else {
                                            Button(action: {
                                                selectedBlock = block
                                                print(selectedBlock)
                                            }, label: {
                                                Text("   \(selectedBlock.wrappedName)   ")
                                            })
                                            .buttonStyle(.plain)
                                            .frame(height: 18)
                                            .background(Color.green)
                                            .cornerRadius(4)
                                        //}
                                        
                                    } //wrappingHStack
                                    .padding()
                                    .foregroundColor(.black)
                                    
                                
                            }//scrollView
                            .frame(width: 320, height: 100, alignment: .topLeading)
                            
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
                
                FieldView(selectedTeam: $selectedTeam, outputMessage: $outputMessage)
                    .frame(width: 320, height: 100)
                    .padding()
   
                    HStack{
                        
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
        .onAppear{
            
//            shared.createTeam(emoticon: "👍", name: "team5", pinned: false, touch: Date())
//            shared.createTeam(emoticon: "👍", name: "team7", pinned: false, touch: Date())
//
//            let opt1 = shared.createOption(value: "feat", shortDesc: "기능추가", detailDesc: "코드 기능추가")
//            let opt2 = shared.createOption(value: "fix", shortDesc: "수정", detailDesc: "코드수정")
//            let opt3 = shared.createOption(value: "Docs", shortDesc: "문서수정", detailDesc: "문서수정수정")
//            let field1 = shared.createField(name: "작업", type: 2, options: [opt1, opt2, opt3])
//            let field2 = shared.createField(name: "날짜", type: 4)
//            let field3 = shared.createField(name: ":", type: 1)
//            let field4 = shared.createField(name: "수정사항", type: 3)
//
            teamNames = shared.readTeam()
//
//
//
//
          //shared.updateTeam(team: teamNames[0], emoticon: "🌻", name: "team12", pinned: false, touch: Date(), fields: [field1, field2, field3, field4])
           
            print("\(teamNames.count) check")
            teamNames = shared.readTeam()
            selectedField = shared.readField(teamNames[0])
            //print(selectedField)
        
        }
        
        
    }
    
    
    
    //git commit message copied function
    func copyToPaste(text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
    
}



