//
//  TemplateView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/16.
//

import SwiftUI
import WrappingHStack

fileprivate struct BlockCell: View {
    @StateObject var field: Field
    var selected: Bool = false
    
    var body: some View {
        Text(field.wrappedName)
            .padding(4)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(selected ? Color.accentColor : Color.gray)
            )
    }
}

fileprivate struct TextCell: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
}

fileprivate enum BlockType: String {
    case text
    case date
    case option
    case constant
}

// MARK: - TemplateView
struct TemplateView: View {
    @State var team: Team
    
    @State private var data: [Any] = []
    
    @Binding var selected: Field?
    
    @State private var renderId: UUID = UUID()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        VStack {
            blocksView
                .padding()
            Spacer()
            blockOptionView
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black)
        )
    }
    
    // MARK: - Blocks View
    var blocksView: some View {
        ScrollView {
            WrappingHStack(data, id: \.self, alignment: .leading, spacing: .constant(8), lineSpacing: 4) { d in
                
                if let d = d as? String {
                    // data가 String이고 '+'이면 추가 버튼
                    if d == "+" {
                        Button {
                            let field = Field(context: managedObjectContext)
                            field.name = "block_new_field_name".localized
                            field.type = Field.FieldType.constant.rawValue
                            field.order = 0
                            field.typeBasedString = ""
                            
                            var fields = self.team.wrappedFields
                            fields.append(field)
                            
                            team.fields = NSOrderedSet(array: fields)
                            
                            PersistenceController.shared.saveContext()
                            
                            reloadData()
                            
                        } label: {
                            Text("+")
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.plain)
                        .frame(width: 24, height: 24)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray)
                        )
                    } else {
                        Text(d)
                            .foregroundColor(.white)
                    }
                } else if let d = d as? Field {
                    BlockCell(field: d, selected: selected?.id == d.id)
                        .onTapGesture {
                            selected = d
                        }
                        .contextMenu {
                            contextMenuBuilder(d)
                        }
                }
            }
            
        }
        .onLoad {
            reloadData()
        }
    }
    
    func reloadData() {
        print(#function, "before: \(data.count)")
        data.removeAll()
        data.append("git commit -m \"")
        for field in team.wrappedFields {
            data.append(field)
        }
        data.append("+")
        data.append("\"")
        print(#function, "after: \(data.count)")
    }
    //: - Blocks View
    
    // MARK: Context Menu
    @ViewBuilder
    func contextMenuBuilder(_ field: Field) -> some View {
        if let fields = team.fields {
            // Move Left Button
            Button(role: .none) {
                let index = fields.index(of: field)
                let indexSet = IndexSet(integer: index)
                var newField = team.wrappedFields
                newField.move(fromOffsets: indexSet, toOffset: index - 1)
                team.fields = NSOrderedSet(array: newField)
                PersistenceController.shared.saveContext()
                
                reloadData()
                
            } label: {
                Label("block_context_move_left", systemImage: "arrow.left")
            }
            .disabled(fields.index(of: field) <= 0)
            
            // Move Right Button
            Button(role: .none) {
                let index = fields.index(of: field)
                let indexSet = IndexSet(integer: index)
                var newField = team.wrappedFields
                newField.move(fromOffsets: indexSet, toOffset: index + 1)
                team.fields = NSOrderedSet(array: newField)
                PersistenceController.shared.saveContext()
                
                reloadData()
                
            } label: {
                Label("block_context_move_right", systemImage: "arrow.right")
            }
            .disabled(fields.index(of: field) >= fields.count - 1)
            
            // Delete Button
            Button(role: .none) {
                let index = fields.index(of: field)
                var newField = team.wrappedFields
                newField.remove(at: index)
                team.fields = NSOrderedSet(array: newField)
                PersistenceController.shared.saveContext()
                
                reloadData()
                
            } label: {
                Label("block_context_delete", systemImage: "trash.fill")
            }
        }
    }
    
    // MARK: - Block Option View
    @State private var blockType: BlockType = .text
    @State private var title: String = ""
    
    var blockOptionView: some View {
        HStack {
            // MARK: Block Type
            VStack(alignment: .leading) {
                Text("option_block_type")
                Picker("", selection: $blockType) {
                    Text("option_block_type_constant")
                        .tag(BlockType.constant)
                    Text("option_block_type_text")
                        .tag(BlockType.text)
                    Text("option_block_type_date")
                        .tag(BlockType.date)
                    Text("option_block_type_option")
                        .tag(BlockType.option)
                }
            }
            // MARK: Block Title
            VStack(alignment: .leading) {
                Text("option_block_title")
                TextField("", text: $title)
                    .textFieldStyle(.plain)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                    )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray)
        )
    }
    //: - Block Option View
}
//: - TemplateView
