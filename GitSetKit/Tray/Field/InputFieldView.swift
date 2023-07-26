//
//  InputFieldView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/24.
//

import Foundation
import SwiftUI
import CoreData

struct InputFieldView: View {
    
    @State private var value: String = "ex) 알림 버튼 추가"
    @State private var inputText: String = ""
    @Binding var outputMessage: [Any]
    
    var body: some View {
        TextEditor(text: $inputText)
            .background(Color("quaternary"))
            .foregroundColor(.black)
            .frame(width:300, height: 88)
            .textFieldStyle(.plain)
            .multilineTextAlignment(.leading)
            .scrollContentBackground(.hidden)
            //.padding(.top, 4)
        
        
        if inputText.isEmpty {
            Text("   ex) 알림 버튼 추가")
                .foregroundColor(Colors.Text.secondary)
                .frame(width: 300, height: 88, alignment: .topLeading)
                
        }
        
        
    }
    
}



