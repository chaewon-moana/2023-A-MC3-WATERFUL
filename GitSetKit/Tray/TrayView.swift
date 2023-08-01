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
    @State private var selectedOptions: [Option] = []
    @State private var selectedFieldIndex = 0
    @State private var selectedFieldsCount = 0
    @State private var selectedDate: String = ""
    @State private var fieldName: String = "작업-"
    
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
                        selectedFieldIndex = 0
                        selectedFieldsCount = selectedFields.count
                        outputMessage = addOutput(selectedFields: selectedFields)
                        fieldName = selectedFields[selectedFieldIndex].wrappedName
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
                    Text(fieldName)
                        .frame(width: 316, height: 18, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(size:16))
                        .onChange(of: selectedFieldIndex){ newValue in
                   
                                fieldName = selectedFields[newValue].wrappedName
                            
                        }
                    
                    
                    FieldView(selectedFields: $selectedFields, selectedField: $selectedField, outputMessage: $outputMessage, selectedFieldIndex: $selectedFieldIndex, selectedOptions: $selectedOptions, selectedDate: $selectedDate)
                        .onChange(of: selectedTeam){ newValue in
                            selectedFieldIndex = 0
                            selectedFields = newValue!.wrappedFields
                        }

                    
                        .frame(width: 316, height: 104)
                        .cornerRadius(4)
                        .opacity(1)
                        .ignoresSafeArea()
                }
                .frame(width: 316, height: 130)
                
                HStack{
                    Text("\(Image(systemName: "keyboard")) [shift+방향키]로 다음으로 넘어갈 수 있어요!")
                        .foregroundColor(Colors.Text.secondary)
                        .font(.system(size: 11))
                    
                    Spacer()
                    
                    Button(action: {
                        selectedFieldIndex -= 1
                    }, label: {
                        Text("이전")
                            .foregroundColor((selectedFieldIndex != 0 ? Color.white : Color.black))
                    })
                    .frame(width: 40, height: 24)
                    .buttonStyle(.plain)
                    .disabled(selectedFieldIndex == 0)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(selectedFieldIndex != 0 ? Color(red: 0, green: 122/255, blue: 1) : Color.white)
                    )
                    .onAppear {
                        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { event in
                            if event.modifierFlags.contains(.shift) {
                                NSEvent.addLocalMonitorForEvents(matching: .keyDown) { innerEvent in
                                    if innerEvent.keyCode == 123 {
                                        if selectedFieldIndex > 0 {
                                            selectedFieldIndex -= 1
                                        }
                                        return nil
                                    }
                                    return innerEvent
                                }
                            }
                            return event
                        }
                    }
                    
                    
                    
                    Button(action: {
                        print(selectedFieldIndex)
                        print(outputMessage)
                        selectedFieldIndex += 1
                    }, label: {
                        Text("다음")
                            .foregroundColor((selectedFieldIndex != selectedFieldsCount ? Color.white : Color.black))
                    })
                    .frame(width: 40, height: 24)
                    .buttonStyle(.plain)
                    .disabled(selectedFieldIndex == (selectedFieldsCount-1))
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(selectedFieldIndex != (selectedFieldsCount-1) ? Color(red: 0, green: 122/255, blue: 1) : Color.white)
                    )
                    .onAppear {
                        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { event in
                            if event.modifierFlags.contains(.shift) {
                                NSEvent.addLocalMonitorForEvents(matching: .keyDown) { innerEvent in
                                    if innerEvent.keyCode == 124 {
                                        if selectedFieldIndex < selectedFieldsCount {
                                            selectedFieldIndex += 1
                                        }
                                        return nil
                                    }
                                    return innerEvent
                                }
                            }
                            return event
                        }
                    }

                }//HStack - Previous, Next Button View
                .frame(width: 316, height: 16)
            }
        }
        .onAppear{
            //            coredata Test용 DATA
            //                        shared.createTeam(emoticon: "👍", name: "team5", pinned: false, touch: Date())
            //                        let opt1 = shared.createOption(value: "feat", shortDesc: "기능추가", detailDesc: "코드 기능추가")
            //                        let opt2 = shared.createOption(value: "fix", shortDesc: "수정", detailDesc: "코드수정")
            //                        let opt3 = shared.createOption(value: "Docs", shortDesc: "문서수정", detailDesc: "문서수정수정")
            //                        let field1 = shared.createField(name: "작업", type: 2, options: [opt1, opt2, opt3])
            //                        let field2 = shared.createField(name: "날짜", type: 4)
            //                        let field3 = shared.createField(name: ":", type: 1)
            //                        let field4 = shared.createField(name: "수정사항", type: 3)
            //
            //                        shared.updateTeam(team: teamNames[0], emoticon: "🌻", name: "teamteam", pinned: false, touch: Date(), fields: [field1, field2, field3, field4])
            //                        shared.createTeam(emoticon: "👍", name: "team7", pinned: false, touch: Date())
            
            teamNames = shared.readTeam()
            
        }
    }
    
    //outputMessage에 값을 넣는 함수
    func addOutput(selectedFields: [Field]) -> [String] {
        var outputMessage: [String] = []
        var tmp: String
        
        for field in selectedFields {
            if field.type == 4 {
                let today = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "\(field.wrappedTypeBasedString)"
                selectedDate = "\(field.wrappedTypeBasedString)"
                let dateString = dateFormatter.string(from: today)
                
                tmp = dateString
            } else {
                tmp = "\(field.wrappedName)"
            }
            outputMessage.append(tmp)
        }
        return outputMessage
    }
    
    
    
}



