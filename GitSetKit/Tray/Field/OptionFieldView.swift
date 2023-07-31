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
    
    var body: some View {
        ScrollView {
            WrappingHStack(selectedOptions, id: \.self, alignment: .leading, spacing: .constant(4), lineSpacing: 8) {opt in
              
                Button(action: {
                    let selectedOptionValue = opt.value ?? "optionField 오류"
                    outputMessage[selectedFieldIndex] = selectedOptionValue
                }, label: {
                    Text(opt.value ?? "optionField 오류")
                })
                .buttonStyle(.plain)
                //.frame(width: 72, height: 40)
                .frame(width: 72, height: selectedOptions.count > 8 ? 34 : 40)
                .background(Color.white)
                .cornerRadius(8)
                //.padding(.bottom, selectedOptions.count > 8 ? 0.4 : 100)

            }//WrappingHstack
            
            .foregroundColor(.black)
        }//ScrollView
        .frame(width: 300, height: 88)

        
//OptionsBlockSettingview - 참고자료
//        .onChange(of: selectedFieldIndex) { newValue in
//            if let options = selectedField?.wrappedOptions {
//                optionList = options
//                
//                for idx in 0..<optionList.count {
//                    value.append(optionList[idx].value ?? "")
//                    print(optionList[idx].value)
//                    shortDesc.append(optionList[idx].shortDesc ?? "")
//                    detailDesc.append(optionList[idx].detailDesc ?? "")
//                    //isHover.append(false)
//                }
//            }
//        }
        
//
        .onChange(of: selectedField){ newValue in
            if newValue?.wrappedType.rawValue == 2 {
                selectedOptions = newValue!.wrappedOptions
            }
            print(selectedOptions)
        }
        
        
        
        
    }
    
    
    
    
    
    
    
}

