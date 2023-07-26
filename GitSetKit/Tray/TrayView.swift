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
    //@State var selectTeam: Team?
    @State private var selectedTeam: Team?
    @State private var selectedFields: [Field] = []
    @State private var selectedOptions: [Option] = []
    @State private var selectedField: Field?
    
    @State private var selectedFieldIndex = 0
    @State private var gitCommitOn = true
    @State private var commitMessage: String = "git commit -m \""
    
    @State var outputMessage: [Any] = []
    @State var inputText: String = ""
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width:340,height:390)
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack{
                
                TeamSelectedView(teamNames: $teamNames, selectedTeam: $selectedTeam)
                    .onChange(of: selectedTeam){ newValue in
                        selectedFields = newValue!.wrappedFields
                        selectedFieldIndex = 0
                    }
                
                VStack{
                    Text("미리보기")
                        .frame(width: 316, height: 18, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(size:16))
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(Colors.Fill.codeBG)
                            .frame(width: 316, height: 120)
                        
                        VStack{
                            ScrollView {
                                WrappingHStack(selectedFields, id: \.self, alignment: .leading, spacing: .constant(4), lineSpacing: 8) { block in
                                    
                                    if gitCommitOn && block.wrappedName == selectedFields.first?.wrappedName{
                                        Text(commitMessage)
                                            .frame(width: 120)
                                            .font(.custom("SourceCodePro-Light", size: 13))
                                            .foregroundColor(.white)
                                        
                                    }
                                    if block.type == 1 {
                                        Text(block.wrappedName)
                                            .foregroundColor(Color.white)
                                    } else {
                                        Button(action: {
                                            //입력하면 글자 바뀌도록,,,
                                        }, label: {
                                            Text("    \(block.wrappedName)    ")//기본값은 block.wrappedName -> 입력시 입력값으로 변경
                                                .foregroundColor(Color.white)
                                        })
                                        .buttonStyle(.plain)
                                        .frame(height: 18)
                                        .background(Colors.Fill.codeBlockB)
                                        .cornerRadius(4)
                                    }
                                }
                                .frame(alignment: .topLeading)
                                .padding(12)
                            }//scrollView
                            .frame(width: 316, height: 100, alignment: .center)
                            
                            HStack{
                                Toggle(isOn: $gitCommitOn){
                                    Text(" Git 명령어 포함")
                                }
                                .toggleStyle(.checkbox)
                                .offset(x: -80,y:15)
                                
                                Button(action: {
                                    copyToPaste(text: commitMessage)
                                    //마지막 Fields로 왔을 때, 활성화
                                    print("복사됨")
                                }) {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 32, height: 32)
                                            .foregroundColor(.gray)
                                        Image(systemName: "doc.on.doc")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 19, height: 18)
                                    }
                                    
                                }
                                .buttonStyle(.plain)
                                .offset(x: 70, y: 10)
                            }//HStack - copyAndPaste Button View
                            .frame(width: 316, height: 20)
                            .offset(x:0, y: -30)
                            
                        }//WorkFieldView
                    }
                    .frame(width: 316, height: 120)
                    
                }//WorkView
                .frame(width: 316, height: 146)
                
                VStack{
                    Text("작업")
                        .frame(width: 316, height: 18, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(size:16))
                    
                    FieldView(selectTeam: $selectedTeam, selectedFields: $selectedFields, selectedField: $selectedField, outputMessage: $outputMessage, selectedFieldIndex: $selectedFieldIndex, selectedOptions: $selectedOptions)
                        .onChange(of: selectedTeam){ newValue in
                            selectedFields = newValue!.wrappedFields
                        }
                        .frame(width: 316, height: 104)
                        .opacity(1)
                        .ignoresSafeArea()
                }
                .frame(width: 316, height: 130)
                
                HStack{
                    Text("\(Image(systemName: "keyboard")) [shift+방향키]로 다음으로 넘어갈 수 있어요!")
                        .foregroundColor(Colors.Text.secondary)
                        .font(.system(size: 11))
                    Spacer()
                    
                    Button("이전"){
                        print("이전 화면으로 넘어가기")
                        selectedFieldIndex -= 1
                    }
                    .background(selectedFieldIndex != 0 ? Color(red: 0, green: 122/255, blue: 1) : Color.white)
                    .disabled(selectedFieldIndex == 0)
                    
                    
                    Button("다음"){
                        print("다음 화면으로 넘어가기")
                        print(selectedFields[selectedFieldIndex])
                        //selectedFieldView(selectedFields: selectedFields, selectedFieldIndex: Int16(selectedFieldIndex))
                        selectedFieldIndex += 1
                    }
                    
                    .background(selectedFieldIndex < selectedFields.count ? Color(red: 0, green: 122/255, blue: 1) : Color.white)
                    .disabled(selectedFieldIndex == selectedFields.count)
                    
                }//HStack - Previous, Next Button View
                .frame(width: 316, height: 16)
            }
        }
        .onAppear{
            //coredata Test용 DATA
            //shared.createTeam(emoticon: "👍", name: "team5", pinned: false, touch: Date())
//            let opt1 = shared.createOption(value: "feat", shortDesc: "기능추가", detailDesc: "코드 기능추가")
//            let opt2 = shared.createOption(value: "fix", shortDesc: "수정", detailDesc: "코드수정")
//            let opt3 = shared.createOption(value: "Docs", shortDesc: "문서수정", detailDesc: "문서수정수정")
//            let field1 = shared.createField(name: "작업", type: 2, options: [opt1, opt2, opt3])
//            let field2 = shared.createField(name: "날짜", type: 4)
//            let field3 = shared.createField(name: ":", type: 1)
//            let field4 = shared.createField(name: "수정사항", type: 3)
//
//
//            shared.updateTeam(team: teamNames[0], emoticon: "🌻", name: "teamteam", pinned: false, touch: Date(), fields: [field1, field2, field3, field4])
            //shared.createTeam(emoticon: "👍", name: "team7", pinned: false, touch: Date())
            teamNames = shared.readTeam()
            
            
        }
    }
    //git commit message copied function
    func copyToPaste(text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
    
    
    
    
    
    
}



