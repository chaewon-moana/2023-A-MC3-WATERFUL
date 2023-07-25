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
    
    var body: some View {
        TextEditor(text: $inputText)
            .background(Color("quaternary"))
            .foregroundColor(.black)
            .frame(width:310, height: 101)
            .textFieldStyle(.plain)
            .multilineTextAlignment(.leading)
            .scrollContentBackground(.hidden)
        
        
        if inputText.isEmpty {
            Text("   ex) 알림 버튼 추가")
                .foregroundColor(.gray)
                .frame(width: 310, height: 100 ,alignment: .topLeading)
                
        }
    }
}



