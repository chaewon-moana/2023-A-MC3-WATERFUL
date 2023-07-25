//
//  TemplateView.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/16.
//

import SwiftUI
import WrappingHStack

// 선택 가능한 Block Cell
fileprivate struct BlockCell: View {
    @StateObject var field: Field
    var selected: Bool = false
    
    var body: some View {
        Text(field.wrappedName)
            .font(.custom("SourceCodePro-Light", size: 17)) // FIXME: 폰트 적용 안되는 문제
            .foregroundColor(selected ? Color.black : Color.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(selected ? Colors.Gray.quaternary : Colors.Gray.secondary)
            )
    }
}

// "git commit -m" 등 선택 불가능한 Cell
fileprivate struct TextCell: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.custom("SourceCodePro-Light", size: 17)) // FIXME: 폰트 적용 안되는 문제
            .foregroundColor(.white)
    }
}

// MARK: - TemplateView
struct TemplateView: View {
    // 선택된 Team
    @Binding var team: Team?
    
    // WrappingHStack에서 사용되는 Data
    // (일반 텍스트와 선택 가능한 Block Cell, Add Button 모두 포함)
    @State private var data: [Any] = []
    
    // 선택된 Field
    @Binding var selected: Field?
    
    // 데이터 변경 시 ScrollView 및 WrappingHstack을 다시 랜더링하기 위한 변수
    @State private var renderId: UUID = UUID()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        if team != nil {
            VStack {
                // Field(= Block)들을 표시하는 View
                blocksView
                    .padding()
                
                Spacer()
                
                // Field를 선택했을 때 해당 Field의 옵션을 변경하는 View
                blockOptionView
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Colors.Fill.codeBG)
            )
            .onChange(of: team) { _ in
                reloadData()
            }
        } else {
            Spacer()
        }
    }
    
    // MARK: - Blocks View
    var blocksView: some View {
        ScrollView {
            // WrappingHStack이 VStack, HStack을 적절히 구분하여 줄바꿈해줄 수 있도록 하려면 ForEach문을 사용해서는 안됨
            WrappingHStack(data, id: \.self, alignment: .leading, spacing: .constant(8), lineSpacing: 4) { d in
                
                if let d = d as? String {
                    // data가 String이고, 값이 '+'이면 추가 버튼
                    if d == "+" {
                        Button {
                            let field = Field(context: managedObjectContext)
                            field.name = "block_new_field_name".localized
                            field.type = Field.FieldType.constant.rawValue
//                            field.order = 0
                            field.typeBasedString = ""
                            
                            var fields = self.team!.wrappedFields
                            fields.append(field)
                            
                            team!.fields = NSOrderedSet(array: fields)
                            
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
                        TextCell(text: d)
                    }
                } else if let d = d as? Field {
                    // data가 Field이면 Block으로 표시
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
        .id(renderId)
        .onLoad {
            reloadData()
        }
    }
    //: - Blocks View
    
    // MARK: - Reload Data
    func reloadData() {
        guard let fields = team?.wrappedFields else {
            return
        }
        data.removeAll()
        data.append("git commit -m \"")
        for field in fields {
            data.append(field)
        }
        data.append("+")
        data.append("\"")
        
        renderId = UUID()
    }
    //: - Reload Data
    
    // MARK: Context Menu
    @ViewBuilder
    func contextMenuBuilder(_ field: Field) -> some View {
        if let fields = team!.fields {
            // Move Left Button
            Button(role: .none) {
                let index = fields.index(of: field)
                let indexSet = IndexSet(integer: index)
                let newField = team!.fields?.mutableCopy() as! NSMutableOrderedSet
                newField.moveObjects(at: indexSet, to: index - 1)
                team!.fields = newField
                
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
                let newField = team!.fields?.mutableCopy() as! NSMutableOrderedSet
                newField.moveObjects(at: indexSet, to: index + 1)
                team!.fields = newField
                
                PersistenceController.shared.saveContext()
                
                reloadData()
                
            } label: {
                Label("block_context_move_right", systemImage: "arrow.right")
            }
            .disabled(fields.index(of: field) >= fields.count - 1)
            
            // Delete Button
            Button(role: .none) {
                // 실제 데이터 삭제
                PersistenceController.shared.deleteField(field)
                
                // 현재 View의 Team에서 Field 삭제
                let index = fields.index(of: field)
                var newField = team!.wrappedFields
                newField.remove(at: index)
                team!.fields = NSOrderedSet(array: newField)
                PersistenceController.shared.saveContext()
                
                // 데이터 다시 로드
                reloadData()
                
            } label: {
                Label("block_context_delete", systemImage: "trash.fill")
            }
        }
    }
    
    // MARK: - Block Option View
    @State private var blockType: Field.FieldType = .input
    @State private var title: String = ""
    
    var blockOptionView: some View {
        HStack {
            // MARK: Block Title
            VStack(alignment: .leading) {
                Text("option_block_title")
                    .foregroundColor(Colors.Text.primary)
                TextField("", text: $title)
                    .textFieldStyle(.plain)
                    .padding(2)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.white)
                            .shadow(radius: 1)
                    )
                    .onSubmit {
                        if let selected = selected {
                            PersistenceController.shared.updateField(field: selected, name: title)
                        }
                    }
            }
            .frame(maxWidth: 120)
            // MARK: Block Type
            VStack(alignment: .leading) {
                Text("option_block_type")
                    .foregroundColor(Colors.Text.primary)
                    .padding(.leading, 6)
                Picker("", selection: $blockType) {
                    Text("􀌀 "+"option_block_type_text".localized)
                        .tag(Field.FieldType.input)
                    Text("􀇷 "+"option_block_type_option".localized)
                        .tag(Field.FieldType.option)
                    Text("􀉉 "+"option_block_type_date".localized)
                        .tag(Field.FieldType.date)
                    Text("􀅯 "+"option_block_type_constant".localized)
                        .tag(Field.FieldType.constant)
                }
                .shadow(radius: 1)
                .onChange(of: blockType, perform: { newValue in
                    if let selected = selected {
                        PersistenceController.shared.updateField(field: selected, type: blockType.rawValue, typeBasedString: "")
                    }
                    selected = nil
                })
            }
            .frame(maxWidth: 120)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Colors.Gray.secondary)
        )
        .onChange(of: selected) { newValue in
            if let selected = selected {
                blockType = Field.FieldType(rawValue: selected.type) ?? .input
                title = selected.name ?? "option_block_title_empty".localized
            }
        }
    }
    //: - Block Option View
}
//: - TemplateView


