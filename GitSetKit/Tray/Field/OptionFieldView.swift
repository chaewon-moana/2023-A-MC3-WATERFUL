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
    
    @State var selectedOptionValue: String!
    @Binding var outputMessage: [String]
    @Binding var selectedFieldIndex: Int
    @Binding var selectedField: Field?
    @Binding var selectedOptions: [Option]
    
    //@State var selectedOptions: [Option] = []
    
    @State private var optionList: [Option] = []
    @State private var value: [String] = [""]
    @State private var shortDesc: [String] = [""]
    @State private var detailDesc: [String] = [""]
    
    @State private var isHoverButtons: [Int: Bool] = [:]

    
    var body: some View {
        ScrollView {
            WrappingHStack(Array(selectedOptions.enumerated()), id: \.self, alignment: .leading, spacing: .constant(4), lineSpacing: 0) { idx, opt in
              
                Button(action: {
                    let selectedOptionValue = opt.value ?? "optionField 오류"
                    outputMessage[selectedFieldIndex] = selectedOptionValue
                }, label: {
                    Text(opt.value ?? "optionField 오류")
                })
                .focusable()
//                .onFocusChange { isFocused in
//                    isHoverButtons[idx] = isFocused
//                    print("변경")
//                    
//                }
                .onHover { isHover in
                    isHoverButtons[idx] = isHover
                }
                .onAppear{
                        isHoverButtons[0] = true
                }
                
                .buttonStyle(.plain)
                .frame(width: 72, height: 40)
//                .background(isHoverButtons[idx] ?? false ? Colors.Gray.quaternary : Color.white)
                .background(isHoverButtons[idx] ?? false ? Color.blue: Color.white)
                .cornerRadius(8)
                .padding(.bottom, selectedOptions.count > 8 ? 2 : 4)
            }//WrappingHstack
            .foregroundColor(.black)
        }//ScrollView
        .frame(width: 300, height: 88)
//        .onReceive(NotificationCenter.default.publisher(for: NSView.keyDownEvent)) { event in
//                    // 방향키로 Hover 상태 변경하기
//                    if let keyEvent = event as? NSEvent,
//                       keyEvent.keyCode == 125 { // Down Arrow Key
//                        changeHoverButton(index: selectedFieldIndex + 1)
//                    } else if let keyEvent = event as? NSEvent,
//                              keyEvent.keyCode == 126 { // Up Arrow Key
//                        changeHoverButton(index: selectedFieldIndex - 1)
//                    }
//                }

        .onChange(of: selectedField){ newValue in
            if newValue?.wrappedType.rawValue == 2 {
                selectedOptions = newValue!.wrappedOptions
            }
        }
 
    }

}

