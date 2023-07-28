//
//  TrayView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/15.
//

import Foundation
import SwiftUI
import CoreData

struct TrayView: View {
    
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let shared = PersistenceController.shared
    
    @State private var teamNames: [Team] = []
    @State private var selectedTeam: Team?
    @State private var selectedFields: [Field] = []
    @State private var selectedField: Field?
    @State private var selectedFieldIndex = 0
    @State private var selectedFieldsCount = 0
    
    
    @State var outputMessage: [String] = []
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 4)
                .frame(width:340,height:390)
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack{
                
                TeamSelectedView(teamNames: $teamNames, selectedTeam: $selectedTeam, outputMessage: $outputMessage)
                    .onChange(of: selectedTeam){ newValue in
                        selectedFields = newValue!.wrappedFields
                        selectedFieldIndex = 0
                        selectedFieldsCount = selectedFields.count
                        outputMessage = addOutput(selectedFields: selectedFields)
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
                        
                        WorkFieldView(selectedFields: $selectedFields, outputMessage: $outputMessage, selectedFieldIndex: $selectedFieldIndex)
                        
                    }//ZStack
                    .frame(width: 316, height: 120)
                    
                }//WorkView
                .frame(width: 316, height: 146)
                
                VStack{
                    Text("작업")
                        .frame(width: 316, height: 18, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(size:16))
                    
                    FieldView(selectedFields: $selectedFields, selectedField: $selectedField, outputMessage: $outputMessage, selectedFieldIndex: $selectedFieldIndex)
                        .onChange(of: selectedTeam){ newValue in
                            selectedFields = newValue!.wrappedFields
                        }
                    
                        .frame(width: 316, height: 104)
                        .opacity(1)
                        .ignoresSafeArea()
                }
                .frame(width: 316, height: 130)
                
                ButtonView(selectedFieldIndex: $selectedFieldIndex, outputMessage: $outputMessage, selectedFieldsCount: $selectedFieldsCount)
                    .frame(width: 316, height: 16)
            }
        }
        .onAppear{
            //            coredata Test용 DATA
            //            shared.createTeam(emoticon: "👍", name: "team5", pinned: false, touch: Date())
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
            //            shared.createTeam(emoticon: "👍", name: "team7", pinned: false, touch: Date())
            teamNames = shared.readTeam()
        }
    }
    //outputMessage에 값을 넣는 함수
    func addOutput(selectedFields: [Field]) -> [String] {
        var outputMessage: [String] = []
        
        for field in selectedFields {
            let tmp = "\(field.wrappedName)"
            outputMessage.append(tmp)
        }
        return outputMessage
    }
    
    
    
}



