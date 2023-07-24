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
//import AppKit

struct TrayView: View {
    @FetchRequest(
        entity: Team.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Team.name, ascending: true)
        ]
    ) var teams: FetchedResults<Team>
    
    //dummy data
    @State private var teamNames = ["team1", "team2", "team3", "team4"]
    @State private var workBlocks = ["작업", "날짜", ":", "수정내용", "수정내용"]
    @State private var selectedView = ""
    
    let SourcePro = "SourceCodePro-Light"
    
    @State private var selectedTeamIndex = 0
    @State private var gitCommitOn = true
    @State var isShownMessage = false
    @State private var date = Date()
    @State private var commitMessage: String = "Git commit copied check"
    @State private var selectedBlock = ""
    
    
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .ignoresSafeArea()
                .frame(width:344,height:390)
                .opacity(0.3)
            
            VStack{
                
                TeamSelectedView()
                
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
                            ScrollView {
                                LazyVStack {
                                    //Field 작업
                                    //data에서 작업 받아와야함
                               
                                        if gitCommitOn {

                                            Text("git commit -m : ")
                                                .font(.custom("SourceCodePro-Light", size: 15))

                                            //.padding()
                                        }
                                   
                                        WrappingHStack(workBlocks, id: \.self, alignment: .leading, spacing: .constant(4), lineSpacing: 8) { block in
                                            Button(action: {
                                                selectedBlock = block
                                                //fieldSelected(field: selectedBlock)
                                                print(selectedBlock)
                                            }, label: {
                                                Text(block)
                                            })
                                            .buttonStyle(.plain)
                                            .frame(width: 64, height: 18)
                                            .background(Color.green)
                                            .cornerRadius(4)
                                            
                                            
                                        } //wrappingHStack
                                        .foregroundColor(.black)
                                    }
                                    .frame(width: 320, height: 101)
              
                                
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
                
                
                FieldView()
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
        
    }
    
    
    
    //git commit message copied function
    func copyToPaste(text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
    
    
    func fieldSelected(field: String) -> String {
        
        switch field {
        case "작업" :
            selectedView = "OptionFieldView"
        case "날짜" :
            selectedView = "DateFieldView"
        default:
            selectedView = "InputFieldView"
        }
        
        return selectedView
    }
    
    
    
    
}

struct TrayView_Previews: PreviewProvider {
    static var previews: some View {
        TrayView()
    }
}
