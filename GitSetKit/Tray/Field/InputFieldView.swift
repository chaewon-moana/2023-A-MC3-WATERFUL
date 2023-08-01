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
    @Binding var inputText: String
    @Binding var outputMessage: [String]
    @Binding var selectedFieldIndex: Int
    
    var body: some View {
        TextEditor(text: $inputText)
            .background(Color("quaternary"))
            .foregroundColor(.black)
            .frame(width: 300, height: 88)
            .textFieldStyle(.plain)
            .multilineTextAlignment(.leading)
            .scrollContentBackground(.hidden)
            .onChange(of: inputText){ newValue in
                outputMessage[selectedFieldIndex] = newValue
            }
        
        if inputText.isEmpty {
            Text("   ex) 알림 버튼 추가")
                .foregroundColor(Colors.Text.secondary)
                .frame(width: 300, height: 88, alignment: .topLeading)
            
        }
        
    }
    
}



