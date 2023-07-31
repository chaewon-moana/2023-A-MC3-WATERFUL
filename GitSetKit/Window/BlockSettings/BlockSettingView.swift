//
//  BlockSettingView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/16.
//


import SwiftUI

struct BlockSettingView: View {
    @Binding var selected: Field?
    
    @State private var title: String = ""
    
    var body: some View {
        VStack {
            if let selected = selected {
                HStack {
                    Text("block_setting_title")
                        .font(.title2)
                        .foregroundColor(Colors.Text.secondary)
                    Spacer()
                }
                .padding(.horizontal, 16)     
                
                switch selected.wrappedType {
                case .constant:
                    OptionBlockSettingView(field: $selected) //ConstantBlockSettingView 어디갔,,,
                    
                case .option:
                    OptionBlockSettingView(field: $selected)
                    
                case .input:
                    InputBlockSettingView(field: $selected)
                    
                case .date:
                    DateBlockSettingView(field: $selected)
                }
            } else {
                Spacer()
            }
        }
    }
}
