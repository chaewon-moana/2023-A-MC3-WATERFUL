//
//  WorkFieldView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/27.
//

import Foundation
import SwiftUI
import WrappingHStack

struct WorkFieldView: View {
    
    @Binding var selectedFields: [Field]
    @Binding var outputMessage: [String]
    @Binding var selectedFieldIndex: Int
    
    @State private var gitCommitOn = true
    @State private var commitMessage: String = "git commit -m \""
    
    var body: some View {
        VStack{
            ScrollView {
                WrappingHStack(Array(selectedFields.enumerated()), id: \.self, alignment: .leading, spacing: .constant(4), lineSpacing: 12) { index, block in
                    
                    if gitCommitOn && index == 0 {
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
                            selectedFieldIndex = index
                            
                        }, label: {
                            Text(outputMessage[index])
                                .lineLimit(nil)
                                .padding(.leading, 8)
                                .padding(.trailing, 8)
                                .foregroundColor(Color.white)
                        })
                        .lineLimit(nil)
                        .padding(.leading, 4)
                        .padding(.trailing, 4)
                        .buttonStyle(.plain)
                        .frame(height: 18)
                        .background(Colors.Fill.codeBlockB)
                        .cornerRadius(4)
                        
                    }//else
                    
                    if index == (selectedFields.count-1) && gitCommitOn {
                        Text("\"")
                            .frame(width: 10)
                            .font(.custom("SourceCodePro-Light", size: 13))
                            .foregroundColor(.white)
                    }
                }//WrappingHStack
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
                    var combinedOutput = outputMessage.joined(separator: " ")
                    if gitCommitOn {
                        combinedOutput = commitMessage + combinedOutput + "\""
                    }
                    
                    print(combinedOutput)
                    copyToPaste(text: combinedOutput)
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
                .disabled(selectedFieldIndex != selectedFields.count - 1)
                .buttonStyle(.plain)
                .offset(x: 70, y: 10)
            }//HStack - copyAndPaste Button View
            .frame(width: 300, height: 20)
            .offset(x:0, y: -30)
            
        }//WorkFieldView
    }
    
    //git commit message copied function
    func copyToPaste(text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
    
    
}
