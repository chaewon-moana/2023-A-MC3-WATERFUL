//
//  BlockOptionView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/28.
//

import SwiftUI

fileprivate struct BlockTypeSelectView: View {
    @Binding var selected: Field.FieldType
    
    var body: some View {
        HStack(spacing: 8) {
            makeCell(title: "option_block_type_option", icon: Image(systemName: "square.grid.2x2"), type: .option)
            makeCell(title: "option_block_type_text", icon: Image(systemName: "text.alignleft"), type: .input)
            makeCell(title: "option_block_type_date", icon: Image(systemName: "calendar"), type: .date)
            Divider()
                .frame(height: 48)
            makeCell(title: "option_block_type_constant", type: .constant)
        }
    }
    
    @ViewBuilder private func makeCell(title: LocalizedStringKey, icon: Image? = nil, type: Field.FieldType) -> some View {
            HStack {
                Spacer()
                if let icon = icon {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                }
                Text(title)
                    .font(.system(size: 16))
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 4)
            .foregroundColor(selected == type ? .accentColor : Colors.Text.primary)
            .background {
                if selected == type {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                Colors.Background.selected
                                    .shadow(.inner(color: .accentColor.opacity(0.5), radius: 4, x: 0, y: 2))
                            )
                            .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.accentColor, lineWidth: 2)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Colors.Background.primary)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)
                }
            }
            .onTapGesture {
                self.selected = type
            }
    }
}

struct BlockOptionView: View {
    @Binding var selectedTeam: Team?
    @Binding var selectedField: Field?
    
    @State private var title: String = ""
    @State private var fieldChanged: Bool = false
    
    @State private var blockType: Field.FieldType = .input
    
    var body: some View {
        VStack {
            HStack {
                Text("block_option_type")
                    .font(.title2)
                    .foregroundColor(Colors.Text.secondary)
                Spacer()
            }
            .padding(.horizontal, 16)
            
            BlockTypeSelectView(selected: $blockType)
                .onAppear(perform: {
                    if let selectedField = selectedField {
                        blockType = selectedField.wrappedType
                    }
                })
                .onChange(of: self.selectedField) { newValue in
                    if let selectedField = selectedField {
                        fieldChanged = true
                        blockType = selectedField.wrappedType
                    }
                }
                .onChange(of: blockType) { newValue in
                    if let selectedField = selectedField, !fieldChanged {
                        let field = PersistenceController.shared.updateField(field: selectedField, type: blockType.rawValue, typeBasedString: "")
                        self.selectedField = nil
                        self.selectedField = field
                        
                    }
                    fieldChanged = false
                }
        }
    }
    //: - Block Option View
}
