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
                
                TextField("", text: $title)
                    .textFieldStyle(.plain)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Colors.Background.primary)
                            .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)
                    )
                    .onAppear {
                        title = selected.name ?? ""
                    }
                    .onChange(of: selected) { newValue in
                        title = selected.name ?? ""
                    }
                    .onSubmit {
                        let field = PersistenceController.shared.updateField(field: selected, name: title)
                        self.selected = nil
                        self.selected = field
                    }
                    
                
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
