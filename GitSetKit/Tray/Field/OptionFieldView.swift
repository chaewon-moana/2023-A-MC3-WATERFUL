//
//  OptionFieldView.swift
//  GitSetKit
//
//  Created by Cho Chaewon on 2023/07/24.
//

import Foundation
import SwiftUI
//import CoreData
import WrappingHStack

struct OptionFieldView: View {

    @Binding var outputMessage: [String]
    @Binding var selectedFieldIndex: Int
    @Binding var selectedField: Field?
    @Binding var selectedOptions: [Option]
    
    @State var selectedOptionValue: String!
    @State private var optionList: [Option] = []
    @State private var value: [String] = [""]
    @State private var shortDesc: [String] = [""]
    @State private var detailDesc: [String] = [""]
    
    @State private var isHoverButtons: [Int: Bool] = [:]
    @State private var selectedButtonIndex: Int = 0
    
    
    var body: some View {
        ScrollView {
            WrappingHStack(Array(selectedOptions.enumerated()), id: \.self, alignment: .leading, spacing: .constant(4), lineSpacing: 0) { idx, opt in
                
                Button(action: {
                    let selectedOptionValue = opt.value ?? "optionField 오류"
                    outputMessage[selectedFieldIndex] = selectedOptionValue
                }, label: {
                    Text(opt.value ?? "optionField 오류")
                })
                
                .onHover { isHover in
                    isHoverButtons[idx] = isHover
                }
                .buttonStyle(.plain)
                .frame(width: 72, height: 40)
                .background(isHoverButtons[idx] ?? false ? Color.blue: Color.white)
                .cornerRadius(8)
                .padding(.bottom, selectedOptions.count > 8 ? 2 : 4)
            }//WrappingHstack
            .foregroundColor(.black)
            
        }//ScrollView
        .frame(width: 300, height: 88)
    }
    
}

