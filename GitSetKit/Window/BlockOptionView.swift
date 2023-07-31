//
//  BlockOptionView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/28.
//

import SwiftUI

fileprivate struct BlockType: Identifiable {
    var title: LocalizedStringKey
    var desc: LocalizedStringKey
    var type: Field.FieldType
    
    var id: Field.FieldType {
        self.type
    }
}

fileprivate struct BlockTypeSelectView: View {
    var blockTypes: [BlockType]
    @Binding var selected: Field.FieldType
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(blockTypes) { type in
                VStack {
                    HStack {
                        Spacer()
                        Text(type.title)
                            .font(.title2.bold())
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text(type.desc)
                            .foregroundColor(Colors.Text.secondary)
                        Spacer()
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selected == type.type ? Colors.Background.primarySelected : Colors.Background.primary)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 1)
                )
                .onTapGesture {
                    self.selected = type.type
                }
            }
        }
    }
}

struct BlockOptionView: View {
    @Binding var selectedTeam: Team?
    @Binding var selectedField: Field?
    
    @State private var title: String = ""
    @State private var fieldChanged: Bool = false
    
    @State private var blockType: Field.FieldType = .input
    private var blockTypes: [BlockType] {
        [
            BlockType(title: "option_block_type_option", desc: "option_block_type_option_desc", type: .option),
            BlockType(title: "option_block_type_constant", desc: "option_block_type_constant_desc", type: .constant),
            BlockType(title: "option_block_type_text", desc: "option_block_type_text_desc", type: .input),
            BlockType(title: "option_block_type_date", desc: "option_block_type_date_desc", type: .date)
        ]
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("block_option_type")
                    .font(.title2)
                    .foregroundColor(Colors.Text.secondary)
                Spacer()
            }
            .padding(.horizontal, 16)
            
            BlockTypeSelectView(blockTypes: blockTypes, selected: $blockType)
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
